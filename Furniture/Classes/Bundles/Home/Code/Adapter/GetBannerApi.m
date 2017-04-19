//
//  GetBannerApi.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "GetBannerApi.h"

@implementation GetBannerApi

- (NSString *)requestUrl{
    return @"/ecPollingimage/queryPollingImage";
}

- (NSInteger)cacheTimeInSeconds{
    return 10 * 60;
}

- (BOOL)ignoreCache{
    return YES;
}

- (BOOL)loadCacheWithError:(NSError *)error{
    return YES;
}

@end
