//
//  YXYJSMethodBase.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/20.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"
#import "WKWebViewJavascriptBridge.h"

@interface YXYJSMethodBase : NSObject

@property (nonatomic, strong) WKWebViewJavascriptBridge * WKWebViewbridge;
@property (nonatomic, strong) WebViewJavascriptBridge * UIWebViewBridge;
@property (nonatomic, copy) WVJBResponseCallback callBack;

+ (instancetype)shareYXYJSMethodBase;

- (void)registerJSMehod;

@end
