//
//  YXYGatewayApiService.h
//  AFNet
//
//  Created by beyondSoft on 16/8/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXYRequest.h"

@interface YXYGatewayApiService : NSObject

+ (instancetype)shareApiService;

- (void)startRequest:(YXYRequest *)request;

@end
