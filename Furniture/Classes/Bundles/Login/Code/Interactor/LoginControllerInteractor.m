//
//  LoginControllerInteractor.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "LoginControllerInteractor.h"
#import "LoginViewController.h"

@implementation LoginControllerInteractor

- (void)loginBtnClicked:(id)sender{
    NSLog(@"loginClicked");
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerBtnClicked:(id)sender{
    NSLog(@"registerClicked");
}

- (void)findPswordBtnClicked:(id)sender{
    NSLog(@"findPswordClicked");
}
@end
