//
//  CategorySearchController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/10.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "CategorySearchController.h"
#import "HomeTableViewCell.h"
#import "HomeViewModel.h"

static NSString *kCategorySearchController = @"CategorySearchController";

@interface CategorySearchController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）


@end

@implementation CategorySearchController



- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:kCategorySearchController];
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
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategorySearchController];
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
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"areaId2"] = model.areaId2;
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"latitude"] = model.latitude;
    parames[@"longitude"] = model.longitude;
    parames[@"c1Id"] = self.c1Id;
    parames[@"c2Id"] = self.c2Id;
    parames[@"c3Id"] = self.c3Id;

    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getGoodsByCat parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [HomeViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:@"暂无信息"];
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
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"areaId2"] = model.areaId2;
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"latitude"] = model.latitude;
    parames[@"longitude"] = model.longitude;
    parames[@"c1Id"] = self.c1Id;
    parames[@"c2Id"] = self.c2Id;
    parames[@"c3Id"] = self.c3Id;    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getGoodsByCat parameters:parames successed:^(id json) {
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
