//
//  SearchViewController.m
//  Furniture
//
//  Created by 王小娜 on 2017/1/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchViewInteractor.h"
#import "Masonry.h"

@interface SearchViewController ()
@property (nonatomic, strong) SearchViewInteractor * interactor;
@end

@implementation SearchViewController

- (instancetype)init{
    if (self = [super init]) {
        _interactor = [SearchViewInteractor new];
        _interactor.controller = self;
    }
    return self;
}

#pragma mark--隐藏navigationBar
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
   
    [self createBackButton];
    [self createSearchView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:tap];
}

- (void)createSearchView{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(50, 20, kScreenWidth - 100, 35)];
    view.backgroundColor = colorFromHexString(@"F8F8F8");
    view.layer.cornerRadius = 2.5;
    view.clipsToBounds = YES;
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 15, 15)];
    imageView.image = [UIImage imageNamed:@"search"];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(searchClicked:)];
    [imageView addGestureRecognizer:tap];
    [view addSubview:imageView];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, view.frame.size.width, view.frame.size.height)];
    _searchTextField.returnKeyType = UIReturnKeySearch;
    _searchTextField.delegate = self.interactor;
    _searchTextField.font = [UIFont systemFontOfSize:15];
    _searchTextField.placeholder = @"床";
    [_searchTextField becomeFirstResponder];//弹出键盘
    
    [view addSubview:_searchTextField];
    
    UIButton * searchBtn = [UIButton new];
    [self.view addSubview:view];
    [self.view addSubview:searchBtn];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.right).offset(2);
        make.width.equalTo(50);
        make.height.equalTo(35);
        make.top.equalTo(self.view.top).offset(20);
    }];
    
    searchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn addTarget:self.interactor action:@selector(searchClicked:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
}

- (void)createBackButton{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage:readImageFromImageName(@"backArrow")];
    imageView.frame = CGRectMake(0, 0, 13, 21);
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self.interactor action:@selector(backClicked:)];
    [view addGestureRecognizer:tap];
    
    [self.view addSubview:view];
}

@end
