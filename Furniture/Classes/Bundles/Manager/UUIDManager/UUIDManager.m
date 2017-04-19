//
//  UUIDManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/18.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "UUIDManager.h"
#import "UICKeyChainStore.h"

NSString * const DeviceID = @"DEVICEID";
NSString * const Key = @"com.yangxiaoyu.company";

@implementation UUIDManager

- (NSString *)getUUID{
    
    UICKeyChainStore * keyChain =[UICKeyChainStore keyChainStoreWithService:DeviceID];
    
    NSError * error;
    NSString * uuid = [keyChain stringForKey:Key error:&error];
    if (error || uuid.length == 0) {
        uuid = [self createUUID];
        if (uuid.length != 0) {
            [keyChain setString:uuid forKey:Key];
            return uuid;
        }
    }
    return uuid;
}

- (NSString *)createUUID{
    
    return  [[[[UIDevice alloc] init] identifierForVendor] UUIDString];
}

@end
