//
//  ShopDetailController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailController.h"
#import "ShopControllerView.h"
#import "ShopDetailSectionHeaderView.h"
#import "ShopDetailControllerFirstCell.h"
#import "ShopDetailControllerSecondCell.h"
#import "ShopDetailControllerThirdCell.h"
#import "ShopMessageModel.h"

static NSString *kShopDetailControllerFirstCell = @"ShopDetailControllerFirstCell";
static NSString *kShopDetailControllerSecondCell = @"ShopDetailControllerSecondCell";
static NSString *kShopDetailControllerThirdCell = @"ShopDetailControllerThirdCell";


@interface ShopDetailController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong) ShopControllerView *headView;

@property (nonatomic,strong) UITableView *tableView;

//保存数组
@property (nonatomic,strong) NSMutableArray *dataSourceArray;//咨询数组
//请求参数
@property (nonatomic,strong) NSMutableArray *cateArray;


@end

@implementation ShopDetailController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

//- (NSMutableArray *)topDataArray{
//    if (!_topDataArray) {
//        _topDataArray = [NSMutableArray array];
//    }
//    return _topDataArray;
//}
//- (NSMutableArray *)totalDataArray{
//    if (!_totalDataArray) {
//        _totalDataArray = [NSMutableArray array];
//    }
//    return _totalDataArray;
//}

- (ShopControllerView *)headView{
    if(!_headView){
        _headView = [ShopControllerView new];
        _headView.frame = CGRectMake(0, 0, 0, 160 + SafeTopSpace);
        _headView.model = self.headModel;
    }
    return _headView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.backImageView = [UIImageView new];
    self.backImageView.image = IMAGECACHE(@"backImageView_00");
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset = 0;
    }];
    
    //设置navigationView
    [self.view addSubview:self.tableView];

    [self setupLayout];
    
}


- (void)setupLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.offset = -20 - SafeTopSpace;
    }];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[ShopDetailControllerFirstCell class] forCellReuseIdentifier:kShopDetailControllerFirstCell];
        [_tableView registerClass:[ShopDetailControllerSecondCell class] forCellReuseIdentifier:kShopDetailControllerSecondCell];
        [_tableView registerClass:[ShopDetailControllerThirdCell class] forCellReuseIdentifier:kShopDetailControllerThirdCell];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

#pragma mark tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ShopDetailSectionHeaderView *aa = [[ShopDetailSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 50)];
    if (section == 0) {
        aa.name = @"店铺优惠卷";
    }else if (section == 1){
        aa.name = @"店铺评价";
    }else{
        aa.name = @"店铺信息";
    }
    return aa;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.model.coupons.count;
     }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ShopDetailControllerFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopDetailControllerFirstCell];
        cell.model = self.model.coupons[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ShopDetailControllerSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopDetailControllerSecondCell];
        cell.model = self.model;
        return cell;
    }
    ShopDetailControllerThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopDetailControllerThirdCell];
    cell.model = self.model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//领卷
       __block ShopMessageCouponsModel *couponsModel  = self.model.coupons[indexPath.row];
        if ([couponsModel.isRecieve integerValue] == 0) {
            
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
            parames[@"accessToken"] = UserAccessToken;
            parames[@"id"] = couponsModel.couponId;
            WeakObj(self);
            [[NetWorkManager shareManager] POST:USER_addCoupon parameters:parames successed:^(id json) {
                if (json) {
                    [MBHUDHelper showSuccess:@"恭喜,抢到了"];
                    couponsModel.isRecieve = @"1";
                    [Weakself.tableView reloadData];
                }
            } failure:^(NSError *error) {
                
            }];

        }
    }
}

@end
