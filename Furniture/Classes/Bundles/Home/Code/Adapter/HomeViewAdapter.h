//
//  HomeViewAdapter.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/18.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeBannerModel;
@class HomeCategoryModel;
@class HomeRecoomendGoodsModel;

@interface HomeViewAdapter : NSObject
//
@property (nonatomic, strong) NSArray<HomeBannerModel *> * bannerModels;
@property (nonatomic, strong) NSArray<HomeCategoryModel *> * categoryModels;
@property (nonatomic, strong) NSArray<HomeRecoomendGoodsModel *> * recommendGoodsModels;

//@property (nonatomic, strong) NSMutableArray * bannerModels;
//@property (nonatomic, strong) NSMutableArray * categoryModels;
//@property (nonatomic, strong) NSMutableArray * recommendGoodsModels;
- (void)requestHomeData;

@end
