//
//  LoginViewController.m
//  Furniture
//
//  Created by 王小娜 on 2017/3/16.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginControllerInteractor.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginIconTopConstraint;

@property (nonatomic, strong) LoginControllerInteractor * interactor;

@end

@implementation LoginViewController

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _interactor = [LoginControllerInteractor new];
        _interactor.controller = self;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI{
    
   UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    if (kScreenHeight == 736) {
        self.loginIconTopConstraint.constant = 130;
    }
    
    self.loginBgView.clipsToBounds = YES;
    self.loginBgView.layer.cornerRadius = 5;
    self.loginBgView.backgroundColor = colorFromHexStringWithAlpha(@"cc9966", 0.1);
    
    NSAttributedString * phoneStr = [[NSAttributedString alloc] initWithString:@"昵称/手机号" attributes:@{
                                                                      NSFontAttributeName: FONT(15),
                                                                      NSForegroundColorAttributeName: colorFromHexString(@"e9dbcc")}];
    self.phoneTextField.attributedPlaceholder = phoneStr;
    
    NSAttributedString * pswordStr = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{
                                                                                                 NSFontAttributeName: FONT(15),
                                                                                                 NSForegroundColorAttributeName: colorFromHexString(@"e9dbcc")}];
    self.pswordTextField.attributedPlaceholder = pswordStr;
    self.pswordTextField.secureTextEntry = YES;//密文显示
    
    self.phoneTextField.backgroundColor = self.pswordTextField.backgroundColor = [UIColor clearColor];
    self.phoneTextField.borderStyle = self.pswordTextField.borderStyle = UITextBorderStyleNone;
    
    self.loginBtn.clipsToBounds = self.registerBtn.clipsToBounds = YES;
    self.registerBtn.layer.cornerRadius = self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.backgroundColor = self.registerBtn.backgroundColor = COLOR_MAIN;
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.splitView.backgroundColor = colorFromHexStringWithAlpha(@"b28659", 0.23);
    [self.findPswordBtn setTitleColor:COLOR_MAIN forState:UIControlStateNormal];
    
    [self.loginBtn addTarget:self.interactor action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerBtn addTarget:self.interactor action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.findPswordBtn addTarget:self.interactor action:@selector(findPswordBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)dismissKeyboard{
    [self.view.window endEditing:YES];
}

#pragma mark--UIKeyboard Notification
- (void)keyboardWillShow:(NSNotification *)notifi{
    
    CGRect keyboardRect = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [[notifi.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    UIView * view = self.view;
    UIButton * btn = self.loginBtn;
    
    CGPoint origin = [view convertPoint:btn.frame.origin fromView:btn.superview];
    origin.y += btn.frame.size.height + 2;
    
    CGFloat offset = origin.y - keyboardRect.origin.y;
    if (offset < 0) {
        return;
    }
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = view.frame;
        frame.origin.y = -offset;
        view.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notifi{
    
    double duration = [[notifi.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    BOOL hidden = self.navigationController.navigationBarHidden;
    if ((hidden && self.view.frame.origin.y == 0) || (!hidden && self.view.frame.origin.y == 64)) {
        return;
    }
    
    [UIView animateWithDuration:duration animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

@end
