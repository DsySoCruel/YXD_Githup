//
//  SelecuXiaoquController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/2/6.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "SelecuXiaoquController.h"
#import "SelectCityController.h"
#import "SelectWeizhiControllerCell.h"
#import "SelectWeizhiController.h"
#import "SelectWeizhiControllerModel.h"
#import "SelectWeizhiHistoryModel.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

static NSString *kSelectWeizhiControllerCell = @"SelectWeizhiControllerCell";


@interface SelecuXiaoquController ()<AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic,strong) AMapSearchAPI *search;//获取最近位置相关信息

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) YXDButton *selectCityButton;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *historyDataArray;//历史搜索记录

@property (nonatomic,strong) NSString *searchText;//保存的搜索关键字

@end

@implementation SelecuXiaoquController

- (NSMutableArray *)historyDataArray{
    if (!_historyDataArray) {
        _historyDataArray = [NSMutableArray array];
    }
    return _historyDataArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择位置";
    [AMapServices sharedServices].apiKey = @"5b3de31c939d0e03a09992370e201f3b";
    [self setupUI];
    [self setupLayout];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    [self getHistoryData];//获取历史搜索记录
    
    [self.selectCityButton setTitle:self.city forState:UIControlStateNormal];
    self.city = self.city;
    
}

- (void)getHistoryData{
    [self.historyDataArray removeAllObjects];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"areaId2"] = self.areaId2;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getSearchLocation parameters:parames successed:^(id json) {
        if (json) {
            NSArray *moreArray = [SelectWeizhiHistoryModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.historyDataArray addObjectsFromArray:moreArray];
            [Weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)setupUI{
    self.topView = [UIView new];
    self.topView.backgroundColor = BACK_COLOR;
    [self.view addSubview:self.topView];
    
    self.selectCityButton = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.selectCityButton setTitle:@"新乡" forState:UIControlStateNormal];
    [self.selectCityButton setImage:IMAGECACHE(@"icon_56") forState:UIControlStateNormal];
    [self.selectCityButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    self.selectCityButton.titleLabel.font = MFFONT(15);
    self.selectCityButton.status = MoreStyleStatusCenter;
    self.selectCityButton.padding = 5;
//    [self.selectCityButton addTarget:self action:@selector(weizhiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.selectCityButton];
    
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索位置";
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.showsCancelButton = NO;
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    self.searchBar.barTintColor = [UIColor whiteColor];
    [self.topView addSubview:self.searchBar];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[SelectWeizhiControllerCell class] forCellReuseIdentifier:kSelectWeizhiControllerCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}
- (void)setupLayout{
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.offset = 64;
        make.height.offset = 45;
    }];
    [self.selectCityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset = 0;
        make.width.offset = 80;
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.offset = 80;
        make.right.offset = -10;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.topView.mas_bottom).offset = 5;
    }];
}


//- (void)weizhiButtonAction:(UIButton *)sender{
//    SelectCityController *selectCityController = [SelectCityController new];
//    WeakObj(self);
//    selectCityController.selectCityBlock = ^(NSString *cityName, NSString *cityId) {
//        [Weakself.selectCityButton setTitle:cityName forState:UIControlStateNormal];
//        Weakself.city = cityName;
//        //设置对应的位置信息
//        WeiZhiModel *model = [WeiZhiManager sharedInstance].weizhiModel;
//        if (!model) {
//            WeiZhiModel *model = [WeiZhiModel new];
//            model.areaId2 = cityId;
//            model.city = cityName;
//            [WeiZhiManager sharedInstance].weizhiModel = model;
//        }else{
//            model.areaId2 = cityId;
//            model.city = cityName;
//            [WeiZhiManager sharedInstance].weizhiModel = model;
//        }
//
//        [Weakself.dataArray removeAllObjects];
//        [Weakself.tableView reloadData];
//    };
//    [self.navigationController pushViewController:selectCityController animated:YES];
//}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = searchBar.text;
    request.city                = self.city;
    //    request.types               = @"高等院校";
    request.requireExtension    = YES;
    /*  搜索SDK 3.2.0 中新增加的功能，只搜索本城市的POI。*/
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.search AMapPOIKeywordsSearch:request];
    
    self.searchText = searchText;
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0 || !self.searchText.length)
    {
        [self.dataArray removeAllObjects];
        [self.tableView reloadData];
        return;
    }
    [self.dataArray removeAllObjects];
    //解析response获取POI信息，具体解析见 Demo
    NSLog(@"%ld %@",response.count,response.pois.firstObject);
//    AMapPOI *model = response.pois[1];
//    NSLog(@" %@",model.name);
    
    if (response.pois.count > 10) {
        for (int i = 0; i < 10; i ++) {
            AMapPOI *aMapPOIModel = response.pois[i];
            SelectWeizhiControllerModel *model = [SelectWeizhiControllerModel new];
            model.name = aMapPOIModel.name;
            model.city = aMapPOIModel.city;
            model.address = [NSString stringWithFormat:@"%@%@%@",aMapPOIModel.city,aMapPOIModel.district,aMapPOIModel.address];
            model.latitude = [NSString stringWithFormat:@"%f",aMapPOIModel.location.latitude];
            model.longitude = [NSString stringWithFormat:@"%f",aMapPOIModel.location.longitude];
            [self.dataArray addObject:model];
        }
    }else{
        for (AMapPOI *aMapPOIModel in response.pois) {
            SelectWeizhiControllerModel *model = [SelectWeizhiControllerModel new];
            model.name = aMapPOIModel.name;
            model.city = aMapPOIModel.city;
            model.address = [NSString stringWithFormat:@"%@%@%@",aMapPOIModel.city,aMapPOIModel.district,aMapPOIModel.address];
            model.latitude = [NSString stringWithFormat:@"%f",aMapPOIModel.location.latitude];
            model.longitude = [NSString stringWithFormat:@"%f",aMapPOIModel.location.longitude];
            [self.dataArray addObject:model];
        }
    }
    [self.tableView reloadData];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (self.dataArray.count) {
        return 0;
    }
    return 30;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30)];
    titleV.backgroundColor = [UIColor whiteColor];
    UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width - 110, 30)];
    titleLa.backgroundColor = [UIColor whiteColor];
    titleLa.font = [UIFont systemFontOfSize:11];
    titleLa.textColor = [UIColor grayColor];
    titleLa.text = @"历史搜索记录";
    [titleV addSubview:titleLa];
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setTitle:@"清除记录" forState:UIControlStateNormal];
    [clearButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    clearButton.titleLabel.font = LPFFONT(12);
    clearButton.frame = CGRectMake(self.view.bounds.size.width - 80, 0, 80, 30);
    [clearButton addTarget:self action:@selector(clearButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [titleV addSubview:clearButton];
    return titleV;
}

//清除历史搜索记录
- (void)clearButtonAction{
    if (self.historyDataArray.count == 0) {
        return;
    }
    WeiZhiModel *bmodel = [WeiZhiManager sharedInstance].weizhiModel;
    [self.historyDataArray removeAllObjects];
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"areaId2"] = bmodel.areaId2;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_clearSearchLocation parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.historyDataArray removeAllObjects];
            [Weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count ? self.dataArray.count : self.historyDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectWeizhiControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectWeizhiControllerCell];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }else{
        cell.historyModel = self.historyDataArray[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //判断是搜索结果还是历史纪录
    if (self.dataArray.count) {
        SelectWeizhiControllerModel *amodel = self.dataArray[indexPath.row];
//        WeiZhiModel *bmodel = [WeiZhiManager sharedInstance].weizhiModel;
//        bmodel.latitude = amodel.latitude;
//        bmodel.longitude = amodel.longitude;
//        bmodel.city = amodel.city;
//        [WeiZhiManager sharedInstance].weizhiModel = bmodel;
        //请求网络判断
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"areaId2"] = self.areaId2;
        parames[@"longitude"] = amodel.longitude;
        parames[@"latitude"] = amodel.latitude;
        parames[@"place"] = amodel.name;
        parames[@"address"] = amodel.address;
        parames[@"accessToken"] = UserAccessToken;
        [[NetWorkManager shareManager] POST:USER_selectLocation parameters:parames successed:^(id json) {
            if (json) {
                
            }
        } failure:^(NSError *error) {
            
        }];
        
        if(self.selectXiaoquBlock){
            self.selectXiaoquBlock(amodel.name, amodel.address, amodel.latitude, amodel.longitude);
        }
        
    }else{
        SelectWeizhiHistoryModel *model = self.historyDataArray[indexPath.row];
//        WeiZhiModel *bmodel = [WeiZhiManager sharedInstance].weizhiModel;
//        bmodel.latitude = model.latitude;
//        bmodel.longitude = model.longitude;
//        //        bmodel.city = model.city;
//        bmodel.areaId2 = model.areaId2;
//        [WeiZhiManager sharedInstance].weizhiModel = bmodel;
        if(self.selectXiaoquBlock){
            self.selectXiaoquBlock(model.place, model.address, model.latitude, model.longitude);
        }

        
    }
    
    //1.保存位置信息
    //2.开始刷新
    [self.navigationController popViewControllerAnimated:YES];
}


@end

