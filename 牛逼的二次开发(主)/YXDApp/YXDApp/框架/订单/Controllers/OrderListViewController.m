//
//  OrderListViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/22.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListViewCell.h"
#import "OrderListViewControllerModel.h"
#import "OrderDetailController.h"
#import "GiveCommentController.h"

static NSString *kOrderListViewCell = @"kOrderListViewCell";

@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）
@property (nonatomic,copy) NSString *parameter;//参数

@end

@implementation OrderListViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.tableView registerClass:[OrderListViewCell class] forCellReuseIdentifier:kOrderListViewCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewsData];
    }];
    self.tableView.mj_footer = [RefreshFooterView footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.view addSubview:self.tableView];
    [MBHUDHelper showLoadingHUDView:self.view];
    [self loadNewsData];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset = 0;
        make.bottom.offset = -49;
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderListViewCell];
    OrderListViewControllerModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    WeakObj(self)
    cell.commentActionBlock = ^(NSString *orderId) {//进行评论
        GiveCommentController *vc= [GiveCommentController new];
        vc.orderId = model.orderId;
        vc.shopName = model.shopName;
        vc.updateOrderBlock = ^{
            [Weakself loadNewsData];
        };
        [Weakself.navigationController pushViewController:vc animated:YES];
    };
    cell.cancleOrderBlock = ^{
        [Weakself loadNewsData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailController *detailController = [OrderDetailController new];
    OrderListViewControllerModel *model = self.dataArray[indexPath.row];
    detailController.orderId = model.orderId;
    detailController.title = model.shopName;
    WeakObj(self);
    detailController.updateOrderBlock = ^{
        [Weakself loadNewsData];
    };
    //搞一些事情
    [self.navigationController pushViewController:detailController animated:YES];
    
}

- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"type"] = self.parameter;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toOrderList parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [OrderListViewControllerModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无订单"];
            }else{
                [self hideEmptyView];
            }
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    self.cape++;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"type"] = self.parameter;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toOrderList parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [OrderListViewControllerModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
    }];
}





@end
