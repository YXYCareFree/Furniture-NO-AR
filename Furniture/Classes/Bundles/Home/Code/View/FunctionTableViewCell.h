//
//  FunctionTableViewCell.h
//  SmartOA
//
//  Created by beyondSoft on 16/12/12.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewInteractor;

@interface FunctionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIPageControl * pageControl;

@property (nonatomic, weak) HomeViewInteractor * interactor;

@property (nonatomic, assign) CGFloat height;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dataArr:(NSArray *)dataArr;

- (void)setupScrollView:(NSArray *)dataArr;

- (void)setupScrollViewTest;

@end
