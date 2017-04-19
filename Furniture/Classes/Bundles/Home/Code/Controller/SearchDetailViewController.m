//
//  SearchDetailViewController.m
//  Furniture
//
//  Created by 杨肖宇 on 2017/3/23.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "SearchDetailInteractor.h"

@interface SearchDetailViewController ()

@property (nonatomic, strong) SearchDetailInteractor * interactor;

@property (nonatomic, strong) UIView * headerView;

@end

@implementation SearchDetailViewController

- (instancetype)init{
    if (self = [super init]) {
        _interactor = [SearchDetailInteractor new];
        _interactor.controller = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"InterfaceOrientation" object:@"YES"];
    
    [self orientationToPortrait:UIInterfaceOrientationLandscapeRight];

}
-(BOOL)shouldAutorotate{
    return YES;
}

- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    
    //leftNavBar
    UIButton * leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:readImageFromImageName(@"backArrow") forState:UIControlStateNormal];
    [leftBtn addTarget:self.interactor action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    //RightNavBar
    UIButton * rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setTitle:@"AR" forState:UIControlStateNormal];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    [rightBtn addTarget:self.interactor action:@selector(ARClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.titleView = [self createTitleView];
    
//    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.delegate = _interactor;
    self.tableView.dataSource = _interactor;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tap];
}

- (UIView *)createTitleView{
    
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    textField.clipsToBounds = YES;
    textField.layer.cornerRadius = 2;
    textField.backgroundColor = colorFromHexString(@"f8f8f8");
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    leftView.backgroundColor = [UIColor clearColor];
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:readImageFromImageName(@"search")];
    leftImageView.frame = CGRectMake(10, 5, 20, 20);
    [leftView addSubview:leftImageView];
    textField.leftView = leftView;
    textField.placeholder = @" 搜索";
    textField.leftViewMode = UITextFieldViewModeAlways;

    return textField;
}

- (void)endEditing{
    [self.view.window endEditing:YES];
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        NSArray * arr = @[@"全部", @"热销", @"AR", @"筛选"];
        for (int i = 0; i < 4; i++) {
            CGFloat width = kScreenWidth / 4;
                
            UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, 35)];
            btn.tag = 1000 + i;
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setTitle:arr[i] forState:UIControlStateNormal];
            [btn setTitleColor:colorFromHexString(@"666666") forState:UIControlStateNormal];
            [btn addTarget:self.interactor action:@selector(headerViewClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    }
    return _headerView;
}
@end
