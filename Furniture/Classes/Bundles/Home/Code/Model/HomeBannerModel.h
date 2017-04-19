//
//  HomeBannerModel.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/19.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeBannerModel : JSONModel

@property (nonatomic, strong) NSString * creator;

@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModified;

@property (nonatomic, assign) NSInteger  id;

@property (nonatomic, strong) NSString * imagCode;
@property (nonatomic, strong) NSString * imgHrefLocation;
@property (nonatomic, strong) NSString * imgLocation;
@property (nonatomic, strong) NSString * imgName;

@property (nonatomic, strong) NSString * modifier;

@property (nonatomic, strong) NSString * state;

@property (nonatomic, strong) NSString * type;

@end
