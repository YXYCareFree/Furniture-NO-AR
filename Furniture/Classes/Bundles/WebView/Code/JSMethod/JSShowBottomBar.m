//
//  JSShowBottomBar.m
//  Furniture
//
//  Created by 王小娜 on 2017/2/20.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "JSShowBottomBar.h"

@implementation JSShowBottomBar

- (void)handleJSMethodWithParams:(id)params callBack:(WVJBResponseCallback)callBack{
    
    GETCURRENTCONTROLLER.tabBarController.tabBar.hidden = NO;
}

@end
