//
//  DownloadFileManager.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/17.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "DownloadFileManager.h"
#import "AFNetworking.h"
#import "NSString+MD5Addition.h"
#import "SSZipArchive.h"

@interface DownloadFileManager ()<NSURLSessionDownloadDelegate>

@end

@implementation DownloadFileManager
//
//- (void)testDwonload{
//    
//    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue new]];
//    
//    //若使用此方法downloadTaskWithURL:(NSURL *)url completionHandler:就不会执行delegate方法
//    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:URLWITHSTRING(@"http://127.0.0.1/movie.rmvb")];
//    NSLog(@"task.taskIdentifier==%lu", (unsigned long)task.taskIdentifier);
//    [task resume];
//}
//
//- (void)testDwonload1{
//    
//    NSURLSession * session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue new]];
//    
//    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:URLWITHSTRING(@"http://127.0.0.1/movie.rmvb")];
//    NSLog(@"task.taskIdentifier==%lu", (unsigned long)task.taskIdentifier);
//    [task resume];
//}
//
//- (void)downloadFileWithUrl:(NSString *)url{
//    
//    NSString * md5 = [url stringFromMD5];
//    
//    NSString * fullPath = [NSString stringWithFormat:@"%@", AR_CACHES_PATH];
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
//        //使用fileURLWithPath用来访问本地文件
//        NSLog(@"%@", [NSURL fileURLWithPath:fullPath]);
//        
//        [SSZipArchive unzipFileAtPath:fullPath toDestination:[NSString stringWithFormat:@"%@/%@", fullPath, md5]];
//        return [NSURL fileURLWithPath:fullPath];
//    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
//        
//    }];
//    
//    [task resume];
//}
- (void)downloadFileWithUrl:(NSString *)url progress:(DownloadProgress)progress success:(DownloadFileSuccessBlock)success failure:(DownloadFileFailureBlock)failure{
    
    self.progressBlock = progress;
    
    NSString * md5 = [url stringFromMD5];
    
    NSString * zipPath = [AR_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip", md5]];
    
    NSString * destinationPath = [AR_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"AR%@", md5]];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSProgress * progress1 = nil;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:&progress1 destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //使用fileURLWithPath用来访问本地文件
        NSLog(@"URL路径%@\n, path=%@", [NSURL fileURLWithPath:zipPath], zipPath);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSError * error;
            BOOL ok = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath overwrite:YES password:nil error:&error delegate:nil];
            
            if (ok) [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
            
            NSLog(@"\n\n解压%@\n\n", ok?@"成功":error);
            
            NSString * filePath;
            for (NSString * str in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destinationPath error:nil]) {
                if (![str hasSuffix:@"manifest"] && ![str hasSuffix:@"meta"]) {
                    filePath = [destinationPath stringByAppendingPathComponent:str];
                }
            }
            if (success) {
                success(filePath);
            }
        });
        
        return [NSURL fileURLWithPath:zipPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [progress1 removeObserver:self forKeyPath:@"fractionCompleted"];
        if (error) {
            failure(error);
        }
    }];
    
    [progress1 addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    [task resume];
}

- (void)downloadFileWithUrl:(NSString *)url success:(DownloadFileSuccessBlock)success failure:(DownloadFileFailureBlock)failure{
    
    
    NSString * md5 = [url stringFromMD5];
    
    NSString * zipPath = [AR_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip", md5]];
    
    NSString * destinationPath = [AR_CACHES_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"AR%@", md5]];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSProgress * progress = nil;
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //使用fileURLWithPath用来访问本地文件
        NSLog(@"URL路径%@\n, path=%@", [NSURL fileURLWithPath:zipPath], zipPath);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            NSError * error;
            BOOL ok = [SSZipArchive unzipFileAtPath:zipPath toDestination:destinationPath overwrite:YES password:nil error:&error delegate:nil];
            
            if (ok) [[NSFileManager defaultManager] removeItemAtPath:zipPath error:nil];
            
            NSLog(@"\n\n解压%@\n\n", ok?@"成功":error);
            
            NSString * filePath;
            for (NSString * str in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:destinationPath error:nil]) {
                if (![str hasSuffix:@"manifest"] && ![str hasSuffix:@"meta"]) {
                    filePath = [destinationPath stringByAppendingPathComponent:str];
                }
            }
            if (success) {
                success(filePath);
            }
        });
        
        return [NSURL fileURLWithPath:zipPath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        [progress removeObserver:self forKeyPath:@"fractionCompleted"];
        if (error) {
            failure(error);
        }
    }];
    
    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    [task resume];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        
        NSProgress * progress = (NSProgress *)object;
        NSLog(@"%f", progress.fractionCompleted);
        if (self.progressBlock) {
            self.progressBlock(progress.fractionCompleted);
        }

    }
}
#pragma mark--NSURLSessionDownloadDelegate
/**
 *  下载完毕会调用
 *
 *  @param location     文件临时地址
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSString * file = [AR_CACHES_PATH stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"%@", downloadTask.response.suggestedFilename);
    [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:file error:nil];
}
/**
 *  每次写入沙盒完毕调用
 *  在这里面监听下载进度，totalBytesWritten/totalBytesExpectedToWrite
 *
 *  @param bytesWritten              这次写入的大小
 *  @param totalBytesWritten         已经写入沙盒的大小
 *  @param totalBytesExpectedToWrite 文件总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
}

/**
 *  恢复下载后调用，
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}

+ (double)sizeCaches{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    BOOL dir = NO;
    BOOL exists = [manager fileExistsAtPath:AR_CACHES_PATH isDirectory:&dir];
    
    if (!exists) {
        return 0;
    }
    
    if (dir) {//如果是文件夹遍历文件夹里的所有文件
        //获取该文件夹下所有子路径
        NSArray * subpaths = [manager subpathsAtPath:AR_CACHES_PATH];
        int totalSize = 0;
        
        for (NSString * subpath in subpaths) {
            
            NSString * fullPath = [AR_CACHES_PATH stringByAppendingPathComponent:subpath];
            
            BOOL dire = NO;
            [manager fileExistsAtPath:fullPath isDirectory:&dire];
            
            if (!dire) {//子路径是文件
                NSDictionary * attrs = [manager attributesOfItemAtPath:fullPath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        
        return totalSize / (1024 * 1024.0);
        
    }else{
        
        NSDictionary * attrs = [manager attributesOfItemAtPath:AR_CACHES_PATH error:nil];
        return [attrs[NSFileSize] intValue] / (1024 * 1024.0);
    }
}

+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (BOOL)clearAllCaches{
    return [[NSFileManager defaultManager] removeItemAtPath:AR_CACHES_PATH error:nil];
}

+ (double)sizeCachesWithPath:(NSString *)path{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    BOOL dir = NO;
    BOOL exists = [manager fileExistsAtPath:path isDirectory:&dir];
    
    if (!exists) {
        return 0;
    }
    
    if (dir) {//如果是文件夹遍历文件夹里的所有文件
        //获取该文件夹下所有子路径
        NSArray * subpaths = [manager subpathsAtPath:path];
        int totalSize = 0;
        
        for (NSString * subpath in subpaths) {
            
            NSString * fullPath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dire = NO;
            [manager fileExistsAtPath:fullPath isDirectory:&dire];
            
            if (!dire) {//子路径是文件
                NSDictionary * attrs = [manager attributesOfItemAtPath:fullPath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        
        return totalSize / (1024 * 1024.0);
        
    }else{
        
        NSDictionary * attrs = [manager attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024 * 1024.0);
    }
}


@end
