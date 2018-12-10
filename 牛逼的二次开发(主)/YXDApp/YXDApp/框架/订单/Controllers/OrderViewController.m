//
//  OrderViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderViewController.h"
#import "KMHomePageView.h"
#import "OrderListViewController.h"

@interface OrderViewController ()

@property (nonatomic, strong) KMHomePageView *pageView;


@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //判断进行登录
    if (![YXDUserInfoStore sharedInstance].loginStatus) {
        LoginViewController *login = [[LoginViewController alloc] init];
        login.isNeedSelectIndexOne = YES;
        YXDNavigationController *nav = [[YXDNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UILabel *numGoods = [[UILabel alloc] initWithFrame:titleView.bounds];
    numGoods.textAlignment = NSTextAlignmentCenter;
    numGoods.text = @"我的订单";
    numGoods.font = LPFFONT(16);
    [titleView addSubview:numGoods];
    self.navigationItem.titleView = titleView;
    
    
    [self setupUI];

}

- (void)setupUI{
    NSArray *titleArray = @[@"全部",@"待接单",@"配送中",@"已完成",@"退款"];
    NSArray *paramesArray = @[@"0",@"1",@"2",@"3",@"4"];
    NSMutableArray *controllersArray = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < 5; i ++) {
        [controllersArray addObject:@"OrderListViewController"];
    }
    _pageView = [[KMHomePageView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, YXDScreenH) withTitles:titleArray withViewControllers:controllersArray  withParameters:paramesArray];
    
    _pageView.isAnimated = YES;
    _pageView.selectedColor = THEME_COLOR;
    _pageView.unselectedColor = TEXTGray_COLOR;
    _pageView.topTabBottomLineColor = BACK_COLOR;
    _pageView.unselectedFont = LPFFONT(15);
    _pageView.selectedFont = LPFFONT(15);
    _pageView.defaultSubscript = 0;
    
    [self.view addSubview:self.pageView];
}

@end
