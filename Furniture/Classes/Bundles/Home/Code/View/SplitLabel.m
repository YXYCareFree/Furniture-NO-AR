//
//  SplitLabel.m
//  Furniture
//
//  Created by 王小娜 on 2017/2/8.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "SplitLabel.h"

@implementation SplitLabel

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
    self.text = @"";
    self.backgroundColor = COLOR_SPLITLINE;
}

@end
