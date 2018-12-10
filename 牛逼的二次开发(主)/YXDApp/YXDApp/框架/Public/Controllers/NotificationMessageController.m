//
//  NotificationMessageController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/6.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "NotificationMessageController.h"
#import "KMHomePageView.h"

@interface NotificationMessageController ()
@property (nonatomic, strong) KMHomePageView *pageView;
@end

@implementation NotificationMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

    NSArray *titleArray = @[@"订单消息",@"系统消息"];
    NSArray *paramesArray = @[@"0",@"1"];
    NSMutableArray *controllersArray = [NSMutableArray arrayWithCapacity:5];
    [controllersArray addObject:@"OrderMessageController"];
    [controllersArray addObject:@"SystemController"];
    
    _pageView = [[KMHomePageView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, YXDScreenH) withTitles:titleArray withViewControllers:controllersArray  withParameters:paramesArray];
    
    _pageView.isAnimated = YES;
    _pageView.selectedColor = THEME_COLOR;
    _pageView.unselectedColor = TEXTGray_COLOR;
    _pageView.topTabBottomLineColor = BACK_COLOR;
    _pageView.unselectedFont = LPFFONT(15);
    _pageView.selectedFont = LPFFONT(15);
    _pageView.defaultSubscript = self.isNeedSelect ? 1 : 0;
    
    [self.view addSubview:self.pageView];
}


@end
