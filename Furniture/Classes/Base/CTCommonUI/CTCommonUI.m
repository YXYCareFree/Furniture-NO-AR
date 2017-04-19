//
//  CTCommonUI.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/21.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTCommonUI.h"

#define kNBBundleName @"CTUIKit.bundle"

UIImage *CommonUILoadImage(NSString *imageName)
{
    UIImage *image = [UIImage imageNamed:imageName];
    if (!image) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", kNBBundleName, imageName]];
    }
    return image;
}
