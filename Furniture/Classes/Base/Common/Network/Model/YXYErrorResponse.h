//
//  YXYErrorResponse.h
//  Furniture
//
//  Created by 王小娜 on 2017/2/6.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYErrorResponse : NSObject

@property (nonatomic, assign) NSInteger httpResponseeCode;  //http响应吗
@property (nonatomic, strong) NSString * code;              //错误码
@property (nonatomic, strong) NSString * msg;               //错误信息

@property (nonatomic, strong) NSString * subCode;           //子错误码
@property (nonatomic, strong) NSString * subMsg;            //子错误信息

@property (nonatomic, strong) NSError * rawError;           //原始错误

@property (nonatomic, strong) id responseObject;

@property (nonatomic, copy) NSString * _rawResponse;

@end
