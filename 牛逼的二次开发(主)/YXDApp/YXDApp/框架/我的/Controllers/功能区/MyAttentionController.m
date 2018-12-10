//
//  MyAttentionController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyAttentionController.h"
#import "MyAttentionControllerCell.h"
#import "MyAttentionModel.h"
#import "ShopController.h"


static NSString * kMyAttentionControllerCell = @"kmyAttentionControllerCell";

@interface MyAttentionController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）

@end

@implementation MyAttentionController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的关注";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[MyAttentionControllerCell class] forCellReuseIdentifier:kMyAttentionControllerCell];
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
    [self loadNewsData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAttentionControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyAttentionControllerCell];
    cell.model = self.dataArray[indexPath.row];
    cell.deleteMyAttenBlock = ^(NSString *favoriteId) {
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        parames[@"id"] = favoriteId;
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_delFavorite parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"删除成功"];
                [Weakself loadNewsData];
            }
        } failure:^(NSError *error) {
            
        }];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAttentionModel *model = self.dataArray[indexPath.row];
    ShopController *shopVC = [ShopController new];
    shopVC.shopId = model.shopId;
    [self.navigationController pushViewController:shopVC animated:YES];
}

- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_myinterest parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [MyAttentionModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无关注"];
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
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_myinterest parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [MyAttentionModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];

    }];
}

@end
