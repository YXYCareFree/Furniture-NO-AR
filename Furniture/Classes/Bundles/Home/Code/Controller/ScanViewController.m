//
//  ScanViewController.m
//  Scan
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanViewInteractor.h"

static const char * ScanQueueName = "ScanQueue";

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession * captureSession;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer * videoPreviewLayer;

@property (nonatomic, strong) UIButton * lightBtn;//用于打开照明

@property (nonatomic, assign) BOOL upOrDown;

@property (nonatomic, strong) NSTimer * timer;

@property (nonatomic, assign) int num;

@property (nonatomic, strong) UIImageView * line;

@property (nonatomic, strong) UIImageView * scanView;

@property (nonatomic, strong) UIView * scanFrame;

@property (nonatomic, strong) ScanViewInteractor * interactor;
@end

@implementation ScanViewController

- (void)dealloc{
    [self stopScan];
    [_timer invalidate];
    _timer = nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self interfaceInit];
    [self startScan];
    [self createTimer];
}

- (void)createTimer{

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(lineUpOrDown) userInfo:nil repeats:YES];
}

- (void)startScan{
#if TARGET_IPHONE_SIMULATOR
    return;
#elif TARGET_OS_IPHONE
    
#endif
    NSError * error = nil;
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //初始化输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
    }

    //创建会话
    _captureSession = [AVCaptureSession new];//需要请求使用权限，否则会崩溃
   // [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
   // _captureSession.sessionPreset = AVCaptureSessionPreset3840x2160;
    //添加输入流
    [_captureSession addInput:input];
    //初始化输出流
    AVCaptureMetadataOutput * output = [AVCaptureMetadataOutput new];
    //设置扫描有效区域
    output.rectOfInterest = CGRectMake(_scanView.frame.origin.y / kScreenHeight, _scanView.frame.origin.x / kScreenWidth, _scanView.frame.size.height / kScreenHeight, _scanView.frame.size.width / kScreenWidth);

    //添加输出流
    [_captureSession addOutput:output];

    //创建dispatch queue
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(ScanQueueName, NULL);
    [output setMetadataObjectsDelegate:self queue:dispatchQueue];
    //设置源数据类型 AVMetadataObjectTypeQRCode  二维码，条形码。。。。
    [output setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];

    //创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_scanFrame.layer.bounds];
    [_scanFrame.layer addSublayer:_videoPreviewLayer];

    //开始会话
    [_captureSession startRunning];
    
  //  NSLog(@"\n\n%s, _captureSession=%p\n\n", __FUNCTION__, _captureSession);

}

- (void)stopScan{
    //停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
    //暂停定时器
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)interfaceInit{
    
    self.interactor = [ScanViewInteractor new];
    self.interactor.controller = self;
    
    _scanFrame = [UIView new];
    [_scanFrame setFrame:self.view.frame];
    [self.view addSubview:_scanFrame];

    //backBtn
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 30, 30)];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.clipsToBounds = YES;
    bgView.layer.cornerRadius = 15;
    
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 4, 13, 21)];
    [backBtn setBackgroundImage:readImageFromImageName(@"backArrow") forState:UIControlStateNormal];
    [backBtn addTarget:self.interactor action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:backBtn];
    [self.view addSubview:bgView];
    
    _lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth / 2 - 60, 100, 120, 40)];
    [_lightBtn setTitle:@"开启照明" forState:UIControlStateNormal];
    [_lightBtn addTarget:self action:@selector(turnOnLight:) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:_lightBtn];

    _scanView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 300) / 2, 150, 300, 300)];
    _scanView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:_scanView];

    _upOrDown = NO;
    _num = 0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/ 2 - 130, 160, 260, 2)];
    _line.center = _scanView.center;
    _line.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_line];
    
   // NSLog(@"\n\n%s, line=%p\n\n", __FUNCTION__, _line);
}

- (void)lineUpOrDown{
//150--450
    if (_upOrDown == NO) {
        _num ++;
        _line.frame = CGRectMake(kScreenWidth/ 2 - 110, 170 + 2 * _num, 220, 2);
        if (2 * _num >= 260) {
            _upOrDown = YES;
        }
    }
    else {
        _num --;
        _line.frame = CGRectMake(kScreenWidth/ 2 - 110, 170 + 2 * _num, 220, 2);
        if (_num <= 0) {
            _upOrDown = NO;
        }
    }
}

- (void)turnOnLight:(UIButton *)sender{

    if ([sender.titleLabel.text isEqualToString:@"开启照明"]) {

        [_lightBtn setTitle:@"关闭照明" forState:UIControlStateNormal];
        [self systemLightSwitch:YES];

    }else{

        [_lightBtn setTitle:@"开启照明" forState:UIControlStateNormal];
        [self systemLightSwitch:NO];
    }
}

- (void)systemLightSwitch:(BOOL)open{

    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {

        [device lockForConfiguration:nil];
        if (open) {

            [device setTorchMode:AVCaptureTorchModeOn];
             }else{

                 [device setTorchMode:AVCaptureTorchModeOff];
             }
        [device unlockForConfiguration];
    }

}

#pragma mark--AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{

    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject * metadataObj = [metadataObjects objectAtIndex:0];
        NSString * result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode] ) {
            result = metadataObj.stringValue;
        }else{
            NSLog(@"不是二维码");
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}
//处理扫描结果
- (void)reportScanResult:(NSString *)result{

    [self stopScan];
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描" message:result delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
//    [alert show];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
