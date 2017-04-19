//
//  HomeViewController.h
//  Furniture
//
//  Created by beyondSoft on 17/1/3.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeBannerView;

@interface HomeViewController : UIViewController

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) HomeBannerView * headerBannerView;

@end
