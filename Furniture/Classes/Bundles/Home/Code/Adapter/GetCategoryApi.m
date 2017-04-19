//
//  GetCategoryApi.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "GetCategoryApi.h"

@implementation GetCategoryApi

- (NSString *)requestUrl{
    return @"/ecCatalog/pageQueryCatalogs";
}

- (NSInteger)cacheTimeInSeconds{
    return 24 * 60 * 60;
}
@end
