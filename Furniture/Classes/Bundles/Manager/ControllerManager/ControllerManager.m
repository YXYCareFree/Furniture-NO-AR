//
//  ControllerManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/2/9.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "ControllerManager.h"

@implementation ControllerManager

+ (instancetype)shareInstance{
    
    static ControllerManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [ControllerManager new];
    });
    return manager;
}

@end
