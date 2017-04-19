//
//  RecommendTableViewCell.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewInteractor;
@class SplitLineView;

@interface RecommendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet SplitLineView *splitView;


@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UILabel *topLeftTitle;
@property (weak, nonatomic) IBOutlet UILabel *topLeftPrice;
@property (weak, nonatomic) IBOutlet UIImageView *topLeftImageView;

@property (weak, nonatomic) IBOutlet UIView *topMiddleView;
@property (weak, nonatomic) IBOutlet UILabel *topMiddleTitle;
@property (weak, nonatomic) IBOutlet UILabel *topMiddlePrice;
@property (weak, nonatomic) IBOutlet UIImageView *topMiddleImageView;

@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UILabel *topRightTitle;
@property (weak, nonatomic) IBOutlet UILabel *topRightPrice;
@property (weak, nonatomic) IBOutlet UIImageView *topRightImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomLeftView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftTitle;
@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLeftPrice;

@property (weak, nonatomic) IBOutlet UIView *bottomMiddleView;
@property (weak, nonatomic) IBOutlet UILabel *bottomMiddleTitle;
@property (weak, nonatomic) IBOutlet UILabel *bottomMiddlePrice;
@property (weak, nonatomic) IBOutlet UIImageView *bottomMiddleImageView;

@property (weak, nonatomic) IBOutlet UIView *bottomRightView;
@property (weak, nonatomic) IBOutlet UILabel *bottomRightTitle;
@property (weak, nonatomic) IBOutlet UILabel *bottomRightPrice;
@property (weak, nonatomic) IBOutlet UIImageView *bottomRightImageView;


@property (nonatomic, weak) HomeViewInteractor * interactor;

- (void)setupView:(NSArray *)dataArr;

@end
