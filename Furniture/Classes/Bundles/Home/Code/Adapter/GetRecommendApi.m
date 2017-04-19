//
//  GetRecommendApi.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "GetRecommendApi.h"

@implementation GetRecommendApi{
    
    NSString * _pageStart;
    NSString * _pageSize;
}

- (id)initWithPageStart:(NSString *)start pageSize:(NSString *)size{
    
    self = [super init];
    if (self) {
        _pageStart = start;
        _pageSize = size;
    }
    return self;
}

- (NSString *)requestUrl{
    return @"/commodity/queryAdviseCommodity";
}

- (id)requestArgument{
    return @{
             @"pageStart":_pageStart,
             @"pageSize":_pageSize
             };
}

- (NSInteger)cacheTimeInSeconds{
    return 24 * 60 * 60;
}

@end
