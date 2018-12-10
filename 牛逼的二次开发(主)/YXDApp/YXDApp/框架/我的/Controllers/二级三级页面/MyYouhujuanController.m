//
//  MyYouhujuanController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyYouhujuanController.h"
#import "MyYouhujuanControllerCell.h"
#import "MyyouhuijuanModel.h"

static NSString *kMyYouhujuanControllerCell = @"MyYouhujuanControllercell";

@interface MyYouhujuanController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation MyYouhujuanController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的优惠卷";
    [self loadData];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[MyYouhujuanControllerCell class] forCellReuseIdentifier:kMyYouhujuanControllerCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyYouhujuanControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyYouhujuanControllerCell];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)loadData{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_myconpon parameters:parames successed:^(id json) {
        if (json) {
            NSArray *moreArray = [MyyouhuijuanModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:moreArray];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:@"暂无优惠卷可用"];
            }else{
                [Weakself hideEmptyView];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}


@end
