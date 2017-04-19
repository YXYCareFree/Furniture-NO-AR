//
//  SearchDetailInteractor.m
//  Furniture
//
//  Created by 杨肖宇 on 2017/3/23.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "SearchDetailInteractor.h"
#import "SearchDetailViewController.h"
#import "DetailTableViewCell.h"

static NSString * reuseCell = @"DetailTableViewCell";

@implementation SearchDetailInteractor

- (instancetype)init{
    if (self = [super init]) {
        [self.controller.tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:reuseCell];
    }
    return self;
}
- (void)backClicked:(id)sender{
    [GETCURRENTCONTROLLER.navigationController popViewControllerAnimated:YES];
}

- (void)ARClicked:(id)sender{
    [self.controller.tableView reloadData];
}

- (void)searchClicked:(id)sender{
    
}

- (void)headerViewClicked:(id)sender{
    
    UIButton * btn = (UIButton *)sender;
    
    NSInteger selectedTag = btn.tag;
    NSArray * tagArr = @[@1000, @1001, @1002, @1003];
    for (int i = 0; i < tagArr.count; i++) {
        
        UIButton * button = (UIButton *)[self.controller.tableView viewWithTag:[tagArr[i] integerValue]];
        if ([tagArr[i] integerValue] == selectedTag) {
            [button setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
        }else
            [button setTitleColor:colorFromHexString(@"666666") forState:UIControlStateNormal];
    }
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DetailTableViewCell" owner:nil options:nil] firstObject];
    }

    return cell;
}

#pragma mark--UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   UIView * _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    NSArray * arr = @[@"全部", @"热销", @"AR", @"筛选"];
    for (int i = 0; i < 4; i++) {
        CGFloat width = kScreenWidth / 4;
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, 35)];
        btn.tag = 1000 + i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:colorFromHexString(@"666666") forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(headerViewClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 3) {
            UIImageView * imageView = [[UIImageView alloc] initWithImage:readImageFromImageName(@"shape")];
            imageView.frame = CGRectMake(btn.frame.size.width - 25, 7, 18, 20);
            [btn addSubview:imageView];
        }
        [_headerView addSubview:btn];
    }
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, kScreenWidth, 1)];
    lineView.backgroundColor = colorFromHexString(@"e5e5e5");
    [_headerView addSubview:lineView];
    return _headerView;
}

@end
