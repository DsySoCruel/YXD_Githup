//
//  ShopCarViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarViewCell.h"
#import "ShopCarViewModel.h"
#import "ShopCarDetailController.h"

static NSString *kShopCarViewControllerCell = @"kShopCarViewControllerCell";

@interface ShopCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UILabel *titlLa;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）

@end

@implementation ShopCarViewController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    //判断进行登录
    if (![YXDUserInfoStore sharedInstance].loginStatus) {
        LoginViewController *login = [[LoginViewController alloc] init];
        login.isNeedSelectIndexOne = YES;
        YXDNavigationController *nav = [[YXDNavigationController alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];        
    }else{
        [self loadNewsData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UILabel *numGoods = [[UILabel alloc] initWithFrame:titleView.bounds];
    numGoods.textAlignment = NSTextAlignmentCenter;
    numGoods.text = @"我的全部购物车";
    numGoods.font = LPFFONT(16);
    self.titlLa = numGoods;
    [titleView addSubview:numGoods];
    self.navigationItem.titleView = titleView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewsData) name:@"updateMyShopCar" object:nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[ShopCarViewCell class] forCellReuseIdentifier:kShopCarViewControllerCell];
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopCarViewControllerCell];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarDetailController *vc = [ShopCarDetailController new];
    ShopCarViewModel *model = self.dataArray[indexPath.row];
    vc.shopId = model.shopName.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}

/*改变删除按钮的title*/
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        //进行删除操作
        ShopCarViewModel *model = self.dataArray[indexPath.row];
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        parames[@"shopId"] = model.shopName.shopId;
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_removeCart parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"删除成功"];
                [Weakself.dataArray   removeObjectAtIndex:indexPath.row];  //删除数组里的数据
                [Weakself.tableView   deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
                if (Weakself.dataArray.count == 0) {
                    [Weakself showEmptyMessage:@"购物车为空"];
                }else{
                    [Weakself hideEmptyView];
                }
            }
            [Weakself.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            [Weakself.tableView.mj_header endRefreshing];
        }];
    }
}


#pragma mark-请求数据
- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toCart parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [ShopCarViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:@"购物车为空"];
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
    self.cape++;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toCart parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [ShopCarViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
