//
//  YXYPhotoBrowser.h
//  PhotoBrowser
//
//  Created by 杨肖宇 on 2017/4/13.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YXYPhotoBrowser;

@protocol YXYPhotoBrowserDelegate <NSObject>

/**
    获取placholderImage

 */
- (UIImageView *)photoBrowser:(YXYPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

/**
 
 @param index index是dismiss时点击的图片序号
 */
- (void)photoBrowser:(YXYPhotoBrowser *)browser dismissImageIndex:(NSInteger)index;

@end

@interface YXYPhotoBrowser : NSObject<UIScrollViewDelegate>

@property (nonatomic, strong) UIViewController * sourceVC;//想要系统样式的弹框必须设置为当前界面的VC

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, weak) id<YXYPhotoBrowserDelegate> delegate;

- (instancetype)initWithImageGroup:(NSArray *)urlArr delegate:(id)delegate;

- (void)show;

- (void)dismiss;

- (void)longPress;

@end
