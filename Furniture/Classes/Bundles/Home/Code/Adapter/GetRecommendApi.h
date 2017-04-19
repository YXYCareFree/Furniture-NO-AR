//
//  GetRecommendApi.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "YXYBaseRequest.h"

@interface GetRecommendApi : YXYBaseRequest

- (id)initWithPageStart:(NSString *)start pageSize:(NSString *)size;

@end
