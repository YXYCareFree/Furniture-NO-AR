//
//  YXYWebViewManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/19.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "YXYWebViewManager.h"
#import "YXYWKWebViewController.h"
#import "YXYUIWebViewController.h"

@implementation YXYWebViewManager

+ (void)openURL:(NSString *)url{
    
    if (IS_WKWebView) {
        
        YXYWKWebViewController * web = [YXYWKWebViewController new];
        web.url = url;
        PUSHCONTROLLER(web);
        
    }else{
        
        YXYUIWebViewController * web = [YXYUIWebViewController new];
        web.url = url;
        PUSHCONTROLLER(web);
    }
}

+ (void)openURL:(NSString *)url withType:(NSString *)type{

    if (IS_WKWebView) {
        
        YXYWKWebViewController * web = [YXYWKWebViewController new];
        web.code = url;
        web.type = type;

        PUSHCONTROLLER(web);
        
    }else{
        
        YXYUIWebViewController * web = [YXYUIWebViewController new];
        web.code = url;
        web.type = type;

        PUSHCONTROLLER(web);
    }
}

+ (void)openURL:(NSString *)url withType:(NSString *)type forSearch:(NSString *)search isAr:(NSString *)isAr{
    
    
    if (IS_WKWebView) {
        
        YXYWKWebViewController * web = [YXYWKWebViewController new];
        web.code = url;
        web.type = type;
        web.forSearch = search;
        web.isAr = isAr;

        PUSHCONTROLLER(web);
        
    }else{
        
        YXYUIWebViewController * web = [YXYUIWebViewController new];
        web.code = url;
        web.type = type;
        web.forSearch = search;
        web.isAr = isAr;
        
        PUSHCONTROLLER(web);
    }
}

@end
