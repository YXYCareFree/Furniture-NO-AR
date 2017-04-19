//
//  TitleLabel.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/17.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{

    self.textColor = colorFromHexString(@"323232");
    self.font = FONT(13);
}

@end
