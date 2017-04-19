//
//  RecommendTableViewCell.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//
#import "RecommendTableViewCell.h"
#import "HomeViewInteractor.h"
#import "Masonry.h"
#import "HomeRecoomendGoodsModel.h"
#import "UIImageView+WebCache.h"
#import "PriceLabel.h"
#import "TitleLabel.h"
#import "SplitLineView.h"

@interface RecommendTableViewCell ()

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation RecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setupView:(NSArray *)dataArr{
    
    self.title.textColor = self.subtitle.textColor = colorFromHexString(@"323232");
    
    [self addMasonry];
    [self addGuesture:self.topLeftView];
    [self addGuesture:self.topMiddleView];
    [self addGuesture:self.topRightView];
    [self addGuesture:self.bottomLeftView];
    [self addGuesture:self.bottomMiddleView];
    [self addGuesture:self.bottomRightView];
    
    if (!_dataSource) {
        _dataSource = [NSArray new];
    }
    _dataSource = dataArr;

    [self configTargetView:self.topLeftTitle withModel:0];
    [self configTargetView:self.topLeftImageView withModel:0];
    [self configTargetView:self.topLeftPrice withModel:0];
    
    [self configTargetView:self.topMiddleImageView withModel:1];
    [self configTargetView:self.topMiddlePrice withModel:1];
    [self configTargetView:self.topMiddleTitle withModel:1];
    
    [self configTargetView:self.topRightTitle withModel:2];
    [self configTargetView:self.topRightImageView withModel:2];
    [self configTargetView:self.topRightPrice withModel:2];
    
    [self configTargetView:self.bottomLeftPrice withModel:3];
    [self configTargetView:self.bottomLeftTitle withModel:3];
    [self configTargetView:self.bottomLeftImageView withModel:3];
    
    [self configTargetView:self.bottomMiddlePrice withModel:4];
    [self configTargetView:self.bottomMiddleTitle withModel:4];
    [self configTargetView:self.bottomMiddleImageView withModel:4];
    
    [self configTargetView:self.bottomRightPrice withModel:5];
    [self configTargetView:self.bottomRightTitle withModel:5];
    [self configTargetView:self.bottomRightImageView withModel:5];
}

- (void)addMasonry{
    
    WEAKSELF;
    [self.topLeftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topLeftView.mas_top).offset(3);
        make.bottom.equalTo(weakSelf.topLeftTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.topLeftView.mas_left).offset(5);
        make.right.equalTo(weakSelf.topLeftView.mas_right).offset(-4);
    }];
    
    [self.topMiddleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topMiddleView.mas_top).offset(3);
        make.bottom.equalTo(weakSelf.topMiddleTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.topMiddleView.mas_left).offset(5);
        make.right.equalTo(weakSelf.topMiddleView.mas_right).offset(-4);
    }];
    
    [self.topRightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.topRightView).offset(3);
        make.bottom.equalTo(weakSelf.topRightTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.topRightView.mas_left).offset(5);
        make.right.equalTo(weakSelf.topRightView.mas_right).offset(-4);
    }];
    
    [self.bottomLeftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.bottomLeftView).offset(3);
        make.bottom.equalTo(weakSelf.bottomLeftTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.bottomLeftView.mas_left).offset(5);
        make.right.equalTo(weakSelf.bottomLeftView.mas_right).offset(-4);
    }];
    
    
    [self.bottomMiddleImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.bottomMiddleView).offset(3);
        make.bottom.equalTo(weakSelf.bottomMiddleTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.bottomMiddleView.mas_left).offset(5);
        make.right.equalTo(weakSelf.bottomMiddleView.mas_right).offset(-4);
    }];
    
    [self.bottomRightImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.bottomRightView.mas_top).offset(3);
        make.bottom.equalTo(weakSelf.bottomRightTitle.mas_top).offset(-5);
        make.left.equalTo(weakSelf.bottomRightView.mas_left).offset(5);
        make.right.equalTo(weakSelf.bottomRightView.mas_right).offset(-4);
    }];
}

- (void)configTargetView:(UIView *)targetView withModel:(NSInteger)index{

    HomeRecoomendGoodsModel * model = self.dataSource[index];
    NSString * subStr2 = [model.sellingPrice substringWithRange:NSMakeRange(model.sellingPrice.length - 2, 2)];
    NSString * subStr1 = [model.sellingPrice substringWithRange:NSMakeRange(0, model.sellingPrice.length - 2)];
    //带删除线的text
//    NSAttributedString * str = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@.%@", subStr1, subStr2] attributes:
//                                @{NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                  NSStrikethroughColorAttributeName:COLOR_MAIN,
//                                  NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternSolid),
//                                  NSForegroundColorAttributeName:colorFromHexString(@"5bcec0")}];
    if ([targetView isKindOfClass:[PriceLabel class]]) {

        if (!subStr1 && !subStr2) {
            ((UILabel *)targetView).text = [NSString stringWithFormat:@"¥0.00"];
        }else
            ((UILabel *)targetView).text = [NSString stringWithFormat:@"¥%@.%@", subStr1, subStr2];
//            ((UILabel *)targetView).attributedText = str;
    }
    if ([targetView isKindOfClass:[TitleLabel class]]) {
        ((UILabel*)targetView).text = model.commodityTitle;
    }
    if ([targetView isKindOfClass:[UIImageView class]]) {
        [((UIImageView *)targetView) sd_setImageWithURL:URLWITHSTRING(model.mainPicURLs) placeholderImage:readImageFromImageName(@"")];
    }
}

- (void)addGuesture:(UIView *)view{
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(recommendImageViewClicked:)];
    [view addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
