//
//  BaseUINavigationController.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/17.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "BaseUINavigationController.h"
#import "ScanViewController.h"

@interface BaseUINavigationController ()

@end

@implementation BaseUINavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationBar setBackgroundImage:createImageWithUIColor([UIColor whiteColor], CGSizeMake(1, 1)) forBarMetrics:(UIBarMetricsDefault)];
}


@end
