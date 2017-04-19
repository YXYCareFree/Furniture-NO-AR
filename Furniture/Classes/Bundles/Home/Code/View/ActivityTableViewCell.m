//
//  ActivityTableViewCell.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "HomeViewInteractor.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupView{
    
    [self addGuesture];
    
   self.subtitle.textColor = self.title.textColor = colorFromHexString(@"323232");
}

- (void)addGuesture{
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(activityImageViewClicked:)];
    [self.topLeftImageView addGestureRecognizer:tap1];
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(activityImageViewClicked:)];
    [self.topRightImageView addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(activityImageViewClicked:)];
    [self.bottomLeftImageView addGestureRecognizer:tap3];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(activityImageViewClicked:)];
    [self.bottomRightImageView addGestureRecognizer:tap4];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
