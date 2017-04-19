//
//  YXYBaseRequest.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "YXYBaseRequest.h"

@implementation YXYBaseRequest

- (void)startRequestSuccess:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure{
    
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        id responseObject = request.responseJSONObject;
        id successfull = [request.responseJSONObject valueForKey:@"success"];
        if (successfull && [successfull boolValue]) {
            YXYSuccessResponse * response = [YXYSuccessResponse new];
            response.data = [responseObject valueForKey:@"data"];
            if (!response.data) {
                response.data = [responseObject valueForKey:@"content"];
            }
            response._rawResponse = request.responseString;
            
            if (success) {
                success(request, response);
            }
        }else{
            
            YXYFailureResponse * errorResponse = [YXYFailureResponse new];
            errorResponse.responseObject = responseObject;
            errorResponse.code = [responseObject valueForKey:@"errorCode"];
            errorResponse.msg = [responseObject valueForKey:@"errorMsg"];
            if (errorResponse.msg.length <= 0) {
                errorResponse.msg = @"系统异常请稍后再试";
            }
            errorResponse._rawResponse = request.responseString;
            if (failure) {
                failure(request, errorResponse);
            }
        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        YXYFailureResponse * errorResponse = [YXYFailureResponse new];
        NSError * error = request.requestOperationError;
        
        if (error.code == -1005) {
            errorResponse.msg = @"网络连接已中断，请检查网络设置";
        }else if (error.code == - 1009){
            errorResponse.msg = @"似乎已断开与互联网的连接，请检查网络设置";
        }else{
            errorResponse.msg = @"系统异常，请稍后再试";
        }
        
        errorResponse.rawError = error;
        errorResponse._rawResponse = request.responseString;
        
        if (failure) {
            failure(request, errorResponse);
        }
    }];
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPost;
}


@end
