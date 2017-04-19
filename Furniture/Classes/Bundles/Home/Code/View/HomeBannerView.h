//
//  HomeBannerView.h
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewInteractor;
@class SDCycleScrollView;

@interface HomeBannerView : UIView

@property (nonatomic, weak) HomeViewInteractor * interactor;

@property (nonatomic, strong) SDCycleScrollView * bannerView;

- (void)refreshBanner:(NSArray *)dataArr;

@end
