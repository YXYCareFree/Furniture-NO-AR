//
//  ArchiverManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/14.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "ArchiverManager.h"

@implementation ArchiverManager

+ (void)archiveNSArray:(NSArray *)array toPath:(NSString *)path{
    
    if (array && path) {
        
        if ([NSKeyedArchiver archiveRootObject:array toFile:path]) {
//            NSLog(@"归档成功%@", path);
        }else NSLog(@"归档失败%@", path);
    }
}

+ (void)archiveNSDictionary:(NSDictionary *)dict toPath:(NSString *)path{
    
    if (dict && path) {
        
        if ([NSKeyedArchiver archiveRootObject:dict toFile:path]) {
//            NSLog(@"归档成功%@", path);
        }else NSLog(@"归档失败%@", path);
    }
}

+ (NSArray *)unArchiveNSArrayWithPath:(NSString *)path{
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return array;
}

+ (NSDictionary *)unArchiveNSDictionaryWithPath:(NSString *)path{
    
    NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return dict;
}
@end
