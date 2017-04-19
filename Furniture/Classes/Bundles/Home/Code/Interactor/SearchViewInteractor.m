//
//  SearchViewInteractor.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "SearchViewInteractor.h"
#import "SearchViewController.h"

@implementation SearchViewInteractor

- (void)backClicked:(id)sender{
    
    [self.controller.navigationController popViewControllerAnimated:YES];
}

- (void)searchClicked:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSearch"];
    [YXYWebViewManager openURL:@"" withType:@"search" forSearch:self.controller.searchTextField.text isAr:@"no"];
}

- (void)hideKeyBoard{
    [self.controller.view.window endEditing:YES];
}

#pragma mark--UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"searchClicked:");
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isSearch"];
    [YXYWebViewManager openURL:@"" withType:@"search" forSearch:textField.text isAr:@"no"];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    NSLog(@"%s, %@, %@, %@", __FUNCTION__, textField.text, string, text);
    return YES;
}

@end
