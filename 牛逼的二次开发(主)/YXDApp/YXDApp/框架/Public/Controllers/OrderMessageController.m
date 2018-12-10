//
//  OrderMessageController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/6.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderMessageController.h"
#import "OrderMessageControllerCell.h"
#import "OrderMessageModel.h"

static NSString *kOrderMessageControllerCell = @"OrderMessageControllerCell";

@interface OrderMessageController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）


@end

@implementation OrderMessageController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.tableView registerClass:[OrderMessageControllerCell class] forCellReuseIdentifier:kOrderMessageControllerCell];
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

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset = 0;
        make.bottom.offset = 0;
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderMessageControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderMessageControllerCell];
    //    cell.textLabel.text = @"hahahah ";
    cell.model = self.dataArray[indexPath.row];
    WeakObj(self);
    cell.deldeMessageBlock = ^{
        [Weakself loadNewsData];
    };
    return cell;
}


- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"msgType"] = @"1";

    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_message parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [OrderMessageModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无订单消息"];
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
    parames[@"msgType"] = @"1";

    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_message parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [OrderMessageModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
        
    }];
}

@end
