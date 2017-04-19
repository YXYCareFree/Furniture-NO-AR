//
//  DetailTableViewCell.m
//  Furniture
//
//  Created by 杨肖宇 on 2017/3/24.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
