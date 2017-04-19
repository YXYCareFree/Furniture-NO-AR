//
//  DetailTableViewCell.h
//  Furniture
//
//  Created by 杨肖宇 on 2017/3/24.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceLabel.h"
#import "SplitLabel.h"

@interface DetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet PriceLabel *priceLabel;
@property (weak, nonatomic) IBOutlet SplitLabel *splitLine;

@end
