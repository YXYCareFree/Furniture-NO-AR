//
//  ScanViewInteractor.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ScanViewController;

@interface ScanViewInteractor : NSObject

@property (nonatomic, weak) ScanViewController * controller;
- (void)backBtnClicked;

@end
