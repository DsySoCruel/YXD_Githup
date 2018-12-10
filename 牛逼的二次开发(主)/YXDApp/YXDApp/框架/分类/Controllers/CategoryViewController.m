//
//  CategoryViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryCollectCell.h"
#import "CategoryTableVIewCell.h"
#import "CategoryTableVIewModel.h"
#import "CategoryCollecModel.h"
#import "SearchDisplayController.h"
#import "CategorySearchController.h"

static NSString *kCategoryCollectCell = @"kCategoryCollectCell";
static NSString *kCategoryTableVIewCell = @"kCategoryTableVIewCell";

@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *searchButton;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *tableViewArray;
@property (nonatomic,strong) NSMutableArray *collectViewArray;
@property (nonatomic,strong) NSString *catId;//右侧请求数据的Id

@end

@implementation CategoryViewController

- (NSMutableArray *)tableViewArray{
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}

- (NSMutableArray *)collectViewArray{
    if (!_collectViewArray) {
        _collectViewArray = [NSMutableArray array];
    }
    return _collectViewArray;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    [self loadData];
    [self loadRightData];
}


- (void)setupUI{
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UILabel *numGoods = [[UILabel alloc] initWithFrame:titleView.bounds];
    numGoods.textAlignment = NSTextAlignmentCenter;
    numGoods.text = @"分类";
    numGoods.font = LPFFONT(16);
    [titleView addSubview:numGoods];
    self.navigationItem.titleView = titleView;
    
    self.topView = [UIView new];
    self.topView.backgroundColor = BACK_COLOR;
    [self.view addSubview:self.topView];
    
    self.searchButton = [[UIButton alloc] init];
    self.searchButton.backgroundColor = [UIColor whiteColor];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    self.searchButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.searchButton setTitleColor:RGB(0x8e8ca7) forState:UIControlStateNormal];
    [self.searchButton setTitle:@"搜索附近的商品和门店" forState:UIControlStateNormal];
    [self.searchButton setImage:IMAGECACHE(@"icon_37") forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.searchButton];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 40;
        make.top.offset = kTopHeight;
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 5;
        make.right.offset = -5;
        make.height.offset = 30;
        make.top.offset = 5;
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[CategoryTableVIewCell class] forCellReuseIdentifier:kCategoryTableVIewCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 80) / 3, (YXDScreenW - 80)*3 /8);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[CategoryCollectCell class] forCellWithReuseIdentifier:kCategoryCollectCell];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NAHomeCityCollectionViewSectionHeaderView"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
}

- (void)setupLayout{
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = kTopHeight + 40;
        make.bottom.offset = -49;
        make.width.offset = 80;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.top.offset = kTopHeight + 40;
        make.bottom.offset = -49;
        make.left.equalTo(self.tableView.mas_right).offset = 0;
    }];
}

#pragma mark - tableView 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableViewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableVIewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCategoryTableVIewCell];
    CategoryTableVIewModel *model = self.tableViewArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (int i = 0; i < self.tableViewArray.count; i++) {
        CategoryTableVIewModel *model = self.tableViewArray[i];
        if (i == indexPath.row) {
            model.isSelect = YES;
            self.catId = model.catId;
        }else{
            model.isSelect = NO;
        }
    }
    [self.tableView reloadData];
    [self loadRightData];
}

#pragma mark - collectView 代理方法

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(YXDScreenW, 40);
    return size;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        UICollectionReusableView *headerView = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NAHomeCityCollectionViewSectionHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        [headerView removeAllSubviews];
        UILabel *ttLabel = [UILabel new];
        ttLabel.frame = CGRectMake(15, 3, 200, 37);
        ttLabel.font = PFFONT(13);
        [headerView addSubview:ttLabel];
        CategoryCollecModel *sectionModel = self.collectViewArray[indexPath.section];
        ttLabel.text = sectionModel.catName;
        reusableView = headerView;
    }

    return reusableView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.collectViewArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryCollectCell forIndexPath:indexPath];
    CategoryCollecModel *sectionModel = self.collectViewArray[indexPath.section];
    cell.collecModel = sectionModel.childs[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CategoryCollecModel *sectionModel = self.collectViewArray[section];
    return sectionModel.childs.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryCollecModel *sectionModel = self.collectViewArray[indexPath.section];
    CategoryCollecDataModel *model = sectionModel.childs[indexPath.row];
    CategorySearchController *goodController = [CategorySearchController new];
    goodController.title = model.catName;
    goodController.c1Id = self.catId;
    goodController.c2Id = sectionModel.catId;
    goodController.c3Id = model.catId;
    [self.navigationController pushViewController:goodController animated:YES];
}

#pragma mark-请求数据
//请求左侧数据
- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getLeftCate parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.tableViewArray removeAllObjects];
            NSArray *array = [CategoryTableVIewModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.tableViewArray addObjectsFromArray:array];
            CategoryTableVIewModel *model = Weakself.tableViewArray.firstObject;
            model.isSelect = YES;
            [Weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
//请求右侧数据
- (void)loadRightData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    if (self.catId.length) {
        parames[@"catId"] = self.catId;
    }
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getCategory parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.collectViewArray removeAllObjects];
            NSArray *array = [CategoryCollecModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.collectViewArray addObjectsFromArray:array];
            [Weakself.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)searchButtonTappedAction{
    SearchDisplayController *search = [[SearchDisplayController alloc] init];
    [self.navigationController pushViewController:search animated:YES];
}
@end
