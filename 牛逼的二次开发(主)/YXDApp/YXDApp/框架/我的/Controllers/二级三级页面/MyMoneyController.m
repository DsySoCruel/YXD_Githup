//
//  MyMoneyController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyMoneyController.h"
#import "MyMoneyIncomeController.h"

@interface MyMoneyController ()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UILabel *myMoneyLabel;

@end

@implementation MyMoneyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的余额";
    [self setupUI];
    [self setupLayout];
    [self loadData];

}

- (void)loadData{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    [[NetWorkManager shareManager] POST:USER_mybalance parameters:parames successed:^(id json) {
        if (json) {
            self.myMoneyLabel.text = [NSString stringWithFormat:@"￥%@元",json[@"balance"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI{
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemtitle:@"余额明细" target:self action:@selector(mingxiAction:)];

    
    self.iconImageView = [UIImageView new];
    self.iconImageView.image = IMAGECACHE(@"icon_79");
    [self.view addSubview:self.iconImageView];
    
    self.moneyLabel = [UILabel new];
    self.moneyLabel.text = @"我的余额";
    self.moneyLabel.font = LPFFONT(12);
    [self.view addSubview:self.moneyLabel];
    
    self.myMoneyLabel = [UILabel new];
    self.myMoneyLabel.font = LPFFONT(30);
    [self.view addSubview:self.myMoneyLabel];
}
- (void)setupLayout{
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 90 + SafeTopSpace;
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.equalTo(self.iconImageView.mas_bottom).offset = 20;
    }];
    
    [self.myMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.equalTo(self.moneyLabel.mas_bottom).offset = 20;
    }];
}

#pragma  mark -逻辑处理
- (void)mingxiAction:(UIButton *)sender{
    MyMoneyIncomeController *vc = [MyMoneyIncomeController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
