//
//  YXYJSMethodBase.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/20.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "YXYJSMethodBase.h"
#import <objc/runtime.h>

static NSString * className = nil;

@interface YXYJSMethodBase ()

@property (nonatomic, strong) NSDictionary * jsMethodList;

@end

@implementation YXYJSMethodBase

+ (instancetype)shareYXYJSMethodBase{
    
    static YXYJSMethodBase * base = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        base = [YXYJSMethodBase new];
        base.jsMethodList = [NSDictionary new];
    });
    return base;
}

- (void)registerJSMehod{
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"JSMethodList" ofType:@"plist"];
    NSDictionary * dic = [[NSDictionary alloc] initWithContentsOfFile:path];
    if (dic) {
        self.jsMethodList = dic;
    }
    
    NSLog(@"%@", WEBVIEW_TYPE);

    __weak YXYJSMethodBase * weakSelf = self;
//    WEAKSELF;
    for (NSString * name in self.jsMethodList) {
        
        if ([WEBVIEW_TYPE isEqualToString:@"WKWebView"]) {
            [self.WKWebViewbridge registerHandler:name handler:^(id data, WVJBResponseCallback responseCallback) {
                
                className = self.jsMethodList[name];
                [weakSelf performSelector:@selector(handleJSMethodWithParams:callBack:) withObject:data withObject:responseCallback];
            }];
        }else{
           
            [self.UIWebViewBridge registerHandler:name handler:^(id data, WVJBResponseCallback responseCallback) {
                
                className = self.jsMethodList[name];
                [weakSelf performSelector:@selector(handleJSMethodWithParams:callBack:) withObject:data withObject:responseCallback];
            }];
        }
    }
}

/**
 3.完整的消息转发
 */
// 我们首先要通过, 指定方法签名，若返回nil，则表示不处理。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSString *selName = NSStringFromSelector(aSelector);
    if ([selName isEqualToString:@"handleJSMethodWithParams:callBack:"]) {
        
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 通过anInvocation对象做很多处理，比如修改实现方法，修改响应对象等
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"%s", __func__);
    // 改变响应对象
    //    [anInvocation invokeWithTarget:[SXTPig new]];
    // 改变响应方法
    //    [anInvocation setSelector:@selector(newTestMethod1)];
    
    // 改变响应对象并改变响应方法
    [anInvocation setSelector:@selector(handleJSMethodWithParams:callBack:)];
    Class class = NSClassFromString(className);
    [anInvocation invokeWithTarget:[class new]];
}

// 消息没发实现会调用这个方法
- (void)doesNotRecognizeSelector:(SEL)aSelector
{
    NSLog(@"哈哈哈哈：%@", NSStringFromSelector(aSelector));
}

- (void)testBackWithData:(id)data callBack:(WVJBResponseCallback)callBack{
    
    NSLog(@"%s, %@", __FUNCTION__, data);
    if (callBack) {
        callBack(@"xixixi");
    }
}
@end
