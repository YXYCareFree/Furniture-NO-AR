//
//  HomeViewController.m
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewInteractor.h"
#import "HomeBannerView.h"
#import "UUIDManager.h"
#import "ControllerManager.h"

@interface HomeViewController ()

@property (nonatomic, strong) HomeViewInteractor * interactor;

@end

@implementation HomeViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.interactor = [HomeViewInteractor new];
        self.interactor.controller = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setUIInterfaceOrientationPortrait];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupView];
    [self.interactor loadHome];
    [ControllerManager shareInstance].homeVC = self;
}

- (void)setupView{

    [self initNavBar];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 70) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self.interactor;
    _tableView.dataSource = self.interactor;
    _tableView.tableHeaderView = self.headerBannerView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//设置分割线为None
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

- (void)initNavBar{
    //LeftNavBar
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
    UIImage * image = [UIImage imageNamed:@"scan"];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [leftBtn setBackgroundImage:image forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn addTarget:self.interactor action:@selector(scanClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 40, 15)];
    leftLabel.userInteractionEnabled = YES;
    leftLabel.text = @"扫一扫";
    leftLabel.textColor = COLOR_MAIN;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:10];
  
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(scanClicked:)];
    [leftView addGestureRecognizer:tap];
   
    [leftView addSubview:leftBtn];
    [leftView addSubview:leftLabel];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;

    //RightNavBar
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setTitle:@"AR" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    [rightBtn addTarget:self.interactor action:@selector(ARClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIView * titleView = [self createTitleView];
    self.navigationItem.titleView = titleView;
}

- (UIView *)createTitleView{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 120, 35)];
    view.backgroundColor = colorFromHexString(@"F8F8F8");
    view.layer.cornerRadius = 2.5;
    view.clipsToBounds = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 15, 15)];
    imageView.image = [UIImage imageNamed:@"search"];
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 50, 35)];
    label.text = @"搜索";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = colorFromHexString(@"8E8E93");
    label.textAlignment = NSTextAlignmentLeft;
    label.userInteractionEnabled = YES;
    [view addSubview:label];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(searchClicked:)];
    [view addGestureRecognizer:tap];
    
    return view;
}

- (HomeBannerView *)headerBannerView{

    if (!_headerBannerView) {
        if (IS_IPAD_PRO || IS_IPAD) {
            _headerBannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
        }else
        _headerBannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        _headerBannerView.interactor = self.interactor;
    }
    return _headerBannerView;
}

@end
