//
//  UINavigationController+BackBarButtonItem.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/18.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (BackBarButtonItem)

- (void)customPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)customNoBackTitlePushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewControllerWithClassName:(NSString *)className;

@end
