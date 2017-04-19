//
//  LoginControllerInteractor.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginViewController;

@interface LoginControllerInteractor : NSObject

@property (nonatomic, weak) LoginViewController * controller;

- (void)loginBtnClicked:(id)sender;

- (void)registerBtnClicked:(id)sender;

- (void)findPswordBtnClicked:(id)sender;
@end
