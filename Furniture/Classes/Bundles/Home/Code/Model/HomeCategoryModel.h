//
//  HomeCategoryModel.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/19.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HomeCategoryModel : JSONModel

@property (nonatomic, strong) NSString * attributes;

@property (nonatomic, strong) NSString * catalogCode;
@property (nonatomic, strong) NSString * catalogImage;

@property (nonatomic, assign) NSInteger  id;

@property (nonatomic, strong) NSString * catalogName;
@property (nonatomic, strong) NSString * creator;
@property (nonatomic, strong) NSString * gmtCreate;
@property (nonatomic, strong) NSString * gmtModified;

@property (nonatomic, strong) NSString * isDelete;


@property (nonatomic, assign) NSInteger level;

@property (nonatomic, strong) NSString * state;

@property (nonatomic, strong) NSString * modifier;

@property (nonatomic, strong) NSString * pcatalogCode;
@end
