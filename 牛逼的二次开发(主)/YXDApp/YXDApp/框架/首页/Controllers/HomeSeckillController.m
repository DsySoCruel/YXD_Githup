//
//  HomeSeckillController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeSeckillController.h"
#import "HomeSeckillControllerCell.h"
#import "SDCycleScrollView.h"
#import "HomBannerModel.h"
#import "HomeSeckillModel.h"
#import "HomeGroupModel.h"
#import "GoodController.h"

static NSString *kHomeSeckillControllerCell = @"HomeSeckillController";

@interface HomeSeckillController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）
@property (nonatomic,strong) NSMutableArray *bannerModelDataArray;

@end

@implementation HomeSeckillController


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}

- (NSMutableArray *)bannerModelDataArray{
    if (!_bannerModelDataArray) {
        _bannerModelDataArray = [NSMutableArray array];
    }
    return _bannerModelDataArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.seckillType == SeckillTypeOne) {
        self.title = @"秒杀特惠";
    }else{
        self.title = @"精品团购";
    }
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cycleScrollView = [SDCycleScrollView new];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.backgroundColor = [UIColor whiteColor];
//    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageHighlight"];
//    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageNormal"];
    [self.view addSubview:self.cycleScrollView];
    
    WeakObj(self)
    [self.cycleScrollView setClickItemOperationBlock:^(NSInteger index){
        HomBannerModel *model = Weakself.bannerModelDataArray[index];
        ShopController *shopView = [ShopController new];
        shopView.shopId = model.adURL;
        [Weakself.navigationController pushViewController:shopView animated:YES];
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[HomeSeckillControllerCell class] forCellReuseIdentifier:kHomeSeckillControllerCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.tableView.mj_footer resetNoMoreData];
        [self loadNewsData];
    }];
    
    RefreshFooterView *footer = [RefreshFooterView footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    self.tableView.mj_footer = footer;
    [self.view addSubview:self.tableView];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset = 0;
        make.top.offset = 64 + SafeTopSpace;
        make.height.offset = YXDScreenW/1.875;
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset = 0;
    }];
    
    //1.请求banner数据
    [self loadBannerData];
    [self loadNewsData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSeckillControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeSeckillControllerCell];
    if (self.seckillType == SeckillTypeOne) {
        cell.mdoel = self.dataArray[indexPath.row];
    }else{
        cell.groupModel = self.dataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSeckillModel *model = self.dataArray[indexPath.row];
    GoodController *goodController = [GoodController new];
    goodController.goodsId = model.goodsId;
    goodController.shopId = model.shopId;
    [self.navigationController pushViewController:goodController animated:YES];
}


#pragma mark-请求数据
- (void)loadBannerData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    if (self.seckillType == SeckillTypeOne) {
        parames[@"id"] = @"-20";
    }else{
        parames[@"id"] = @"-21";
    }
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_banner parameters:parames successed:^(id json) {
        if (json) {
            NSArray *moreArray = [HomBannerModel mj_objectArrayWithKeyValuesArray:json];
            NSMutableArray *images = [NSMutableArray new];
            [Weakself.bannerModelDataArray removeAllObjects];
            [moreArray enumerateObjectsUsingBlock:^(HomBannerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:[NSString stringWithFormat:@"%@/%@",YXDMainPath,obj.adFile]];
                [Weakself.bannerModelDataArray addObject:obj];
            }];
            Weakself.cycleScrollView.imageURLStringsGroup = images;
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)loadNewsData{
    
    NSString *url = self.seckillType == SeckillTypeOne ? USER_secKill : USER_purchase;
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"areaId2"] = model.areaId2;
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:url parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            
            if (Weakself.seckillType == SeckillTypeOne) {
                NSArray *array = [HomeSeckillModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
                [Weakself.dataArray addObjectsFromArray:array];
            }else{
                NSArray *array = [HomeGroupModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
                [Weakself.dataArray addObjectsFromArray:array];
            }
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:self.seckillType == SeckillTypeOne ? @"暂无秒杀信息" : @"暂无团购信息"];
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
    NSString *url = self.seckillType == SeckillTypeOne ? USER_secKill : USER_purchase;
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    self.cape++;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"areaId2"] = model.areaId2;
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:url parameters:parames successed:^(id json) {
        [Weakself.tableView.mj_footer endRefreshing];
        if (json) {
            if (Weakself.seckillType == SeckillTypeOne) {
                NSArray *array = [HomeSeckillModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
                if (array.count == 0) {//没有数据、
                    [Weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [Weakself.dataArray addObjectsFromArray:array];
                    [Weakself.tableView reloadData];
                }
                
            }else{
                NSArray *array = [HomeGroupModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
                if (array.count == 0) {//没有数据、
                    [Weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [Weakself.dataArray addObjectsFromArray:array];
                    [Weakself.tableView reloadData];
                }
            }
//            [Weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
        
    }];
}

@end
