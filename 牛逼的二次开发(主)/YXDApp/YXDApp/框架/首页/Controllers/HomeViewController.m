//
//  HomeViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeadView.h"
#import "HomeTableViewCell.h"
#import "HomeSectionHeaderView.h"
#import "ShopController.h"
#import "NotificationMessageController.h"
#import "HomeViewModel.h"
#import "HomeAlertView.h"
#import "HomeAlertViewModel.h"
#import "SearchDisplayController.h"
#import "SelectWeizhiController.h"
#import "CBSegmentView.h"
#import "HotSearchModel.h"


static NSString * homeOrganizationTableViewCell = @"homeOrganizationTableViewCell";

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,AndyDropDownDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *navigationView;//自造navigationView
@property (nonatomic, strong) UIImageView *dituImageView;
@property (nonatomic, strong) YXDButton *weizhiButton;
@property (nonatomic, strong) UIButton *paixuButton;
@property (nonatomic, strong) YXDButton *searchButton;
@property (nonatomic, strong) CBSegmentView *zoomSegmentView;
@property (nonatomic, strong) UIButton *lingButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeHeadView *headView;
//保存数组
@property (nonatomic, strong) NSMutableArray *dataSourceArray;//咨询数组
//请求参数
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）
@property (nonatomic,strong) HomeAlertView *list;
@property (nonatomic,strong) NSMutableArray *cateArray;
@property (nonatomic,strong) NSString *type;//排序类型默认为1

@property (nonatomic,strong) UIView *presentView;//蒙版view
@property (nonatomic,strong) UIImageView *aaimageView;
@property (nonatomic,strong) UILabel *presentLabel;
@property (nonatomic,strong) UIButton *switchCityButton;
@property (nonatomic,assign) NSInteger lastContentOffset;//监听tableView 滚动方向

@end

@implementation HomeViewController



-(HomeAlertView *)list
{
    if (!_list)
    {
        _list = [[HomeAlertView alloc] initWithListDataSource:self.cateArray rowHeight:44];
        _list.delegate = self;
    }
    return _list;
}
-(void)dropDownListParame:(HomeAlertViewModel *)model
{
    self.type = model.nid;
    for (HomeAlertViewModel *amodel in self.cateArray) {
        amodel.isSelect = NO;
        if ([amodel.nid isEqualToString:model.nid]) {
            amodel.isSelect = YES;
        }
    }
    [self.tableView.mj_footer resetNoMoreData];
    [self loadNewsData];
}

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

- (HomeHeadView *)headView{
    if(!_headView){
        _headView = [HomeHeadView new];
        CGFloat height = 0;
        height = YXDScreenW/2.6 + 280;
        _headView.frame = CGRectMake(0, 0, 0, height);
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
//    self.navigationController.delegate = self;
    self.type = @"1";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doubleTapNotification:) name:DoubleTapTabbarNotification object:nil];
//    self.view = self.tableView;
    
    [self setupCateArray];
    
    //设置navigationView
    [self.view addSubview:self.tableView];

//    [self loadCacheDate];
//    [self loadNewTasks];
    [self setupLayout];
    [self setUpNavigationView];

    [self getCoordinateMessage];
    
}

- (void)setUpNavigationView{
    self.navigationView = [UIView new];
    self.navigationView.backgroundColor = THEME_COLOR;
    [self.view addSubview:self.navigationView];
    
    self.dituImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_21")];
    [self.navigationView addSubview:self.dituImageView];
    
    self.weizhiButton = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.weizhiButton setTitle:@"定位中" forState:UIControlStateNormal];
    [self.weizhiButton setImage:IMAGECACHE(@"icon_22") forState:UIControlStateNormal];
    self.weizhiButton.titleLabel.font = MFFONT(15);
    self.weizhiButton.status = MoreStyleStatusCenter;
    self.weizhiButton.padding = 5;
    [self.weizhiButton addTarget:self action:@selector(weizhiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.weizhiButton];

    self.paixuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.paixuButton setImage:IMAGECACHE(@"icon_20") forState:UIControlStateNormal];
    [self.paixuButton addTarget:self action:@selector(paixuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.paixuButton];
        
    self.searchButton = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchButton setImage:IMAGECACHE(@"home_04") forState:UIControlStateNormal];
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:RGB(0x989898) forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = LPFFONT(13);
    self.searchButton.backgroundColor = RGB(0xECECEC);
    self.searchButton.padding = 5;
    self.searchButton.layer.cornerRadius = 20;
    self.searchButton.layer.masksToBounds = YES;
    [self.navigationView addSubview:self.searchButton];
    
    self.lingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lingButton setImage:IMAGECACHE(@"home_icon467") forState:UIControlStateNormal];
    [self.lingButton addTarget:self action:@selector(lingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.lingButton];
    
    //    ① zoomStyle
    self.zoomSegmentView = [[CBSegmentView alloc] initWithFrame:CGRectMake(0, 64 + SafeTopSpace + 50, self.view.frame.size.width, 30)];
    [self.navigationView addSubview:self.zoomSegmentView];
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getHotAndHistory parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [HotSearchModel mj_objectArrayWithKeyValuesArray:json[@"hot"]];
            
            NSMutableArray *aarray = [NSMutableArray array];
            
            for (HotSearchModel *model in array) {
                [aarray addObject:model.searchText];
            }
            [self.zoomSegmentView setTitleArray:aarray titleFont:12 titleColor:[UIColor whiteColor] titleSelectedColor:[UIColor whiteColor] withStyle:CBSegmentStyleZoom];
            self.zoomSegmentView.titleChooseReturn = ^(NSInteger x) {
                //        NSLog(@"点击了第%ld个按钮",x+1);
                SearchDisplayController *search = [[SearchDisplayController alloc] init];
                search.keyword = aarray[x];
                [Weakself.navigationController pushViewController:search animated:YES];
            };
        }
    } failure:^(NSError *error) {
        
    }];
    
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset = 0;
        make.height.offset = 64 + SafeTopSpace + 80;
    }];
    
    [self.dituImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 32 + SafeTopSpace;
    }];
    [self.weizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dituImageView.mas_right).offset = 10;
//        make.width.offset = 200;
//        make.height.offset = 44;
//        make.top.offset = 30;
        make.centerY.equalTo(self.dituImageView);
    }];

    [self.lingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.top.offset = 30 + SafeTopSpace;
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset= -10;
        make.height.offset = 40;
        make.bottom.offset = -35;
    }];
    
    [self.paixuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lingButton.mas_left).offset = -15;
        make.top.offset = 30 + SafeTopSpace;
    }];
}

- (void)setupLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.offset = 64 + SafeTopSpace + 80;
        make.bottom.offset = -49;
    }];
//    [self.view bringSubviewToFront:self.navigationView];
}

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    //优化轮播图回显卡顿
//    [self.headView.cycleScrollView adjustWhenControllerViewWillAppera];
//    AnnounceView *announceView = self.headView.announceView;
//    [announceView.cycleScrollView adjustWhenControllerViewWillAppera];
//}

//- (void)doubleTapNotification:(NSNotification *)notification {
//    NSString *index = notification.object;
//    if ([index isEqualToString:@"0"]) {
//        if ([self.tableView.mj_header isRefreshing]) {
//            return;
//        }
//        [self loadNewTasks];
//        [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
//    }
//}

//- (void)refreshUI{
//    _headView.bannerDatas = self.banners;
//    _headView.announces = self.announces;
//    _headView.homeFunctions = self.homeFunctions;
//}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:homeOrganizationTableViewCell];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"客官稍等，立即呈上" forState:MJRefreshStatePulling];
        [header setTitle:@"客官稍等，立即呈上" forState:MJRefreshStateIdle];
        [header setTitle:@"客官稍等，立即呈上" forState:MJRefreshStateRefreshing];
        header.stateLabel.font = LPFFONT(13);
//        header.stateLabel.textAlignment = NSTextAlignmentCenter;
        header.stateLabel.textColor = [UIColor whiteColor];
        _tableView.mj_header = header;
        RefreshFooterView *footer = [RefreshFooterView footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];
        _tableView.mj_footer = footer;
    }
    return _tableView;
}
- (void)loadNewData{
    [self.tableView.mj_footer resetNoMoreData];
    [self loadNewsData];
}

#pragma mark tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeSectionHeaderView *headView = [[HomeSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 50)];
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeOrganizationTableViewCell];
    cell.baseViewController = self.navigationController;
    cell.model = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewModel *model = self.dataSourceArray[indexPath.row];
    ShopController *shopView = [ShopController new];
    shopView.shopId = model.shopId;
    [self.navigationController pushViewController:shopView animated:YES];
}

#pragma mark -导航工具条逻辑处理方法
- (void)paixuButtonAction:(UIButton *)sender{
    [self.view addSubview:self.list];
    [self.list showList];
}
- (void)searchButtonAction:(UIButton *)sender{
    SearchDisplayController *search = [[SearchDisplayController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
- (void)lingButtonAction:(UIButton *)sender{
    NotificationMessageController *notificationC  = [NotificationMessageController new];
    [self.navigationController pushViewController:notificationC animated:YES];
}

- (void)weizhiButtonAction:(UIButton *)sender{
    SelectWeizhiController *vc = [SelectWeizhiController new];
    WeakObj(self);
    vc.selectCityBlock = ^{
        WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
        [Weakself.weizhiButton removeFromSuperview];
        Weakself.weizhiButton = nil;
        Weakself.weizhiButton = [YXDButton buttonWithType:UIButtonTypeCustom];
        [Weakself.weizhiButton setTitle:model.xiaoqu forState:UIControlStateNormal];
        [Weakself.weizhiButton setImage:IMAGECACHE(@"icon_22") forState:UIControlStateNormal];
        Weakself.weizhiButton.titleLabel.font = MFFONT(15);
        Weakself.weizhiButton.status = MoreStyleStatusCenter;
        Weakself.weizhiButton.padding = 5;
        [Weakself.weizhiButton addTarget:Weakself action:@selector(weizhiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [Weakself.navigationView addSubview:Weakself.weizhiButton];

        [Weakself.weizhiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(Weakself.dituImageView.mas_right).offset = 10;
            make.centerY.equalTo(Weakself.dituImageView);
        }];
        [Weakself.tableView.mj_footer resetNoMoreData];
        [Weakself loadNewsData];
        Weakself.lingButton.hidden = NO;
        Weakself.searchButton.hidden = NO;
        Weakself.paixuButton.hidden = NO;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark-获取首页数据

//1.获取坐标信息再决定是否要展示数据
- (void)getCoordinateMessage{
    
    GetCoordinateTool *getCoordinate = [GetCoordinateTool getCoordinateTool];
    WeakObj(self);
    [getCoordinate getCoordinateToolActionWith:^(GetCoordinateModel *model) {
        
        //检查当前坐标 以及 查看城市是否开通
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"lng"] = [NSString stringWithFormat:@"%f",model.coord2D.longitude];
        parames[@"lat"] = [NSString stringWithFormat:@"%f",model.coord2D.latitude];
        parames[@"city"] = model.city;
        [Weakself.weizhiButton setTitle:model.xiaoqu forState:UIControlStateNormal];
        
        //1.测试数据
//        WeiZhiModel *modeal = [WeiZhiModel new];
//        modeal.areaId2 = @"410700";
//        modeal.longitude = @"113.910";
//        modeal.latitude = @"35.303";
//        modeal.city = @"新乡市";
//        [WeiZhiManager sharedInstance].weizhiModel = modeal;
//        [Weakself.weizhiButton setTitle:@"新乡市" forState:UIControlStateNormal];
//        [Weakself loadNewsData];
        
        //2.
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_checkCity parameters:parames successed:^(id json) {
            if (json) {
                //当前城市已经开通
                WeiZhiModel *getModel = [WeiZhiModel mj_objectWithKeyValues:json];
                getModel.xiaoqu = model.xiaoqu;
                [WeiZhiManager sharedInstance].weizhiModel = getModel;
                [Weakself.tableView.mj_footer resetNoMoreData];
                [Weakself loadNewsData];
                [self.presentView removeFromSuperview];
                self.presentView = nil;
            }else{
                //当前城市没有开通
                [self.view addSubview:self.presentView];
                [self.presentView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.offset = 0;
                    make.top.offset = 64 + SafeTopSpace;
                    make.bottom.offset = -49;
                }];
                [self.presentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.centerY.offset = 0;
                }];
                [self.aaimageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.offset = 0;
                    make.bottom.equalTo(self.presentLabel.mas_top).offset = -10;
                }];
                [self.switchCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.offset = 0;
                    make.top.equalTo(self.presentLabel.mas_bottom).offset = 10;
                    make.width.offset = 100;
                    make.height.offset = 30;
                }];
                self.lingButton.hidden = YES;
                self.paixuButton.hidden = YES;
                self.searchButton.hidden = YES;
            }
        } failure:^(NSError *error) {

        }];
    }];
}

- (void)loadNewsData{
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    if (!model) {
        return;
    }
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"longitude"] = model.longitude;
    parames[@"latitude"] = model.latitude;
    parames[@"areaId2"] = model.areaId2;
    parames[@"msort"] = self.type;//1.综合排序 2.销量从高到低3.门店好评度4.配送速度
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getNearbyShops parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataSourceArray removeAllObjects];
            NSArray *array = [HomeViewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataSourceArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
//            if (Weakself.dataSourceArray.count == 0) {
//                [Weakself showEmptyMessage:@"暂无信息"];
//            }else{
//                [Weakself hideEmptyView];
//            }
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
    if (!model) {
        return;
    }
    self.cape++;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"areaId2"] = model.areaId2;
    parames[@"pgsize"] = @"10";
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    parames[@"latitude"] = model.latitude;
    parames[@"longitude"] = model.longitude;
    parames[@"msort"] = self.type;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getNearbyShops parameters:parames successed:^(id json) {
        [Weakself.tableView.mj_footer endRefreshing];
        if (json) {
            NSArray *array = [HomeViewModel mj_objectArrayWithKeyValuesArray:json];
            if (array.count == 0) {//没有数据、
                [Weakself.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [Weakself.dataSourceArray addObjectsFromArray:array];
                [Weakself.tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupCateArray{
    self.cateArray = [NSMutableArray array];
    HomeAlertViewModel *model1 = [HomeAlertViewModel itemWithTitle:@"按综合排序" nid:@"1" isSelect:YES];
    HomeAlertViewModel *model2 = [HomeAlertViewModel itemWithTitle:@"按销量从高到底" nid:@"2" isSelect:NO];
    HomeAlertViewModel *model3 = [HomeAlertViewModel itemWithTitle:@"按门店好评度" nid:@"3" isSelect:NO];
    HomeAlertViewModel *model4 = [HomeAlertViewModel itemWithTitle:@"按配送速度" nid:@"4" isSelect:NO];
    [self.cateArray addObject:model1];
    [self.cateArray addObject:model2];
    [self.cateArray addObject:model3];
    [self.cateArray addObject:model4];
}

//设置蒙版
- (UIView *)presentView{
    if (!_presentView) {
        _presentView = [UIView new];
        _presentView.backgroundColor = [UIColor whiteColor];
        self.aaimageView = [UIImageView new];
        self.aaimageView.image = IMAGECACHE(@"icon_131416");
        [_presentView addSubview:self.aaimageView];
        self.presentLabel = [UILabel new];
        self.presentLabel.text = @"当前城市未开通服务";
        self.presentLabel.font = LPFFONT(15);
        [_presentView addSubview:self.presentLabel];
        self.switchCityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.switchCityButton setTitle:@"切换城市" forState:UIControlStateNormal];
        [self.switchCityButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
        self.switchCityButton.layer.cornerRadius = 4;
        self.switchCityButton.layer.borderWidth = 1;
        self.switchCityButton.titleLabel.font = LPFFONT(13);
        self.switchCityButton.layer.borderColor = THEME_COLOR.CGColor;
        [self.switchCityButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_presentView addSubview:self.switchCityButton];
    }
    return _presentView;
}

- (void)searchButtonAction{
    [self weizhiButtonAction:self.weizhiButton];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset.y;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y<self.lastContentOffset)
    {
        //向上
        _tableView.backgroundColor = THEME_COLOR;
    } else if (scrollView.contentOffset.y>self.lastContentOffset)
    {
        //向下
        _tableView.backgroundColor = [UIColor whiteColor];
    }
}

@end
