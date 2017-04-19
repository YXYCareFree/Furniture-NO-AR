//
//  SearchViewInteractor.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SearchViewController;

@interface SearchViewInteractor : NSObject<UITextFieldDelegate>

@property (nonatomic, weak) SearchViewController * controller;

- (void)backClicked:(id)sender;

- (void)searchClicked:(id)sender;

- (void)hideKeyBoard;
@end
