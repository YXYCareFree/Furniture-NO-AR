//
//  ActivityTableViewCell.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewInteractor;

@interface ActivityTableViewCell : UITableViewCell

@property (nonatomic, weak) HomeViewInteractor * interactor;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@property (weak, nonatomic) IBOutlet UIImageView *topLeftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *topRightImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLeftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomRightImageView;

- (void)setupView;
@end
