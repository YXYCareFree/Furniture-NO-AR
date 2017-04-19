//
//  Header.h
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import <UIKit/UIKit.h>

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

#define WEAKSELF           typeof(self) __weak weakSelf = self;
#define STRONGSELF         typeof(weakSelf) __strong strongSelf = weakSelf;

//设备的区分
#define IS_IPAD_PRO       (kScreenWidth) == 1024
#define IS_IPAD           (kScreenWidth) == 768

#define IS_IPHONE_PLUS    kScreenHeight == 736
#define IS_IPHONE6        kScreenHeight == 667
#define IS_IPNONE_SE      kScreenHeight == 568

//网络请求
#define APIREQUEST         [YXYGatewayApiService shareApiService]

#define WEBVIEW_TYPE       [[NSUserDefaults standardUserDefaults] objectForKey:@"webViewType"]
#define IS_WKWebView       [WEBVIEW_TYPE isEqualToString:@"WKWebView"]
//页面跳转
#define GETCURRENTCONTROLLER [UIViewController getCurrentViewController]

#define PUSHCONTROLLER(x)  [GETCURRENTCONTROLLER.navigationController customPushViewController:x animated:YES]

#define PUSHCONTROLLER_WITHCLASSNAME(x)  [GETCURRENTCONTROLLER.navigationController pushViewControllerWithClassName:x]

#define URLWITHSTRING(x)   [NSURL URLWithString:[x stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]

//通知
#define GetHomeBannerDataSuccess     @"GetHomeBannerDataSuccess"
#define GetHomeCategoryDataSuccess   @"GetHomeCategoryDataSuccess"
#define GetHomeRecommendDataSuccess  @"GetHomeRecommendDataSuccess"

#define ReloadUserConfig             @"ReloadUserConfig"

/******
 
 简便的文件目录确认
 
 ******/
#define APP_DOCUMENT        [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_LIBRARY         [NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define APP_CACHES_PATH     [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define AR_CACHES_PATH      createARCachesPath()

//颜色设置
#define  COLOR_MAIN                       colorFromHexString(@"0xCC9966")
#define  COLOR_SPLITLINE                  colorFromHexString(@"E5E5E5")

#define  COLOR_PAGECONTROL_CURRENT        colorFromHexStringWithAlpha(@"000000", 0.25)
#define  COLOR_PAGECONTROL_NORMAL         colorFromHexStringWithAlpha(@"000000", 0.15)


//字体大小
#define FONT(x)                        [UIFont systemFontOfSize:x]

















static inline UIImage * readImageFromImageName(NSString * imageName){
    UIImage * image = [UIImage imageNamed:imageName];
    return image;
}

static inline UIColor * colorFromHexStringWithAlpha(NSString * colorHex, CGFloat alpha){
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorHex];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [[UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0] colorWithAlphaComponent:alpha];
}

static inline UIColor * colorFromHexString(NSString * colorHex){

    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorHex];
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

static inline UIImage * createImageWithUIColor(UIColor *color, CGSize size)
{
    UIScreen *screen = [UIScreen mainScreen];
    UIGraphicsBeginImageContextWithOptions(size, 0, screen.scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

static inline NSString * createARCachesPath(){
    
    NSString * dataFilePath = [APP_CACHES_PATH stringByAppendingPathComponent:@"AR"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir == YES && existed == YES)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dataFilePath;
}
#endif /* Header_h */
