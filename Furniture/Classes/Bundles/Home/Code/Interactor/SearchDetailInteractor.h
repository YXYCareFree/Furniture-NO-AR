//
//  SearchDetailInteractor.h
//  Furniture
//
//  Created by 杨肖宇 on 2017/3/23.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchDetailViewController;

@interface SearchDetailInteractor : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) SearchDetailViewController * controller;

- (void)backClicked:(id)sender;

- (void)ARClicked:(id)sender;

- (void)searchClicked:(id)sender;

- (void)headerViewClicked:(id)sender;

@end
