//
//  YXYWKWebViewController.m
//  Furniture
//
//  Created by 王小娜 on 2017/2/17.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "YXYWKWebViewController.h"
#import <objc/runtime.h>
#import "YXYJSMethodBase.h"
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"

static NSString * detailbaseUrl = @"http://180.76.185.85:9003/mall/app/prodDetail.htm?commodityCode=";
static NSString * categoryBaseURL = @"http://180.76.185.85:9003/mall/app/prodList.htm?categoryCode=";
static NSString * searchUrl = @"http://180.76.185.85:9003/mall/app/prodList.htm?";

@interface YXYWKWebViewController ()

@property (nonatomic, strong) WKWebViewJavascriptBridge * bridge;
@property (nonatomic, strong) YXYJSMethodBase * jsMethodBase;

@property (nonatomic, strong) WKWebView * wkWebView;
@property (weak, nonatomic) CALayer *progresslayer;

@end

@implementation YXYWKWebViewController

- (void)dealloc{
    NSLog(@"\n***==%@: dealloc", NSStringFromClass([self class]));
     [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self deleteWebCache];
    [self createWKWebView];
    [self createProgressView];
    [self registerJSMethod];
}

- (void)createWKWebView{
    
    [self.view addSubview:self.wkWebView];
    
    self.bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
//    NSURLRequest * request = [NSURLRequest requestWithURL:<#(nonnull NSURL *)#> cachePolicy:<#(NSURLRequestCachePolicy)#> timeoutInterval:<#(NSTimeInterval)#>];
    if ([self.type isEqualToString:@"category"]) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:URLWITHSTRING([categoryBaseURL stringByAppendingString:_code])]];
    }else if ([self.type isEqualToString:@"detail"]) {
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:URLWITHSTRING([detailbaseUrl stringByAppendingString:_code])]];
    }else if ([self.type isEqualToString:@"search"]){
        
        NSString * url = [NSString stringWithFormat:@"%@forSearch=%@&isAr=%@", searchUrl, _forSearch, _isAr];
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:URLWITHSTRING(url)]];
    }else{
        NSLog(@"url === %@", _url);
        [_wkWebView loadRequest:[NSURLRequest requestWithURL:URLWITHSTRING(_url)]];
    }
}

- (void)createProgressView{
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 15, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = COLOR_MAIN.CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}
#pragma mark--设置进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%f", [change[NSKeyValueChangeNewKey] floatValue]);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)registerJSMethod{
    
    _jsMethodBase = [YXYJSMethodBase shareYXYJSMethodBase];
    _jsMethodBase.WKWebViewbridge = self.bridge;
    [_jsMethodBase registerJSMehod];
}

- (void)deleteWebCache {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        
        NSSet *websiteDataTypes
        
        = [NSSet setWithArray:@[
                                
                                WKWebsiteDataTypeDiskCache,
                                
                                //WKWebsiteDataTypeOfflineWebApplicationCache,
                                
                                WKWebsiteDataTypeMemoryCache,
                                
                                //WKWebsiteDataTypeLocalStorage,
                                
                                //WKWebsiteDataTypeCookies,
                                
                                //WKWebsiteDataTypeSessionStorage,
                                
                                //WKWebsiteDataTypeIndexedDBDatabases,
                                
                                //WKWebsiteDataTypeWebSQLDatabases
                                
                                ]];
        
        //// All kinds of data
        
        //NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        
        //// Date from
        
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
        
    } else {
        
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        
        NSError *errors;
        
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    
}

#pragma mark--WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:prompt message:defaultText preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = COLOR_MAIN;
    }];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertVC.textFields.lastObject.text);
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    [self alert:message];
    completionHandler();
}

- (void)alert:(NSString *)title{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:@"test" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                                                  completionHandler(YES);
                                              }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action)
                      {
                          completionHandler(NO);
                      }]];
    [self presentViewController:alert animated:YES completion:NULL];
}
- (void)addBackBtn{
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 0, 30, 30)];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = COLOR_MAIN;
    [self.wkWebView addSubview:btn];
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (WKWebView *)wkWebView{
    
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        // _wkWebView.UIDelegate = self;
        // WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    }
    return _wkWebView;
}



@end
