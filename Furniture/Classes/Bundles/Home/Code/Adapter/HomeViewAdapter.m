//
//  HomeViewAdapter.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/18.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "HomeViewAdapter.h"

#import "HomeBannerModel.h"
#import "HomeCategoryModel.h"
#import "HomeRecoomendGoodsModel.h"
#import "YXYGatewayApiService.h"

#import "GetBannerApi.h"
#import "GetCategoryApi.h"
#import "GetRecommendApi.h"

#import "ArchiverManager.h"
#import "NSString+MD5Addition.h"
#import "DownloadFileManager.h"

@implementation HomeViewAdapter

- (void)requestHomeData{
    
    [self requestHomeBanner];
    [self requestCategoryList];
    [self requestRecommendGoods];

//    [self requestApi];
}

- (void)requestCategoryList{
    
    YXYRequest * request = [YXYRequest new];
//    
//    NSDictionary * params = @{@"pageNo":@"1",
//                              @"pageSize":@"9"};
    request.apiName = @"/ecCatalog/pageQueryCatalogs";
   // request.params = params;
    
    request.isCache = YES;
    NSString * cachePath = [AR_CACHES_PATH stringByAppendingPathComponent:[request.apiName stringFromMD5]];

    request.success = ^(YXYResponse * response, id cacheData){
        
        if (cacheData) {

            [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeCategoryDataSuccess object:cacheData];
        }
        
        NSDictionary * dic = (NSDictionary *)response.data;
        if (!dic) {
            return ;
        }
        
        self.categoryModels = [HomeCategoryModel arrayOfModelsFromDictionaries:dic[@"list"] error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeCategoryDataSuccess object:self.categoryModels];
        [ArchiverManager archiveNSArray:self.categoryModels toPath:cachePath];
    };
    
    request.failure = ^(YXYErrorResponse * errorResponse){
        NSLog(@"\n%s===OK\n", __FUNCTION__);
    };
    
    [APIREQUEST startRequest:request];
}

- (void)requestHomeBanner{
    
    YXYRequest * request = [YXYRequest new];
    
    request.apiName = @"/ecPollingimage/queryPollingImage";
    NSDictionary * params = @{};
    request.params = params;
    
    request.isCache = YES;
    NSString * cachePath = [AR_CACHES_PATH stringByAppendingPathComponent:[request.apiName stringFromMD5]];
    request.success = ^(YXYResponse * response, id cacheData){
        //读取缓存
        if (cacheData) {
            [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeBannerDataSuccess object:cacheData];
        }
        if (!response.data) {
            return ;
        }
        
        self.bannerModels = [HomeBannerModel arrayOfModelsFromDictionaries:response.data error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeBannerDataSuccess object:self.bannerModels];
        [ArchiverManager archiveNSArray:self.bannerModels toPath:cachePath];
        
    };
    
    request.failure = ^(YXYErrorResponse * errorResponse){
        NSLog(@"\n%s===OK\n", __FUNCTION__);
    };
    
    [APIREQUEST startRequest:request];
}

- (void)requestRecommendGoods{
    
    NSDictionary * params = @{@"pageStart":@"",
                                  @"pageSize":@""};
    YXYRequest * request = [YXYRequest new];
    
    request.apiName = @"/commodity/queryAdviseCommodity";
    request.params = params;
    
    request.isCache = YES;
    NSString * cachePath = [AR_CACHES_PATH stringByAppendingPathComponent:[request.apiName stringFromMD5]];
    request.success = ^(YXYResponse * response, id cacheData){

        if (cacheData) {
            [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeRecommendDataSuccess object:cacheData];
        }
        
        if (!response.data) {
            return ;
        }
        
        self.recommendGoodsModels = [HomeRecoomendGoodsModel arrayOfModelsFromDictionaries:response.data error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeRecommendDataSuccess object:self.recommendGoodsModels];
        [ArchiverManager archiveNSArray:self.recommendGoodsModels toPath:cachePath];
        
    };
    
    request.failure = ^(YXYErrorResponse * errorResponse){
        NSLog(@"\n%s===OK\n", __FUNCTION__);
    };
    
    [APIREQUEST startRequest:request];
}

#pragma mark-- api
- (void)requestApi{
    GetBannerApi * bannerApi = [GetBannerApi new];
    
    [bannerApi startRequestSuccess:^(YTKBaseRequest *request, YXYSuccessResponse *response) {
        
        if (!response.data) {
            return ;
        }
        //        NSLog(@"bannerApi==%@", response.data);
        self.bannerModels = [HomeBannerModel arrayOfModelsFromDictionaries:response.data error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeBannerDataSuccess object:self.bannerModels];
        
    } failure:^(YTKBaseRequest *request, YXYFailureResponse *response) {
        
    }];
    
    GetCategoryApi * categoryApi = [GetCategoryApi new];
    [categoryApi startRequestSuccess:^(YTKBaseRequest *request, YXYSuccessResponse *response) {
        
        NSDictionary * dic = (NSDictionary *)response.data;
        if (!dic) {
            return ;
        }
        
        self.categoryModels = [HomeCategoryModel arrayOfModelsFromDictionaries:dic[@"list"] error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeCategoryDataSuccess object:self.categoryModels];
        
    } failure:^(YTKBaseRequest *request, YXYFailureResponse *response) {
        
    }];
    
    GetRecommendApi * recommendApi = [[GetRecommendApi alloc] initWithPageStart:@"" pageSize:@""];
    [recommendApi startRequestSuccess:^(YTKBaseRequest *request, YXYSuccessResponse *response) {
        
        if (!response.data) {
            return ;
        }
        self.recommendGoodsModels = [HomeRecoomendGoodsModel arrayOfModelsFromDictionaries:response.data error:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:GetHomeRecommendDataSuccess object:self.recommendGoodsModels];
        
    } failure:^(YTKBaseRequest *request, YXYFailureResponse *response) {
        
    }];

}
@end
