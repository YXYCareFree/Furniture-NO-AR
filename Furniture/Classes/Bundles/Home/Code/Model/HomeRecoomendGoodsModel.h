//
//  HomeRecoomendGoodsModel.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/19.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeRecoomendGoodsModel : JSONModel

@property (nonatomic, strong) NSString * commodityCode;//商品编码

@property (nonatomic, strong) NSString * merchantBasicInfoCode;//商家信息编码--商家账户表-商家账户编码
@property (nonatomic, strong) NSString * ordinaryAccountCode;//用户账号编码--来自用户账户表的用户编码

@property (nonatomic, strong) NSString * categoryCode;//所属类目--类目表-类目编码
@property (nonatomic, strong) NSString * commodityBrand;//商品品牌
@property (nonatomic, strong) NSString * commodityTitle;//商品标题
@property (nonatomic, strong) NSString * commodityNumber;//商品ID
@property (nonatomic, strong) NSString * commodityStatus;//商品状态:0-  未上架,1-  已上架,2-已下架,3-  已删除
@property (nonatomic, strong) NSString * detailPicURLs;
@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * mainPicURLs;//图片url

@property (nonatomic, strong) NSString * sellingPrice;
@property (nonatomic, strong) NSString * sellingPriceYuan;

@property (nonatomic, strong) NSString * unit;//计量单位

@property (nonatomic, strong) NSString * forSearch;//搜索关键字

@property (nonatomic, strong) NSString * isAr;//是否支持AR

@property (nonatomic, strong) NSString * arInfo;//AR信息
@end
