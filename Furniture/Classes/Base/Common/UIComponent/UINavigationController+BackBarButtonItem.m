//
//  UINavigationController+BackBarButtonItem.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/18.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "UINavigationController+BackBarButtonItem.h"

@implementation UINavigationController (BackBarButtonItem)

- (void)customPushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    viewController.hidesBottomBarWhenPushed = YES;
    self.navigationBar.tintColor = COLOR_MAIN;
    [self pushViewController:viewController animated:YES];
}

- (void)customNoBackTitlePushViewController:(UIViewController *)viewController animated:(BOOL)animated{
   
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.tintColor = COLOR_MAIN;
    viewController.hidesBottomBarWhenPushed = YES;
    [self pushViewController:viewController animated:YES];
}

- (void)pushViewControllerWithClassName:(NSString *)className{
    
    UIViewController * vc = [NSClassFromString(className) new];
    [self customNoBackTitlePushViewController:vc animated:YES];
}
@end
