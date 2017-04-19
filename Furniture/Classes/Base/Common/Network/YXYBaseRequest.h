//
//  YXYBaseRequest.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

#import "YXYSuccessResponse.h"
#import "YXYFailureResponse.h"

typedef void(^RequestSuccessBlock)(YTKBaseRequest *request, YXYSuccessResponse * response);
typedef void(^RequestFailureBlock)(YTKBaseRequest *request, YXYFailureResponse * response);

@interface YXYBaseRequest : YTKRequest

- (void)startRequestSuccess:(RequestSuccessBlock)success failure:(RequestFailureBlock)failure;

@end
