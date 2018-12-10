//
//  OrderDetailController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailFirstCell.h"
#import "OrderDetailSecondCell.h"
#import "OrderDetailThirdCell.h"
#import "OrderDetailControllerModel.h"
#import "GiveCommentController.h"

static NSString *kOrderDetailFirstCell = @"kOrderDetailFirstCell";
static NSString *kOrderDetailSecondCell = @"kOrderDetailSecondCell";
static NSString *kOrderDetailThirdCell = @"kOrderDetailThirdCell";


@interface OrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) OrderDetailControllerModel *model;
//底部功能区
@property (nonatomic,strong) UIView *bottomView;//
@property (nonatomic,strong) UIButton *cuidanButton;//催单  （待接单）
@property (nonatomic,strong) UIButton *cancleButton;//取消订单 （待接单）
@property (nonatomic,strong) UIButton *sureButton;//确认收货    （配送中）
@property (nonatomic,strong) UIButton *commentButton;//评价  （已完成）

@property (nonatomic,assign) BOOL isNeedPresentAll;

@end

@implementation OrderDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:IMAGECACHE(@"icon_70") highImage:nil target:self action:@selector(callAction)];
    [self setUpUI];
}

- (void)setUpUI{
    self.view.backgroundColor = BACK_COLOR;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.tableView registerClass:[OrderDetailFirstCell class] forCellReuseIdentifier:kOrderDetailFirstCell];
    [self.tableView registerClass:[OrderDetailSecondCell class] forCellReuseIdentifier:kOrderDetailSecondCell];
    [self.tableView registerClass:[OrderDetailThirdCell class] forCellReuseIdentifier:kOrderDetailThirdCell];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    if ([self.model.order.orderStatus integerValue] < 0) {//退款详情
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset = 0;
            make.top.offset = 64;
        }];
    }else{
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.top.offset = 64;
            make.bottom.offset = -50;
        }];
        //底部功能区
        self.bottomView = [UIView new];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.bottomView];
        
        if ([self.model.order.orderStatus integerValue] == 0 ||[self.model.order.orderStatus integerValue] == 1 || [self.model.order.orderStatus integerValue] == 2 ) {
            //待接单
            
            self.cuidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cuidanButton.titleLabel.font = LPFFONT(13);
            [self.cuidanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.cuidanButton.backgroundColor = THEME_COLOR;
            self.cuidanButton.layer.cornerRadius = 2;
            [self.cuidanButton setTitle:@"催单" forState:UIControlStateNormal];
            [self.cuidanButton setTitle:@"已催单" forState:UIControlStateSelected];
            [self.cuidanButton addTarget:self action:@selector(cuidanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:self.cuidanButton];
            
            self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.cancleButton.titleLabel.font = LPFFONT(13);
            [self.cancleButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
            self.cancleButton.layer.cornerRadius = 2;
            self.cancleButton.layer.borderWidth = 0.5;
            self.cancleButton.layer.borderColor = TEXTGray_COLOR.CGColor;
            [self.cancleButton setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:self.cancleButton];
            
            self.cuidanButton.selected = [self.model.order.reminder integerValue];
            if (self.cuidanButton.selected) {
                self.cuidanButton.backgroundColor = UNAble_color;
            }else{
                self.cuidanButton.backgroundColor = THEME_COLOR;
            }
            
            [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 30;
                make.width.offset = 70;
                make.centerY.offset = 0;
                make.right.offset = - 10;
            }];
            
            [self.cuidanButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 30;
                make.width.offset = 60;
                make.centerY.offset = 0;
                make.right.equalTo(self.cancleButton.mas_left).offset = - 15;
            }];
            
            
        }else if ([self.model.order.orderStatus integerValue] == 3 || [self.model.order.orderStatus integerValue] == -5 || [self.model.order.orderStatus integerValue] ==   5|| [self.model.order.orderStatus integerValue] == 6 ){
            //配送中
            self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.sureButton.titleLabel.font = LPFFONT(13);
            [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.sureButton.backgroundColor = THEME_COLOR;
            self.sureButton.layer.cornerRadius = 2;
            [self.sureButton setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:self.sureButton];

            [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 30;
                make.width.offset = 70;
                make.centerY.offset = 0;
                make.right.offset = - 10;
            }];
            
        }else if ([self.model.order.orderStatus integerValue] == 4){
            //已完成
            self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.commentButton.titleLabel.font = LPFFONT(13);
            [self.commentButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
            [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            self.commentButton.layer.cornerRadius = 2;
            self.commentButton.layer.borderWidth = 0.5;
            self.commentButton.layer.borderColor = THEME_COLOR.CGColor;
            [self.commentButton setTitle:@"评价" forState:UIControlStateNormal];
            [self.commentButton setTitle:@"已评价" forState:UIControlStateSelected];
            [self.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:self.commentButton];
            
            self.commentButton.selected = [self.model.order.isAppraises integerValue];
            if (self.commentButton.selected) {
                self.commentButton.backgroundColor = UNAble_color;
                self.commentButton.layer.borderWidth = 0;
            }else{
                self.commentButton.backgroundColor = [UIColor whiteColor];
                self.commentButton.layer.borderWidth = 0.5;
            }
            [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 30;
                make.width.offset = 70;
                make.centerY.offset = 0;
                make.right.offset = - 10;
            }];
        }
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset = 0;
            make.height.offset = 40;
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        OrderDetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderDetailFirstCell];
        cell.model = self.model;
        cell.isNeedPresentAll = self.isNeedPresentAll;
        WeakObj(self);
        cell.isNeedPresentAllBlock = ^(BOOL isNeedPresentAll) {
            Weakself.isNeedPresentAll = isNeedPresentAll;
            [Weakself.tableView reloadData];
        };
        return cell;
    }else if (indexPath.row == 1){
        OrderDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderDetailSecondCell];
        cell.model = self.model;
        return cell;
    }else{
        OrderDetailFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderDetailThirdCell];
        cell.model = self.model;
        return cell;
    }
}
#pragma mark -请求数据
- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.orderId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toOrderDetail parameters:parames successed:^(id json) {
        if (json) {
            Weakself.model = [OrderDetailControllerModel mj_objectWithKeyValues:json];
            [Weakself setUpUI];
        }
    } failure:^(NSError *error) {
    }];
}
#pragma mark -逻辑处理层
//1.打电话
- (void)callAction{
    if (self.model.order.shopTel.length) {
        NSString *telStr = self.model.order.shopTel;
        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL *telURL     = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebView];
    }else{
        [MBHUDHelper showError:@"暂无联系方式"];
    }
}
//评价
- (void)commentButtonAction:(UIButton *)sender{
    //1.已评论跳转我的评论
    //2.未评论进行评论
    GiveCommentController *vc= [GiveCommentController new];
    vc.orderId = self.orderId;
    vc.shopName = self.model.order.shopName;
    WeakObj(self);
    vc.updateOrderBlock = ^{
        Weakself.commentButton.selected = YES;
        Weakself.commentButton.backgroundColor = UNAble_color;
        Weakself.commentButton.layer.borderWidth = 0;
    };
}
//取消订单
- (void)cancleButtonAction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.orderId;
    parames[@"type"] = @"1";
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_changeOrder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"取消订单成功"];
            sender.userInteractionEnabled = YES;
            if (Weakself.updateOrderBlock) {
                Weakself.updateOrderBlock();
            }
            [Weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
    }];

}
//催单
- (void)cuidanButtonAction:(UIButton *)sender{
    if (sender.isSelected) {
        [MBHUDHelper showSuccess:@"已催单"];
        return;
    }
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.model.order.orderId;
    [[NetWorkManager shareManager] POST:USER_toReminder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"催单成功"];
            sender.selected = YES;
            sender.userInteractionEnabled = NO;
            sender.backgroundColor = UNAble_color;
        }
    } failure:^(NSError *error) {
    }];
}
//确认订单
- (void)sureButtonAction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.orderId;
    parames[@"type"] = @"2";
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_changeOrder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"确认收货成功"];
            sender.userInteractionEnabled = YES;
            if (Weakself.updateOrderBlock) {
                Weakself.updateOrderBlock();
            }
        }
    } failure:^(NSError *error) {
    }];
}


@end
