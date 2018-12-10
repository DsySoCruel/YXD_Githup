//
//  YXDTabBarController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "YXDTabBarController.h"
#import "YXDNavigationController.h"

#import "HomeViewController.h"
#import "CategoryViewController.h"
#import "ShopCarViewController.h"
#import "OrderViewController.h"
#import "MineViewController.h"

@interface YXDTabBarController ()

@end

@implementation YXDTabBarController

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    //    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = THEME_COLOR;
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
}

/*
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 首页
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    YXDNavigationController *homeNav = [[YXDNavigationController alloc] initWithRootViewController:homeViewController];
    [self addChildViewController:homeNav];
    
    // 分类
    CategoryViewController *categoryViewController = [[CategoryViewController alloc] init];
    YXDNavigationController *categoryNav = [[YXDNavigationController alloc] initWithRootViewController:categoryViewController];
    [self addChildViewController:categoryNav];
    
    // 购物车
    ShopCarViewController *shopCarViewController = [[ShopCarViewController alloc] init];
    YXDNavigationController *shopCarNav = [[YXDNavigationController alloc] initWithRootViewController:shopCarViewController];
    [self addChildViewController:shopCarNav];
    
    // 订单
    OrderViewController *orderViewController = [[OrderViewController alloc] init];
    YXDNavigationController *orderNav = [[YXDNavigationController alloc] initWithRootViewController:orderViewController];
    [self addChildViewController:orderNav];
    
    // 我的
    MineViewController *meViewController = [[MineViewController alloc] init];
    YXDNavigationController *meNav = [[YXDNavigationController alloc] initWithRootViewController:meViewController];
    [self addChildViewController:meNav];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"首页";
    nav.tabBarItem.image = [UIImage imageNamed:@"home"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"home_select"];
    
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"分类";
    nav1.tabBarItem.image = [UIImage imageNamed:@"category"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"category_select"];
    
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"购物车";
    nav3.tabBarItem.image = [UIImage imageNamed:@"shopcar"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"shopcar_select"];
    
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"订单";
    nav4.tabBarItem.image = [UIImage imageNamed:@"order"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"order_select"];
    
    UINavigationController *nav5 = self.childViewControllers[4];
    nav5.tabBarItem.title = @"我的";
    nav5.tabBarItem.image = [UIImage imageNamed:@"mine"];
    nav5.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"mine_select"];
}

- (void)receiveNotification{
    //为了消除警告
}

@end
