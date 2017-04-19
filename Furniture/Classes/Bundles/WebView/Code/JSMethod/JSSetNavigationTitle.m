//
//  JSSetNavigationTitle.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/22.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "JSSetNavigationTitle.h"

@implementation JSSetNavigationTitle

- (void)handleJSMethodWithParams:(id)params callBack:(WVJBResponseCallback)callBack{
    
    GETCURRENTCONTROLLER.navigationItem.title = @"";
}
@end
