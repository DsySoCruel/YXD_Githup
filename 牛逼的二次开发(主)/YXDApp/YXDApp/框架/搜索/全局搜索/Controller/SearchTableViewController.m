//
//  SearchTableViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/23.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "SearchTableViewController.h"
#import "HomeTableViewCell.h"
#import "HomeViewModel.h"

static NSString *kSearchTableViewController = @"SearchTableViewController";

@interface SearchTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）

@end

@implementation SearchTableViewController

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"搜索列表";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:IMAGECACHE(@"icon_7") highImage:IMAGECACHE(@"icon_7") target:self action:@selector(backAction) title:@""];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:kSearchTableViewController];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewsData];
    }];
    self.tableView.mj_footer = [RefreshFooterView footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset = 0;
    }];
    //1.请求banner数据
    [self loadNewsData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchTableViewController];
    cell.model = self.dataArray[indexPath.row];
    cell.baseViewController = self.navigationController;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewModel *model = self.dataArray[indexPath.row];
    ShopController *shopView = [ShopController new];
    shopView.shopId = model.shopId;
    [self.navigationController pushViewController:shopView animated:YES];
}

- (void)loadNewsData{
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    self.cape = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        params[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    }
    params[@"areaId2"] = model.areaId2;
    params[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    params[@"latitude"] = model.latitude;
    params[@"longitude"] = model.longitude;
    params[@"seacon"] = self.keyWord;
    
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_ShopsOrGoods parameters:params successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [HomeViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:@"暂无搜索信息"];
            }else{
                [Weakself hideEmptyView];
            }
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreData{
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    self.cape++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        params[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    }
    params[@"areaId2"] = model.areaId2;
    params[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    params[@"latitude"] = model.latitude;
    params[@"longitude"] = model.longitude;
    params[@"seacon"] = self.keyWord;

    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_ShopsOrGoods parameters:params successed:^(id json) {
        if (json) {
            NSArray *array = [HomeViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
        
    }];
}


@end
