//
//  ScanViewInteractor.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "ScanViewInteractor.h"
#import "ScanViewController.h"

@implementation ScanViewInteractor

- (void)backBtnClicked{
    [self.controller.navigationController popViewControllerAnimated:YES];
}
@end
