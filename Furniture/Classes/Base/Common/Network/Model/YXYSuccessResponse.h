//
//  YXYSuccessResponse.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYSuccessResponse : NSObject

//返回的数据
@property (nonatomic, retain) id data;
@property (nonatomic, copy) NSString * api;
@property (nonatomic, copy) NSString * ret;
//api调用的版本
@property (nonatomic, copy) NSString * apiVersion;
//原始response数据
@property (nonatomic, copy) NSString * _rawResponse;

@end
