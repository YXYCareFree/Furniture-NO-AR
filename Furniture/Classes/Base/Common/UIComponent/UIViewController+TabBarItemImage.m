//
//  UIViewController+TabBarItemImage.m
//  FurniturePlatform
//
//  Created by beyondSoft on 16/12/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIViewController+TabBarItemImage.h"

@implementation UIViewController (TabBarItemImage)

- (void)setTabBarIconName:(NSString *)iconName selectedIconName:(NSString *)selectedIconName{
    
    UIImage *icon = [UIImage imageNamed:iconName];
    UIImage *selectedIcon = [UIImage imageNamed:selectedIconName];

    icon = [icon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = icon;

    if (selectedIcon)
    {
        selectedIcon = [selectedIcon imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage = selectedIcon;
    }
}

@end
