//
//  CTToastView.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/21.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTToastView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/message.h>
#import "CTCommonUI.h"

#define UIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/******

 设备相关函数

 ******/

#ifndef IS_IPAD
#define IS_IPAD   ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
#endif
#ifndef IS_IPHONE
#define IS_IPHONE   (!IS_IPAD)
#endif
#ifndef IS_RETINA
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)
#endif

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
// log输出函数全局变量，由外部设置
apuiExternLogFuncType g_apuiExternLogFunc = nil;



@interface UIWindow (ToastView)

// window所包含的所有toast
// 时间序
@property (nonatomic, readonly) NSMutableArray *toastStack;

@end

@interface CTToastView () {
    CTToastIcon _iconType;
    UIView      *_iconView;
    UILabel     *_textLabel;
}
@property (nonatomic, assign) NSTimeInterval second;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIView *backgoundView;
@property (nonatomic, copy) void (^completion)();
//for 自动化测试
@property (nonatomic, strong) id<CTToastDelegate>toastDelegate;

// 被相关toast覆盖的次数
// 如个两个toast(或其backgroundView)的superview相同或有父子关系, 提其相关, 晚出的影响早出的suppressCount
// 当suppressCount大于0时, toast隐藏
@property(nonatomic, assign) int suppressCount;

@end

@implementation CTToastView

@synthesize second = _second;

static NSString* s_logTag = nil;
+ (void)setLogTag:(NSString*)logTag
{
    s_logTag = logTag;
}

+ (NSString*)callStackString
{
    NSArray *symbolArr = [NSThread callStackSymbols];
    
    NSMutableString *callstack = [[NSMutableString alloc] init];
    for(int i = 2; i < symbolArr.count; ++i)
    {
        id item = [symbolArr objectAtIndex:i];
        [callstack appendString:[NSString stringWithFormat:@"%@,", item]];
        if(i >= 6)
        {
            break;
        }
    }
    
    NSString* retStr = [callstack stringByReplacingOccurrencesOfString:@" " withString:@""];
    return retStr;
}

#pragma mark - 带tag的版本，tag串会打到log文件里，用来标识这个ToastView是哪弹的。业务尽量使用这组方法，方便出问题时定位哪里弹的toast。

+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                logTag:(NSString*)logTag
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithin:superview withIcon:icon text:text duration:duration];
}

+ (CTToastView *)presentTagToastWithin:(UIView *)superview text:(NSString *)text logTag:(NSString*)logTag
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithin:superview text:text];
}

+ (CTToastView *)presentTagToastWithText:(NSString *)text logTag:(NSString*)logTag
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithText:text];
}

+ (CTToastView *)presentModelTagToastWithin:(UIView *)superview text:(NSString *)text logTag:(NSString*)logTag
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentModelToastWithin:superview text:text];
}

+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                             logTag:(NSString*)logTag
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithin:superview withIcon:icon text:text];
}

+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                logTag:(NSString*)logTag
                            completion:(void (^)())completion
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithin:superview withIcon:icon text:text duration:duration completion:completion];
}

+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                 delay:(NSTimeInterval)delay
                                logTag:(NSString*)logTag
                            completion:(void (^)())completion
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentToastWithin:superview withIcon:icon text:text duration:duration delay:delay completion:completion];
}

+ (CTToastView *)presentModalTagToastWithin:(UIView *)superview
                                   withIcon:(CTToastIcon)icon
                                       text:(NSString *)text
                                   duration:(NSTimeInterval)duration
                                     logTag:(NSString*)logTag
                                 completion:(void (^)())completion
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentModalToastWithin:superview withIcon:icon text:text duration:duration completion:completion];
}

+ (CTToastView *)presentModalTagToastWithin:(UIView *)superview
                                   withIcon:(CTToastIcon)icon
                                       text:(NSString *)text
                                   duration:(NSTimeInterval)duration
                                      delay:(NSTimeInterval)delay
                                     logTag:(NSString*)logTag
                                 completion:(void (^)())completion
{
    [CTToastView setLogTag:logTag];
    return [CTToastView presentModalToastWithin:superview withIcon:icon text:text duration:duration delay:delay completion:completion];
}

#pragma mark - 没有带tag的老版本

+ (CTToastView *)presentToastWithin:(UIView *)superview withIcon:(CTToastIcon)icon text:(NSString *)text duration:(NSTimeInterval)duration
{
    return [self presentToastWithin:superview
                           withIcon:icon
                               text:text
                           duration:duration
                         completion:NULL];
}

+ (CTToastView *)presentToastWithin:(UIView *)superview withIcon:(CTToastIcon)icon text:(NSString *)text duration:(NSTimeInterval)duration completion:(void (^)())completion
{
    return [self presentToastWithin:superview
                           withIcon:icon
                               text:text
                           duration:duration
                              delay:0
                         completion:completion];
}

+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                           duration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                         completion:(void (^)())completion
{
    CTUI_EXLOG(@"%@-toastWithin:%@,%d,%@,%lf,%lf,cp:%d,callstack:%@", s_logTag, NSStringFromClass([superview class]), icon, text, duration, delay, completion?1:0 , [CTToastView callStackString]);
    s_logTag = nil;
    
    CTToastView *toast = [[CTToastView alloc] initWithText:text toastType:icon];
    toast.second = duration;
    toast.completion = completion;
    [superview addSubview:toast];
    
    if (delay > 0) {
        toast.hidden = YES;
        [toast performSelector:@selector(showDelayedToast) withObject:nil afterDelay:delay];
    } else {
        [toast pushToStack];
        [toast showToast];
    }
    return toast;
}

+ (CTToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(CTToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                              completion:(void (^)())completion
{
    return [self presentModalToastWithin:superview withIcon:icon text:text duration:duration delay:0 completion:completion];
}

+ (CTToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(CTToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                              completion:(void (^)())completion
{
    CTUI_EXLOG(@"%@-modaltoastwithin:%@,%d,%@,%lf,%lf,cp:%d,callstack:%@", s_logTag, NSStringFromClass([superview class]), icon, text, duration, delay, completion?1:0, [CTToastView callStackString]);
    s_logTag = nil;
    
    CTToastView *toast = [[CTToastView alloc] initWithText:text toastType:icon];
    toast.second = duration;
    toast.completion = completion;
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    [superview addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    
    if (delay > 0) {
        toast.hidden = YES;
        [toast performSelector:@selector(showDelayedToast) withObject:nil afterDelay:delay];
    } else {
        [toast pushToStack];
        [toast showToast];
    }
    
    return toast;
}

+ (CTToastView *)presentToastWithin:(UIView *)superview text:(NSString *)text
{
    return [CTToastView presentToastWithin:superview withIcon:CTToastIconLoading text:text];
}

+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
{
    CTUI_EXLOG(@"%@-toastwithin:%@,%@,callstack:%@", s_logTag, NSStringFromClass([superview class]), text, [CTToastView callStackString]);
    s_logTag = nil;
    
    CTToastView *toast = [[CTToastView alloc] initWithText:text toastType:icon];
    [superview addSubview:toast];
    toast.center = CGPointMake(CGRectGetMidX(toast.superview.bounds), CGRectGetMidY(toast.superview.bounds));
    
    [toast pushToStack];
    return toast;
}

+ (CTToastView *)presentToastWithText:(NSString *)text
{
    CTUI_EXLOG(@"%@-toastwithtext:%@,callstack:%@", s_logTag, text, [CTToastView callStackString]);
    s_logTag = nil;
    
    CTToastView *toast = [[CTToastView alloc] initWithText:text toastType:CTToastIconLoading];
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 44 + 20, frame.size.width, frame.size.height - 44 - 20)];
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    toast.center = CGPointMake(CGRectGetMidX(toast.superview.bounds), CGRectGetMidY(toast.superview.bounds));
    
    [toast pushToStack];
    return toast;
}

+ (CTToastView *)presentModelToastWithin:(UIView *)superview text:(NSString *)text
{
    return [self presentModelToastWithin:superview text:text autoHidden:NO];
}

+ (CTToastView *)presentModelToastWithin:(UIView *)superview text:(NSString *)text autoHidden:(BOOL)autoHidden
{
    CTUI_EXLOG(@"%@-modaltoastwithin:%@,%@,callstack:%@", s_logTag, NSStringFromClass([superview class]), text, [CTToastView callStackString]);
    s_logTag = nil;
    
    CTToastView *toast = [[CTToastView alloc] initWithText:text toastType:CTToastIconNone];
    UIView *backgroundView = [[UIView alloc] initWithFrame:superview.bounds];
    [superview addSubview:backgroundView];
    [backgroundView addSubview:toast];
    toast.backgoundView = backgroundView;
    toast.center = CGPointMake(CGRectGetMidX(toast.superview.bounds), CGRectGetMidY(toast.superview.bounds));
    
    [toast pushToStack];
    
    if (autoHidden) {
        toast.second = 3;
        [toast showToast];
    }
    return toast;
}

+ (CTToastView *)presentModelProgressWithin:(UIView *)superview text:(NSString *)text
{
    return [self presentModalTagToastWithin:superview withIcon:CTToastIconProgress text:text duration:CGFLOAT_MAX delay:0 logTag:nil completion:nil];
}

- (id)initWithText:(NSString *)text toastType:(CTToastIcon)icon
{
    self = [super init];
    if (self) {
        _iconType = icon;
        _xOffset = 0;
        _yOffset = 0;
        
        self.backgroundColor = [UIColor clearColor];
        
        // 添加提示类型图标
        [self addToastIconView];
        
        // 添加背景图片
        UIImage *bgImage = [self createImageWithColor:UIColorFromRGBA(0x1f2337,0.9)];
        UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
        [background setImage:[bgImage stretchableImageWithLeftCapWidth:6 topCapHeight:6]];
        background.layer.masksToBounds = YES;
        background.layer.cornerRadius = 10;
        [self insertSubview:background atIndex:0];
        
        //统一加载和网络错误的默认文案
        if ((!text||[text isEqualToString:@""]) && icon == CTToastIconLoading) {
            text = @"加载中";
        }
        if(icon == CTToastIconNetFailure){
            text = @"网络不给力";
        }
        else if(icon == CTToastIconNetError){
            text = @"网络无法连接";
        }
        
        CGFloat toastViewWidth = _iconView ? (IS_IPHONE_6P ? 140 : 90) : 230;
        CGFloat textWidth = _iconView ? (IS_IPHONE_6P ? 140 : 90) : (toastViewWidth - 26);
        UIFont *textFont = [UIFont systemFontOfSize:13];
        
        // 视觉要求纯文本时，左右间距为15，微调后设置为13
        CGFloat xOffset = _iconView ? 0 : 13;
        CGFloat yOffset = _iconView ? CGRectGetMaxY(_iconView.frame) + (IS_IPHONE_6P ? 17 : 10) : 15;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, textWidth, 0)];
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.numberOfLines = 0;
        if (icon == CTToastIconProgress) {
            //显示加载进度时，字号设为12
            _textLabel.font = [UIFont systemFontOfSize:12];
        }
        else{
            _textLabel.font = textFont;
        }
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.text = text;
        
        CGRect textRect = [_textLabel.text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:textFont,NSFontAttributeName, nil] context:nil];
        _textLabel.frame = CGRectMake(xOffset, yOffset, textWidth, textRect.size.height);
        
        [self addSubview:_textLabel];
        
        CGFloat toastViewHeight = CGRectGetMaxY(_textLabel.frame) + ((_iconView && IS_IPHONE_6P) ? 23 : 15);
        self.frame = CGRectMake(0, 0, toastViewWidth, toastViewHeight);
        background.frame = self.bounds;
        
        _second = 2.0;
        
        //自动化测试 获取toast显示字符串
        Class autoTestClass = NSClassFromString(@"ExternalInterface");
        if(autoTestClass){
            self.toastDelegate = [[autoTestClass alloc]init];
            [self.toastDelegate queryToastText:text];
        }
    }
    return self;
}

- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (void)addToastIconView
{
    if (_iconType == CTToastIconSuccess) {
        _iconView = [[UIImageView alloc] initWithImage:CommonUILoadImage(@"tips_success")];
        [self addSubview:_iconView];
    } else if (_iconType == CTToastIconFailure) {
        _iconView = [[UIImageView alloc] initWithImage:CommonUILoadImage(@"tips_failed")];
        [self addSubview:_iconView];
    } else if (_iconType == CTToastIconNetFailure || _iconType == CTToastIconNetError) {
        _iconView = [[UIImageView alloc] initWithImage:CommonUILoadImage(@"no_network")];
        [self addSubview:_iconView];
    } else if (_iconType == CTToastIconSecurityScan) {
        _iconView = [[UIImageView alloc] initWithImage:CommonUILoadImage(@"tips_scan")];
        [self addSubview:_iconView];
    } else if (_iconType == CTToastIconLoading || _iconType == CTToastIconProgress) {
        _iconView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self addSubview:_iconView];
        [(UIActivityIndicatorView *)_iconView startAnimating];
    }
    
    if (_iconView) {
        CGRect frame = _iconView.frame;
        frame.origin.x = ((IS_IPHONE_6P ? 140 : 90) - frame.size.width) / 2;
        frame.origin.y = IS_IPHONE_6P ? 23.0 : 15.0;
        _iconView.frame = frame;
    }
}

- (void)showToast
{
    self.hidden = NO;
    // modify by 妙玄 修改X和Y坐标的偏移量
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds) + _xOffset, CGRectGetMidY(self.superview.bounds) + _yOffset);
    if (self.toastDelegate) {
        [self.toastDelegate toastAppear];
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_second
                                                  target:self
                                                selector:@selector(dismissToast)
                                                userInfo:nil
                                                 repeats:NO];
}

- (void)showDelayedToast
{
    [self pushToStack];
    [self showToast];
}

static BOOL ALPViewContains(UIView *parent, UIView *child)
{
    while (child && child != parent) {
        child = child.superview;
    }
    return child == parent;
}

- (BOOL)relatedToToast:(CTToastView *)toast
{
    UIView *view1 = self.backgoundView ? self.backgoundView.superview : self.superview;
    UIView *view2 = toast.backgoundView ? toast.backgoundView.superview : toast.superview;
    return ALPViewContains(view1, view2) || ALPViewContains(view2, view1);
}

- (void)pushToStack
{
    [self.window.toastStack addObject:self];
    [self suppressRelatedToasts:YES];
    [self updateAllToastDisplay];
}

- (void)popFromStack
{
    [self suppressRelatedToasts:NO];
    [self.window.toastStack removeObject:self];
}

// 增减较早toast的supressCount
- (void)suppressRelatedToasts:(BOOL)flag
{
    for (CTToastView *toast in self.window.toastStack) {
        if (toast == self) {
            break;
        }
        if ([self relatedToToast:toast]) {
            toast.suppressCount += flag ? 1 : -1;
        }
    }
}

// 更新所有Toast的显示情况
- (void)updateAllToastDisplay
{
    for (CTToastView *toast in self.window.toastStack) {
        if (toast == self) {
            break;
        }
        toast.hidden = toast.suppressCount > 0;
    }
}


- (void)dismissToast
{
    [self popFromStack];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionAllowAnimatedContent
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self updateAllToastDisplay];
                         
                         //toast消失时调用的委托方法
                         if (self.toastDelegate) {
                             [self.toastDelegate toastDissAppear];
                         }
                         
                         if (self.backgoundView) {
                             [self.backgoundView removeFromSuperview];
                             self.backgoundView = nil;
                         }
                         else {
                             [self removeFromSuperview];
                         }
                         
                         if (self.completion) {
                             self.completion();
                         }
                     }];
}

// modify by 妙玄 设置X坐标的偏移量
- (void)setXOffset:(CGFloat)xOffset
{
    _xOffset = xOffset;
    self.center = CGPointMake(CGRectGetMidX(self.superview.bounds) + _xOffset, self.center.y);
}

// modify by 妙玄 设置Y坐标的偏移量
- (void)setYOffset:(CGFloat)yOffset
{
    _yOffset = yOffset;
    self.center = CGPointMake(self.center.x, CGRectGetMidY(self.superview.bounds) + _yOffset);
}

// modify by 禾兮 更新加载数据的百分比
- (void) setProgressText:(float)value
{
    if (_iconType == CTToastIconProgress) {
        _textLabel.text = [NSString stringWithFormat:@"加载数据%.0f%%",value*100];
    }
}

@end


@implementation UIWindow (ToastView)

static const char kToastStack;

- (NSMutableArray *)toastStack
{
    NSMutableArray *ret = objc_getAssociatedObject(self, &kToastStack);
    if (!ret) {
        ret = [NSMutableArray array];
        objc_setAssociatedObject(self, &kToastStack, ret, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return ret;
}

@end
