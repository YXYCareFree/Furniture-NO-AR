//
//  HomeViewInteractor.h
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeViewController;

@interface HomeViewInteractor : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) HomeViewController * controller;

- (void)refreshHome;

- (void)loadHome;

- (void)scanClicked:(id)sender;

- (void)ARClicked:(id)sender;

- (void)activityImageViewClicked:(UITapGestureRecognizer *)tap;

- (void)recommendImageViewClicked:(UITapGestureRecognizer *)tap;

- (void)searchClicked:(id)sender;

- (void)categoryClicked:(UITapGestureRecognizer *)tap;
@end
