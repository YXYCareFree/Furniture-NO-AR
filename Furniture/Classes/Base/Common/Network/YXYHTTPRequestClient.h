//
//  YXYHTTPRequestClient.h
//  AFNet
//
//  Created by beyondSoft on 16/5/9.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface YXYHTTPRequestClient : AFHTTPRequestOperationManager

+ (instancetype)shareManager;

-(AFHTTPRequestOperation *)getPath:(NSString *)URLString
                        apiVersion:(NSString *)version
                        parameters:(NSDictionary *)parameters
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(AFHTTPRequestOperation *)postPath:(NSString *)URLString
                         apiVersion:(NSString *)version
                         parameters:(NSDictionary *)parameters
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
