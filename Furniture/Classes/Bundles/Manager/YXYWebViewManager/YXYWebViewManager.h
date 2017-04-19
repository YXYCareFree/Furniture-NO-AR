//
//  YXYWebViewManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/19.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYWebViewManager : NSObject

+ (void)openURL:(NSString *)url withType:(NSString *)type;

+ (void)openURL:(NSString *)url withType:(NSString *)type forSearch:(NSString *)search isAr:(NSString *)isAr;

+ (void)openURL:(NSString *)url;

@end
