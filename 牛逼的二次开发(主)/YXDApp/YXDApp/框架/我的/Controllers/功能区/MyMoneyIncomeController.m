//
//  MyMoneyIncomeController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/7.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyMoneyIncomeController.h"
#import "MyMoneyIncomeControllerCell.h"
#import "MyMoneyIncomeModel.h"

static NSString * kMyMoneyIncomeControllerCell = @"MyMoneyIncomeControllerCell";

@interface MyMoneyIncomeController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）

@end

@implementation MyMoneyIncomeController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额明细";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[MyMoneyIncomeControllerCell class] forCellReuseIdentifier:kMyMoneyIncomeControllerCell];
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
    MyMoneyIncomeControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyMoneyIncomeControllerCell];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_balanceDetail parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [MyMoneyIncomeModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
            [Weakself.dataArray addObjectsFromArray:array];
            
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无余额信息"];
            }else{
                [self hideEmptyView];
            }
            [Weakself.tableView reloadData];
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
    [[NetWorkManager shareManager] POST:USER_balanceDetail parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [MyMoneyIncomeModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];

    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];

    }];
}

@end
