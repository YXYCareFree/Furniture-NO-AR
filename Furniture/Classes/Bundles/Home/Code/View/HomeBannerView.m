//
//  HomeBannerView.m
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "HomeBannerView.h"
#import "SDCycleScrollView.h"
#import "HomeBannerModel.h"

@interface HomeBannerView ()

@end

@implementation HomeBannerView

- (void)drawRect:(CGRect)rect {
    
//    [self createBannerView:nil];

    [self addSubview:self.bannerView];
}

- (void)createBannerView:(NSArray *)dataArr{
    
    NSMutableArray * urlArr = [NSMutableArray new];
    for (HomeBannerModel * model in dataArr) {
        [urlArr addObject:URLWITHSTRING(model.imgLocation)];
    }
    _bannerView.imageURLStringsGroup = urlArr;

    [self addSubview:_bannerView];
}
- (SDCycleScrollView *)bannerView{

    if (_bannerView == nil) {
        
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:self.frame delegate:nil placeholderImage:readImageFromImageName(@"bg_my_banner")];
        _bannerView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _bannerView.autoScrollTimeInterval = 3;
        _bannerView.delegate = self.interactor;
    }
    return _bannerView;
}

- (void)refreshBanner:(NSArray *)dataArr{
    
    [self createBannerView:dataArr];
}

@end
