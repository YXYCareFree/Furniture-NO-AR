//
//  ControllerManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/2/9.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControllerManager : NSObject

@property (nonatomic, strong) UIViewController * homeVC;

@property (nonatomic, strong) UIViewController * currentVC;

+ (instancetype)shareInstance;

@end
