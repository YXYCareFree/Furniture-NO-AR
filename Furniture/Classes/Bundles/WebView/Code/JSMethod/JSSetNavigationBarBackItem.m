//
//  JSSetNavigationBarBackItem.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/22.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "JSSetNavigationBarBackItem.h"
#import "ControllerManager.h"

@implementation JSSetNavigationBarBackItem

- (void)handleJSMethodWithParams:(id)params callBack:(WVJBResponseCallback)callBack{
    
    NSDictionary * dic = (NSDictionary *)params;
    
    NSLog(@"currentVC=%p, homeVC=%p, ", [ControllerManager shareInstance].currentVC, [ControllerManager shareInstance].homeVC);

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isSearch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isSearch"];
        
        [GETCURRENTCONTROLLER.navigationController popToViewController:[ControllerManager shareInstance].homeVC animated:YES];
        return;
    }
    if ([dic[@"userConfig"] isEqualToString:@"0"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadUserConfig object:nil];
        return;
    }
    
    [GETCURRENTCONTROLLER.navigationController popViewControllerAnimated:YES];
}
@end
