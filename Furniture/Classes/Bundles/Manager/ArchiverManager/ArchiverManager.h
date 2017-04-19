//
//  ArchiverManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiverManager : NSObject

+ (void)archiveNSArray:(NSArray *)array toPath:(NSString *)path;

+ (void)archiveNSDictionary:(NSDictionary *)dict toPath:(NSString *)path;

+ (NSArray *)unArchiveNSArrayWithPath:(NSString *)path;

+ (NSDictionary *)unArchiveNSDictionaryWithPath:(NSString *)path;

@end
