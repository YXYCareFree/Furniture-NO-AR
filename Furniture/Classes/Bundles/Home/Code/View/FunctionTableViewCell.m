//
//  FunctionTableViewCell.m
//  SmartOA
//
//  Created by beyondSoft on 16/12/12.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "FunctionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HomeViewInteractor.h"
#import "HomeCategoryModel.h"

#import "Masonry.h"

NSInteger numberPerRow  = 4;    //item的列数
CGFloat top = 15;               //item距离上方的间距
CGFloat left = 30;             //item距离屏幕左侧的间距
CGFloat right = 30;            //item距离屏幕右侧的间距
CGFloat itemLeft = 20;         //item之间的间距
CGFloat height = 59;           //item的高度

CGFloat imageViewHeight = 44;
CGFloat labelHeight = 15;

@interface FunctionTableViewCell ()

@property (nonatomic, strong) NSArray * categories;

@end

@implementation FunctionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier dataArr:(NSArray *)dataArr{

    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView:(NSArray *)dataArr{

    if (!dataArr) {
        return;
    }

    if (IS_IPAD_PRO || IS_IPAD) {
        height = 80;
        imageViewHeight = 60;
    }
    self.categories = dataArr;
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self.interactor;
    
    int section = (int)self.categories.count / 9 + 1;
    [scrollView setContentSize:CGSizeMake(kScreenWidth * section, _height)];

    for (int i = 0; i < section; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, _height)];
        [self setView:view cloum:i];
        [scrollView addSubview:view];
    }
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 - 30 * section / 2, _height - 20, 30 * section, 20)];
    self.pageControl.numberOfPages = section;
    self.pageControl.pageIndicatorTintColor = COLOR_PAGECONTROL_NORMAL;
    self.pageControl.currentPageIndicatorTintColor = COLOR_PAGECONTROL_CURRENT;
    self.pageControl.hidden = !(section > 1);
    
    [self.contentView addSubview:self.pageControl];
    [self.contentView addSubview:scrollView];
}

- (void)setView:(UIView *)targetView cloum:(int)section{
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - left - right - itemLeft * 3) / numberPerRow;
    
    int count = (int)self.categories.count;

    for (int i = 0; i < count; i++) {
       
        int item = i + section * 8;//获取第几个item
        if (item >= count || (section == 0 && item == 8)) {
            return;//item超出数据源的个数和第一组数据加载完毕返回
        }
        
        HomeCategoryModel * model = self.categories[item];
        
        int row = i / 4;//行数
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(left + (width + itemLeft) * (i - 4 * row) , top * (row + 1) + height * row, width, height)];
        
        UIImageView * imageView = [UIImageView new];
        imageView.frame = CGRectMake(view.frame.size.width / 2 - imageViewHeight / 2, 0, imageViewHeight, imageViewHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:URLWITHSTRING(model.catalogImage) placeholderImage:readImageFromImageName(@"home_normal")];
        [view addSubview:imageView];
        
//        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight + 4, width, labelHeight)];
        UILabel * label = [UILabel new];
        label.text = model.catalogName;
        label.textAlignment = NSTextAlignmentCenter;
        
        int font = 12;
        if (kScreenHeight == 568) {
            font = 11;
        }
        if (kScreenHeight == 667) {
            font = 13;
        }
        if (kScreenHeight == 736) {
            font = 14;
        }
        label.font = FONT(font);
        label.textColor = COLOR_MAIN;
        label.userInteractionEnabled = YES;
        [view addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
            make.top.equalTo(imageView.bottom).offset(5);
        }];
        
        view.tag = 100 + i + section * 8;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(categoryClicked:)];
        [view addGestureRecognizer:tap];
        [targetView addSubview:view];
    }
}

- (void)setupScrollViewTest{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self.interactor;
    
    [scrollView setContentSize:CGSizeMake(kScreenWidth * 2, _height)];
    
    for (int i = 0; i < 2; i++) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, _height)];
        //[self setView:view];
        [scrollView addSubview:view];
    }
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width / 2 - 30, _height - 20, 60, 20)];
    self.pageControl.numberOfPages = 2;
    self.pageControl.pageIndicatorTintColor = COLOR_PAGECONTROL_NORMAL;
    self.pageControl.currentPageIndicatorTintColor = COLOR_PAGECONTROL_CURRENT;
    
    [self.contentView addSubview:self.pageControl];
    [self.contentView addSubview:scrollView];
}

- (NSArray *)categories{
    
    if (!_categories) {
        _categories = [NSArray new];
    }
    return _categories;
}


@end
