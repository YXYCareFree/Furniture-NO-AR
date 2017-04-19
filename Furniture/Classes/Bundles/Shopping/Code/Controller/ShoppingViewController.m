//
//  ShoppingViewController.m
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "ShoppingViewController.h"
#import "DownloadFileManager.h"

@interface ShoppingViewController ()

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DownloadFileManager clearAllCaches];
}

- (IBAction)download:(id)sender {
    
    DownloadFileManager * download = [DownloadFileManager new];
//    [download downloadFileWithUrl:@"http://ar-staticresource.bj.bcebos.com/arfile/3c48b092199141adbea1da14cb9f20f3.zip" success:^(NSString *filePath) {
//        NSLog(@"success");
//    } failure:^(NSError *error) {
//        NSLog(@"failure");
//    }];
    
    [download downloadFileWithUrl:@"http://ar-staticresource.bj.bcebos.com/arfile/3c48b092199141adbea1da14cb9f20f3.zip" progress:^(double progress) {
        NSLog(@"download%f", progress);
    } success:^(NSString *filePath) {
        NSLog(@"success");
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

@end
