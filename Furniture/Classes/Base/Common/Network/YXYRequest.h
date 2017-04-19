//
//  YXYRequest.h
//  AFNet
//
//  Created by beyondSoft on 16/8/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YXYErrorResponse.h"
#import "YXYResponse.h"

typedef void(^SuccessBlock)(YXYResponse * response, id cacheData);
typedef void(^FailureBlock)(YXYErrorResponse * response);

typedef NS_ENUM (NSInteger, YXYHTTPMethod){
    YXYHTTPMethodPOST,
    YXYHTTPMethodGET
};

@interface YXYRequest : NSObject

@property (nonatomic, strong) NSString * apiName;

@property (nonatomic, strong) NSString * apiVersion;

@property (nonatomic, strong) NSDictionary * params;

@property (nonatomic, assign) YXYHTTPMethod method;

@property (nonatomic, copy) SuccessBlock success;

@property (nonatomic, copy) FailureBlock failure;

@property (nonatomic, assign) BOOL isCache;//是否队请求结果进行缓存

@end
