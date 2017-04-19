//
//  YXYGatewayApiService.m
//  AFNet
//
//  Created by beyondSoft on 16/8/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "YXYGatewayApiService.h"
#import "YXYHTTPRequestClient.h"
#import "CTToastView.h"
#import "NetworkManager.h"
#import "NSString+MD5Addition.h"
#import "ArchiverManager.h"
/**
 *  这个类用于发送网络请求并处理一些异常情况
 */
@implementation YXYGatewayApiService

+ (instancetype)shareApiService{
    static YXYGatewayApiService * service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [YXYGatewayApiService new];
    });
    return service;
}

- (void)startRequest:(YXYRequest *)request{
    
    if (request.isCache) {//缓存操作
        [self handleCache:request];
    }

//    NSString * net = [NetworkManager getCurrentNetwork];
    NSString * net = [[NetworkManager new] getCurrentNetwork];
    if ([net isEqualToString:@"notReachable"]) {
        
        [CTToastView presentModelToastWithin:GETCURRENTCONTROLLER.view text:@"当前无网络,请检查网络" autoHidden:YES];
        return;
    }

    WEAKSELF;
    [[YXYHTTPRequestClient shareManager] postPath:request.apiName apiVersion:request.apiVersion parameters:request.params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        id success = [responseObject valueForKey:@"success"];
        if (success && [success boolValue]) {
            YXYResponse * response = [YXYResponse new];
            response.data = [responseObject valueForKey:@"data"];
            if (!response.data) {
                response.data = [responseObject valueForKey:@"content"];
            }
            response._rawResponse = operation.responseString;
            
            if ([self respondsToSelector:@selector(processResponse:response:)]) {
                [weakSelf processResponse:request response:response];
            }

        }else{
            
            YXYErrorResponse * errorResponse = [YXYErrorResponse new];
            errorResponse.responseObject = responseObject;
            errorResponse.code = [responseObject valueForKey:@"errorCode"];
            errorResponse.msg = [responseObject valueForKey:@"errorMsg"];
            if (errorResponse.msg.length <= 0) {
                errorResponse.msg = @"系统异常请稍后再试";
            }
            errorResponse._rawResponse = operation.responseString;
            if ([self respondsToSelector:@selector(processError:response:)]) {
                [weakSelf processError:request response:errorResponse];
            }
        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        YXYErrorResponse * errorResponse = [YXYErrorResponse new];
        if (error.code == -1005) {
            errorResponse.msg = @"网络连接已中断，请检查网络设置";
        }else if (error.code == - 1009){
            errorResponse.msg = @"似乎已断开与互联网的连接，请检查网络设置";
        }else{
            errorResponse.msg = @"系统异常，请稍后再试";
        }
        
        errorResponse.rawError = error;
        errorResponse._rawResponse = operation.responseString;
        
        if ([self respondsToSelector:@selector(processError:response:)]) {
            [weakSelf processError:request response:errorResponse];
        }
    }];
}

- (void)processResponse:(YXYRequest *)request response:(YXYResponse *)response{
    if (request.success) {
        request.success(response, nil);
    }
}

- (void)processError:(YXYRequest *)request response:(YXYErrorResponse *)errorResponse{
    if (request.failure) {
        request.failure(errorResponse);
    }
}

- (void)handleCache:(YXYRequest *)request{
 
    NSString * filePath = [AR_CACHES_PATH stringByAppendingPathComponent:[request.apiName stringFromMD5]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:nil]) {
        NSArray * data = [ArchiverManager unArchiveNSArrayWithPath:filePath];
//        NSLog(@"归档==%@",data);
        
        if (request.success) {
            request.success(nil, data);
        }
    }
}

@end
