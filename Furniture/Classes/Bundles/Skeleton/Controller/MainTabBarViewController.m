//
//  MainTabBarViewController.m
//  FurniturePlatform
//
//  Created by beyondSoft on 16/12/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseUINavigationController.h"
#import "HomeViewController.h"
#import "ShoppingViewController.h"
#import "MineViewController.h"
#import "UIViewController+TabBarItemImage.h"

@interface MainTabBarViewController ()
//@property (nonatomic, assign) BOOL shouldAutorotate;
{
    BOOL _shouldAutorotate;
}
@end

@implementation MainTabBarViewController

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTabController];
    
    //注册旋转屏幕的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(autorotateInterface:) name:@"InterfaceOrientation" object:nil];
}

- (void)initTabController{

    BaseUINavigationController * homeNav = [[BaseUINavigationController alloc] initWithRootViewController:[HomeViewController new]];
    BaseUINavigationController * shopNav = [[BaseUINavigationController alloc] initWithRootViewController:[ShoppingViewController new]];
    BaseUINavigationController * mineNav = [[BaseUINavigationController alloc] initWithRootViewController:[MineViewController new]];
    self.viewControllers = @[homeNav, shopNav, mineNav];

    homeNav.tabBarItem.title = @"首页";
    shopNav.tabBarItem.title = @"购物车";
    mineNav.tabBarItem.title = @"我的";

    [homeNav setTabBarIconName:@"home_normal" selectedIconName:@"home_selected"];
    [shopNav setTabBarIconName:@"shoppingCar_normal" selectedIconName:@"shoppingCar_selected"];
    [mineNav setTabBarIconName:@"mine_normal" selectedIconName:@"mine_selected"];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       dictionaryWithObjectsAndKeys:
                                                       colorFromHexString(@"0xB4B4B4"), NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       dictionaryWithObjectsAndKeys:
                                                       COLOR_MAIN, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    self.tabBar.translucent = NO;
}

-(void)autorotateInterface:(NSNotification *)notifition{
    
    _shouldAutorotate = [notifition.object boolValue];
    NSLog(@"接收到的通知>> %d", _shouldAutorotate);
}

/**
 *
 *  @return 是否支持旋转
 */
-(BOOL)shouldAutorotate{
    
    return _shouldAutorotate;
}

/**
 *  适配旋转的类型
 *
 *  @return 类型
 */
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    if (!_shouldAutorotate) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
