//
//  MineViewController.m
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "MineViewController.h"
#import "WebViewJavascriptBridge.h"
#import "Masonry.h"

//http://180.76.185.85:9003/mall/account/toUserCenter.htm
@interface MineViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) WebViewJavascriptBridge * UIWebViewBridge;
@property (nonatomic, strong) UIView * progressView;
@property (nonatomic, strong) CALayer * progressLayer;

@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearCaches];
    [self createUIWebView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadUserConfig) name:ReloadUserConfig object:nil];
}

- (void)clearCaches{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)createUIWebView{
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_webView];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://180.76.185.85:9003/mall/account/toUserCenter.htm"]]];
    
    self.UIWebViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.UIWebViewBridge setWebViewDelegate:self];
    
    [self createProgress];
}

- (void)createProgress{
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 3)];
    _progressView.backgroundColor = [UIColor clearColor];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = COLOR_MAIN.CGColor;
    [_progressView.layer addSublayer:layer];
    self.progressLayer = layer;
}
#pragma mark--UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if ([request.URL.absoluteString hasPrefix:@"http://180.76.185.85:9003/mall/app/prodDetail.htm?"]) {
        self.navigationController.tabBarController.tabBar.hidden = YES;
    }else{
        self.navigationController.tabBarController.tabBar.hidden = NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    for (UIView * view in _webView.subviews) {
        
        if ([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    
    [_webView addSubview:_progressView];
    
    [UIView animateWithDuration:10.0 animations:^{
        self.progressLayer.frame = CGRectMake(0, 0, kScreenWidth * 0.8, 3);
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIView animateWithDuration:0.2 animations:^{
        self.progressLayer.frame = _progressView.frame;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressView removeFromSuperview];
        });
    }];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [UIView animateWithDuration:0.2 animations:^{
        self.progressLayer.frame = _progressView.frame;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.progressView removeFromSuperview];
        });
    }];
    
    [self handelFailLoadWebView];
}

- (void)handelFailLoadWebView{
    
    _webView.scrollView.scrollEnabled = NO;
    
    UIImageView * imageView = [UIImageView new];
    imageView.image = readImageFromImageName(@"no_network");
    UILabel * tipLable1 = [UILabel new];
    UILabel * tipLabel2 = [UILabel new];
    [_webView addSubview:imageView];
    [_webView addSubview:tipLable1];
    [_webView addSubview:tipLabel2];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_webView);
        make.centerY.equalTo(_webView).offset(-100);
    }];
    
    tipLable1.text = @"亲，网络不给力哦！";
    tipLable1.textColor = colorFromHexString(@"999999");
    [tipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_webView);
        make.top.equalTo(imageView.bottom).offset(30);
    }];
    tipLabel2.text = @"刷新一下试试吧";
    tipLabel2.textColor = colorFromHexString(@"999999");
    [tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_webView);
        make.top.equalTo(tipLable1.bottom).offset(20);
    }];
    
    UIButton * refreshBtn = [UIButton new];
    [_webView addSubview:refreshBtn];
    
    [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_webView);
        make.top.equalTo(tipLabel2.bottom).offset(40);
        make.width.equalTo(80);
        make.height.equalTo(40);
    }];
    
    refreshBtn.titleLabel.font = FONT(20);
    
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    refreshBtn.layer.masksToBounds = YES;
    refreshBtn.layer.cornerRadius = 20.f;
    refreshBtn.layer.borderWidth = 1;
    refreshBtn.layer.borderColor = COLOR_MAIN.CGColor;
    [refreshBtn addTarget:self action:@selector(loadWebView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadWebView{
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://180.76.185.85:9003/mall/account/toUserCenter.htm"]]];
}

@end
