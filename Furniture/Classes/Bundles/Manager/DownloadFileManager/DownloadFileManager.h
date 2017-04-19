//
//  DownloadFileManager.h
//  Furniture
//
//  Created by 王小娜 on 2017/1/17.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void(^DownloadFileSuccessBlock)(NSString * filePath);

typedef void(^DownloadFileFailureBlock)(NSError * error);
///
typedef void (^DownloadProgress)(double progress);

@interface DownloadFileManager : NSObject

@property (nonatomic, copy) DownloadProgress progressBlock;
///
- (void)downloadFileWithUrl:(NSString *)url progress:(DownloadProgress)progress success:(DownloadFileSuccessBlock)success failure:(DownloadFileFailureBlock)failure;

- (void)downloadFileWithUrl:(NSString *)url success:(DownloadFileSuccessBlock)success failure:(DownloadFileFailureBlock)failure;

- (void)downloadFileWithUrl:(NSString *)url;

- (void)testDwonload1;
- (void)testDwonload;

+ (double)sizeCachesWithPath:(NSString *)path;

+ (double)sizeCaches;

+ (BOOL)clearCachesWithFilePath:(NSString *)path;

+ (BOOL)clearAllCaches;

@end
