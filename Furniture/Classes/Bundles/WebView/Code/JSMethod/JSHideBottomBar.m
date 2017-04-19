//
//  JSHideBottomBar.m
//  Furniture
//
//  Created by 王小娜 on 2017/2/20.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "JSHideBottomBar.h"

@implementation JSHideBottomBar
- (void)handleJSMethodWithParams:(id)params callBack:(WVJBResponseCallback)callBack{
    
    GETCURRENTCONTROLLER.tabBarController.tabBar.hidden = YES;
}
@end
