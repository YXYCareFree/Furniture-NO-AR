//
//  JSMethodBase.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/22.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"

@interface JSMethodBase : NSObject

- (void)handleJSMethodWithParams:(id)params callBack:(WVJBResponseCallback)callBack;

@end
