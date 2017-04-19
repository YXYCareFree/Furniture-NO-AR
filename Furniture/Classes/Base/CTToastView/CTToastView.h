//
//  CTToastView.h
//  SmartOA
//
//  Created by 冯增亮 on 15/10/21.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

// log输出函数声明，由外部设置
typedef void(*apuiExternLogFuncType)(NSString *tag, NSString *format, ...);
extern apuiExternLogFuncType g_apuiExternLogFunc;
#define CTUI_EXLOG(fmt, ...) {if(g_apuiExternLogFunc)g_apuiExternLogFunc(@"@CTUI",fmt,##__VA_ARGS__);}


/**
 *  添加新的toastIcon时，请向后添加，不要在中间插入，否则业务使用会有问题
 */
typedef enum{
    CTToastIconNone = 0,    // 无图标
    CTToastIconSuccess,     // 成功图标
    CTToastIconFailure,     // 失败图标
    CTToastIconLoading,     // 加载图标
    CTToastIconNetFailure,  // 网络失败
    CTToastIconSecurityScan,// 安全扫描
    CTToastIconNetError,    // 网络错误，完全无法连接
    CTToastIconProgress,    // 加载图标，显示加载进度
} CTToastIcon;

@protocol CTToastDelegate <NSObject>

/**
 * 得到当前toast显示文本
 *
 * text当前toast展示的文本
 *
 */
- (void)queryToastText:(NSString*)text;

/**
 * toast显示时调用此方法
 */
- (void)toastAppear;

/**
 * toast消失时调用此方法
 */
- (void)toastDissAppear;
@end

/**
 * Toast
 */
@interface CTToastView : UIView

@property (nonatomic, assign) CGFloat xOffset; // 设置相对父视图中心位置X坐标方向的偏移量
@property (nonatomic, assign) CGFloat yOffset; // 设置相对父视图中心位置Y坐标方向的偏移量

/**
 * 设置一个tag串，紧挨着presentToastView时打到log里，用来标识这个ToastView是哪弹的。
 */
+ (void)setLogTag:(NSString*)logTag;


#pragma mark - 带tag的版本，tag串会打到log文件里，用来标识这个ToastView是哪弹的。业务尽量使用这组方法，方便出问题时定位哪里弹的toast。

+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                logTag:(NSString*)logTag;
+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                             logTag:(NSString*)logTag;
+ (CTToastView *)presentTagToastWithin:(UIView *)superview text:(NSString *)text logTag:(NSString*)logTag;
+ (CTToastView *)presentTagToastWithText:(NSString *)text logTag:(NSString*)logTag;
+ (CTToastView *)presentModelTagToastWithin:(UIView *)superview text:(NSString *)text logTag:(NSString*)logTag;
+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                logTag:(NSString*)logTag
                            completion:(void (^)())completion;
+ (CTToastView *)presentTagToastWithin:(UIView *)superview
                              withIcon:(CTToastIcon)icon
                                  text:(NSString *)text
                              duration:(NSTimeInterval)duration
                                 delay:(NSTimeInterval)delay
                                logTag:(NSString*)logTag
                            completion:(void (^)())completion;
+ (CTToastView *)presentModalTagToastWithin:(UIView *)superview
                                   withIcon:(CTToastIcon)icon
                                       text:(NSString *)text
                                   duration:(NSTimeInterval)duration
                                     logTag:(NSString*)logTag
                                 completion:(void (^)())completion;
+ (CTToastView *)presentModalTagToastWithin:(UIView *)superview
                                   withIcon:(CTToastIcon)icon
                                       text:(NSString *)text
                                   duration:(NSTimeInterval)duration
                                      delay:(NSTimeInterval)delay
                                     logTag:(NSString*)logTag
                                 completion:(void (^)())completion;

#pragma mark - 没有带tag的老版本


/**
 * 显示Toast
 *
 * @param superview 父视图
 * @param icon      图标类型
 * @param text      显示文本
 * @param duration  显示时长
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                           duration:(NSTimeInterval)duration;

/**
 * 显示Toast，需调用dismissToast方法使Toast消失
 *
 * @param superview 父视图
 * @param icon      图标类型
 * @param text      显示文本
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text;

/**
 * 显示Toast，需调用dismissToast方法使Toast消失
 *
 * @param superview 父视图
 * @param text      显示文本
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithin:(UIView *)superview text:(NSString *)text;

/*
 * 模态显示提示，此时屏幕不响应用户操作，需调用dismissToast方法使Toast消失
 *
 * @param text 显示文本
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithText:(NSString *)text;

/*
 * 模态toast，需调用dismissToast方法使Toast消失
 *
 * @param superview 父视图
 * @param text      显示文本
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentModelToastWithin:(UIView *)superview text:(NSString *)text;

/*
 * 模态toast，autoHidden为NO需调用dismissToast方法使Toast消失
 *
 * @param superview  父视图
 * @param text       显示文本
 * @param autoHidden 自动隐藏
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentModelToastWithin:(UIView *)superview text:(NSString *)text autoHidden:(BOOL)autoHidden;

/*
 * 模态Progress Toast，需调用dismissToast方法使Toast消失
 *
 * @param superview  父视图
 * @param text       显示文本
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentModelProgressWithin:(UIView *)superview text:(NSString *)text;

/*
 * 使toast消失
 */
- (void)dismissToast;

/**
 * 显示当前加载数据的进度百分比
 *
 * @param value      当前已加载的数据，范围为<0.0，1.0>
 *
 */
- (void) setProgressText:(float)value;


/**
 * 显示Toast
 *
 * @param superview     要在其中显示Toast的视图
 * @param icon          图标类型
 * @param text          显示文本
 * @param duration      显示时长
 * @param completion    Toast自动消失后的回调
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                           duration:(NSTimeInterval)duration
                         completion:(void (^)())completion;

/**
 * 显示Toast
 *
 * @param superview     要在其中显示Toast的视图
 * @param icon          图标类型
 * @param text          显示文本
 * @param duration      显示时长
 * @param delay         延迟显示时长
 * @param completion    Toast自动消失后的回调
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentToastWithin:(UIView *)superview
                           withIcon:(CTToastIcon)icon
                               text:(NSString *)text
                           duration:(NSTimeInterval)duration
                              delay:(NSTimeInterval)delay
                         completion:(void (^)())completion;

/**
 * 显示模态Toast
 *
 * @param superview     要在其中显示Toast的视图
 * @param icon          图标类型
 * @param text          显示文本
 * @param duration      显示时长
 * @param completion    Toast自动消失后的回调
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(CTToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                              completion:(void (^)())completion;


/**
 * 显示模态Toast
 *
 * @param superview     要在其中显示Toast的视图
 * @param icon          图标类型
 * @param text          显示文本
 * @param duration      显示时长
 * @param delay         延迟显示时长
 * @param completion    Toast自动消失后的回调
 *
 * @return 返回显示的Toast对象
 */
+ (CTToastView *)presentModalToastWithin:(UIView *)superview
                                withIcon:(CTToastIcon)icon
                                    text:(NSString *)text
                                duration:(NSTimeInterval)duration
                                   delay:(NSTimeInterval)delay
                              completion:(void (^)())completion;
@end
