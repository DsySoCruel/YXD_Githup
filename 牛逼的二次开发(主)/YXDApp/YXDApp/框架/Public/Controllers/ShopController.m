//
//  ShopController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/17.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopController.h"
#import "ShopGoodCollectCell.h"
#import "ShopControllerLeftCell.h"
#import "CategoryTableVIewModel.h"
#import "GoodController.h"
#import "ShopHeadViewModel.h"
#import "ShopMessageModel.h"
#import "ShopControllerView.h"
#import "ShopControllerModel.h"
#import "ShopDetailController.h"
#import "ShopCarDetailController.h"
#import "YXDSearchViewBar.h"
#import "ShopSearchDisplayController.h"

static NSString *kShopGoodCollectCell = @"kShopGoodCollectCell";
static NSString *kShopControllerLeftCell = @"kShopControllerLeftCell";


@interface ShopController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
@property (nonatomic,strong) ShopControllerView *shopControllerView;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UIButton *searchButton;
//@property (nonatomic,strong) YXDSearchViewBar *searchBar;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UICollectionView *collectionView;

//数据
@property (nonatomic,strong) ShopControllerModel *shopControllerModel;
@property (nonatomic,strong) NSMutableArray *tableViewArray;//存储保存的选中的商品信息
//@property (nonatomic,strong) NSMutableArray *collectViewArray;

@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (nonatomic,strong) NSMutableArray *rightDataSourceArray;

@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic,assign) NSInteger selectIndex;//记录位置
@property (nonatomic,assign) BOOL isScrollDown;//滚动方向


//@property (nonatomic,strong) NSString *ct1;
//@property (nonatomic,strong) NSString *ct2;

//底部工具条
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *lineBottom;
@property (nonatomic,strong) UIImageView *bottomImageView;
@property (nonatomic,strong) UILabel *bottomNum;
@property (nonatomic,strong) UILabel *bottomPriceLabel;
@property (nonatomic,strong) UIButton *bottomButton;

@property (nonatomic,strong) ShopHeadViewModel *model;//店铺详细信息model
@property (nonatomic,strong) ShopMessageModel *detailModel;

@end

@implementation ShopController

- (NSMutableArray *)tableViewArray{
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray array];
    }
    return _tableViewArray;
}

//- (NSMutableArray *)collectViewArray{
//    if (!_collectViewArray) {
//        _collectViewArray = [NSMutableArray array];
//    }
//    return _collectViewArray;
//}

- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (NSMutableArray *)rightDataSourceArray{
    if (!_rightDataSourceArray) {
        _rightDataSourceArray = [NSMutableArray array];
    }
   return _rightDataSourceArray;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupUI];
    [self setupLayout];
    [self loadData];//请求店铺详情
}


- (void)setupUI{
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.isSelected = NO;
    self.selectIndex = 0;
    self.isScrollDown = YES;
    
    
    
    self.shopControllerView = [ShopControllerView new];
    [self.view addSubview:self.shopControllerView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
    [self.shopControllerView addGestureRecognizer:tap1];
    
    self.searchView = [UIView new];
    self.searchView.backgroundColor = RGB(0xe4edff);
    [self.view addSubview:self.searchView];

    
    
//    self.searchBar = [[YXDSearchViewBar alloc] initWithFrame:CGRectZero];
//    self.searchBar.placeholder  = @"搜索店内商品";
//    self.searchBar.searchImage = IMAGECACHE(@"icon_37");
////    WeakObj(self)
//    [self.searchBar searchShouldChangeText:^(UITextField *obj, NSRange range, NSString *string) {
////        Weakself.keyWord = string;
////        [Weakself fetchContacts];
//        
//    }];
//    [self.searchView addSubview:self.searchBar];
    
    self.searchButton = [[UIButton alloc] init];
    self.searchButton.backgroundColor = [UIColor whiteColor];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
    self.searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    self.searchButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    self.searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.searchButton setTitleColor:RGB(0x8e8ca7) forState:UIControlStateNormal];
    [self.searchButton setTitle:@"搜索店内商品" forState:UIControlStateNormal];
    [self.searchButton setImage:IMAGECACHE(@"icon_37") forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonTappedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:self.searchButton];

    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[ShopControllerLeftCell class] forCellReuseIdentifier:kShopControllerLeftCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.sectionHeadersPinToVisibleBounds = YES;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 80) / 2, (YXDScreenW - 80)*0.7);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[ShopGoodCollectCell class] forCellWithReuseIdentifier:kShopGoodCollectCell];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NAHomeCityCollectionViewSectionHeaderView"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    //设置底部工具条
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.lineBottom = [UIView new];
    self.lineBottom.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.lineBottom];
    
    self.bottomImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_42")];
    [self.bottomView addSubview:self.bottomImageView];
    self.bottomNum = [UILabel new];
    self.bottomNum.text = @"0";
    self.bottomNum.textAlignment = NSTextAlignmentCenter;
    self.bottomNum.font = SFONT(12);
    self.bottomNum.backgroundColor = [UIColor redColor];
    self.bottomNum.layer.cornerRadius = 9;
    self.bottomNum.layer.masksToBounds = YES;
    self.bottomNum.textColor = [UIColor whiteColor];
    [self.bottomImageView addSubview:self.bottomNum];
    self.bottomPriceLabel = [UILabel new];
    self.bottomPriceLabel.text = @"￥0.00";
    self.bottomPriceLabel.textColor = [UIColor redColor];
    [self.bottomView addSubview:self.bottomPriceLabel];
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.backgroundColor = THEME_COLOR;
    [self.bottomButton setTitle:@"去结算" forState:UIControlStateNormal];
    self.bottomButton.titleLabel.font = MFFONT(14);
    [self.bottomView addSubview:self.bottomButton];
    [self.bottomButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)searchButtonTappedAction{
    ShopSearchDisplayController *search = [[ShopSearchDisplayController alloc] init];
    search.shopId = self.shopId;
    [self.navigationController pushViewController:search animated:YES];
}


- (void)setupLayout{
    [self.shopControllerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset = 0;
        make.height.offset = 160 + SafeTopSpace;
        make.top.offset = 0;
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.equalTo(self.shopControllerView.mas_bottom).offset = 0;
        make.height.offset = 40;
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset = 0;
//        make.bottom.offset = 0;
//        make.left.offset = 0;
//        make.right.offset = 0;
        
        make.left.offset = 5;
        make.right.offset = -5;
        make.height.offset = 30;
        make.top.offset = 5;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.equalTo(self.searchView.mas_bottom).offset = 0;
        make.bottom.offset = -49;
        make.width.offset = 80;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.top.equalTo(self.searchView.mas_bottom).offset = 0;
        make.bottom.offset = -49;
        make.left.equalTo(self.tableView.mas_right).offset = 0;
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.collectionView.mas_bottom).offset = 0;
    }];
    
    [self.lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 0;
        make.height.offset = 1;
        make.right.offset = -100;
    }];
    
    [self.bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset = 0;
        make.width.offset = 100;
    }];
    [self.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = -10;
        make.left.offset = 15;
    }];
    [self.bottomNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset = 18;
        make.centerY.offset = -13;
        make.centerX.offset = 13;
    }];
    [self.bottomPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.equalTo(self.bottomImageView.mas_right).offset = 10;
    }];
}

- (void)adView1Action{
    ShopDetailController *vc = [ShopDetailController new];
    vc.model = self.detailModel;
    vc.headModel = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - tableView 代理方法

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ShopControllerModel *firstModel = self.dataSourceArray[section];
    return firstModel.children.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //取出数值
    ShopControllerModel *sectionModel = self.dataSourceArray[section];
    
    UIView *aa = [UIView new];
    aa.backgroundColor = sectionModel.isSelect ? [UIColor whiteColor] : BACK_COLOR;
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = sectionModel.isSelect ? THEME_COLOR : BACK_COLOR;
    [aa addSubview:lineView];
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = LPFFONT(14);
    nameLabel.textColor = sectionModel.isSelect ? THEME_COLOR : TEXT_COLOR;
    nameLabel.text = sectionModel.catName;
    [aa addSubview:nameLabel];
    
//    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    selectButton.tag = 1000 + section;
//    [aa addSubview:selectButton];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.offset = 0;
        make.width.offset = 2;
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 2;
        make.top.bottom.right.offset = 0;
    }];
//    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.offset = 0;
//    }];
    return aa;
}

//- (void)selectButtonAction:(UIButton *)sender{
//    ShopControllerCatListModel *sectionModel = self.shopControllerModel.catList[sender.tag - 1000];
//    if (sectionModel.isSelect) {
//        return;
//    }
//    //其他全部设置为no
//    for (int i = 0; i < self.shopControllerModel.catList.count; i++) {
//        ShopControllerCatListModel *sectionModel = self.shopControllerModel.catList[i];
//        sectionModel.isSelect = NO;
//        for (int j = 0; j < sectionModel.children.count; j++) {
//            ShopControllerCatListChildrenModel *model = sectionModel.children[j];
//            model.isSelect = NO;
//        }
//    }
//    
//    sectionModel.isSelect = YES;
//    ShopControllerCatListChildrenModel *bb = sectionModel.children.firstObject;
//    bb.isSelect = YES;
////    self.ct1 = sectionModel.catId;
////    self.ct2 = bb.catId;
//    [self.tableView reloadData];
////    [self loadRightData];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopControllerLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopControllerLeftCell];
    ShopControllerModel *sectionModel = self.dataSourceArray[indexPath.section];
    ShopControllerSecondModel *model = sectionModel.children[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //1.设置样式
    for (int i = 0; i < self.dataSourceArray.count; i++) {
        ShopControllerModel *sectionModel = self.dataSourceArray[i];
        sectionModel.isSelect = NO;
        for (int j = 0; j < sectionModel.children.count; j++) {
            ShopControllerSecondModel *model = sectionModel.children[j];
            model.isSelect = NO;
            //            if (j == indexPath.row && indexPath.section == i) {
            //                model.isSelect = YES;
            ////                self.ct2 = model.catId;
            //            }else{
            //                model.isSelect = NO;
            //            }
        }
    }
    ShopControllerModel *firstModel = self.dataSourceArray[indexPath.section];
    firstModel.isSelect = YES;
    ShopControllerSecondModel *secondModel = firstModel.children[indexPath.row];
    secondModel.isSelect = YES;
    
//    ShopControllerCatListModel *sectionModel = self.shopControllerModel.catList[indexPath.section];
//    ShopControllerCatListChildrenModel *model = sectionModel.children[indexPath.row];
//    if (model.isSelect) {
//        return;
//    }
    [self.tableView reloadData];
    //2.联动右边collectView
    //计算需要的便宜位置
    NSInteger rightPostion = 0;
    NSInteger tempSection = indexPath.section;
    NSInteger section = 0;
    for (ShopControllerModel *firstModel in self.dataSourceArray) {
        if (tempSection > section) {
            rightPostion += firstModel.children.count;
            section++;
        }else{
            rightPostion += indexPath.row;
            break;
        }
    }
    //防止出错 自己添加判断项
    if (rightPostion <= self.rightDataSourceArray.count) {
        ShopControllerSecondModel *model = self.rightDataSourceArray[rightPostion];
        if (model.goods.count) {
                    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:rightPostion] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
        }
    }

    self.isSelected = YES;
}



- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    //         当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        //计算section
        NSInteger tempSection = indexPath.section;
        
        ShopControllerSecondModel *shopControllerSecondModel = self.rightDataSourceArray[tempSection];
        
        for (ShopControllerModel *shopControllerModel in self.dataSourceArray) {
            if ([shopControllerSecondModel.parentId isEqualToString:shopControllerModel.catId]) {
                shopControllerModel.isSelect  = YES;
                
                for (ShopControllerSecondModel *secModel in shopControllerModel.children) {
                    if ([secModel.catId isEqualToString:shopControllerSecondModel.catId]) {
                        secModel.isSelect = YES;
                    }else{
                        secModel.isSelect = NO;;
                        
                    }
                }
                
            }else{
                shopControllerModel.isSelect  = NO;;
                for (ShopControllerSecondModel *secModel in shopControllerModel.children) {
                    secModel.isSelect = NO;;
                }
            }
        }

        
//        //计算右边的位置
//        NSInteger rightPostion = 0;
//        NSInteger rightSection = 0;
//        NSInteger rightRow = 0;
//        for (ShopControllerModel *firstModel in self.dataSourceArray) {
//            if (tempSection >firstModel.children.count + rightPostion) {
//                rightPostion += firstModel.children.count;
//                rightSection++;
//            }else{
//                rightRow = firstModel.children.count + rightPostion - tempSection - 1;
//                break;
//            }
//        }
//        NSLog(@"**********%ld %ld %ld",rightPostion,rightSection ,rightRow);
//        //1.设置样式
//        for (int i = 0; i < self.dataSourceArray.count; i++) {
//            ShopControllerModel *sectionModel = self.dataSourceArray[i];
//            sectionModel.isSelect = NO;
//            if (i == rightSection) {
//                sectionModel.isSelect = YES;
//            }
//            for (int j = 0; j < sectionModel.children.count; j++) {
//                ShopControllerSecondModel *model = sectionModel.children[j];
//                model.isSelect = NO;
//                if (j == rightRow) {
//                    model.isSelect = YES;
//                }
//
//            }
//        }
        [self.tableView reloadData];
        
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:rightRow inSection:rightSection] animated:YES scrollPosition:UITableViewScrollPositionMiddle];

    }
}


- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    
    //    NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:section];
    //    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    // 点击左边对应区块
    //    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    
    //         当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (self.isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
//        [self selectRowAtIndexPath:indexPath.section + 1];
        
        //计算section
        NSInteger tempSection = indexPath.section + 1;
        NSLog(@"-----tempSection-------%ld",tempSection);

        //计算右边的位置
//        NSInteger rightPostion = 0;
//        NSInteger rightSection = 0;
//        NSInteger rightRow = 0;
//        for (ShopControllerModel *firstModel in self.dataSourceArray) {
//            if (tempSection + 1 > firstModel.children.count  + rightPostion) {
//                NSLog(@"11111  %ld %ld",firstModel.children.count ,rightPostion);
//
//                rightPostion += firstModel.children.count;
//                ++rightSection;
//                NSLog(@"2222  %ld %ld",rightPostion ,rightSection);
//
//            }else{
//
//                rightRow = firstModel.children.count + rightPostion - tempSection - 1;
//
//                NSLog(@"33333 %ld %ld %ld %ld",firstModel.children.count ,rightSection,tempSection,rightRow);
//
//                break;
//            }
//        }
//
//        NSLog(@"4444444 %ld %ld %ld",rightPostion,rightSection ,rightRow);
        
        ShopControllerSecondModel *shopControllerSecondModel = self.rightDataSourceArray[tempSection];
        
        for (ShopControllerModel *shopControllerModel in self.dataSourceArray) {
            if ([shopControllerSecondModel.parentId isEqualToString:shopControllerModel.catId]) {
                shopControllerModel.isSelect  = YES;
                
                for (ShopControllerSecondModel *secModel in shopControllerModel.children) {
                    if ([secModel.catId isEqualToString:shopControllerSecondModel.catId]) {
                        secModel.isSelect = YES;
                    }else{
                        secModel.isSelect = NO;;

                    }
                }
                
            }else{
                shopControllerModel.isSelect  = NO;;
                for (ShopControllerSecondModel *secModel in shopControllerModel.children) {
                    secModel.isSelect = NO;;
                }

            }
        }
        
        
        //1.设置样式
//        for (int i = 0; i < self.dataSourceArray.count; i++) {
//            ShopControllerModel *sectionModel = self.dataSourceArray[i];
//            sectionModel.isSelect = NO;
//            if (i == rightSection) {
//                sectionModel.isSelect = YES;
//                for (int j = 0; j < sectionModel.children.count; j++) {
//                    ShopControllerSecondModel *model = sectionModel.children[j];
//                    model.isSelect = NO;
//                    if (j == rightRow) {
//                        model.isSelect = YES;
//                    }
//                }
//
//            }else{
//                for (int j = 0; j < sectionModel.children.count; j++) {
//                    ShopControllerSecondModel *model = sectionModel.children[j];
//                    model.isSelect = NO;
//                }
//            }
//
//        }
        [self.tableView reloadData];
        
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:rightRow inSection:rightSection] animated:YES scrollPosition:UITableViewScrollPositionMiddle];

    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float lastOffsetY = 0;
    if (self.collectionView == scrollView) {
        self.isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}



#pragma mark - collectView 代理方法

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(YXDScreenW, 0.5);
    return size;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.rightDataSourceArray.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = (UICollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NAHomeCityCollectionViewSectionHeaderView" forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
//        [headerView removeAllSubviews];
//        UILabel *ttLabel = [UILabel new];
//        ttLabel.frame = CGRectMake(15, 5, 200, 20);
//        [headerView addSubview:ttLabel];
//        ShopControllerSecondModel *sectionModel = self.rightDataSourceArray[indexPath.section];
//        ttLabel.text = sectionModel.catName;
        reusableView = headerView;
    }
    return reusableView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopGoodCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kShopGoodCollectCell forIndexPath:indexPath];
    ShopControllerSecondModel *model = self.rightDataSourceArray[indexPath.section];
    cell.model = model.goods[indexPath.row];
    WeakObj(self);
    cell.jiaButtonBlock = ^(ShopControllerGoodsListModel *model) {
        //判断有没有 没有就添加  有就替换
        BOOL isHave = NO;
        for (ShopControllerGoodsListModel *goodModel in Weakself.tableViewArray) {
            if ([goodModel.goodsId isEqualToString:model.goodsId]) {
                goodModel.selectNum = model.selectNum;
                isHave = YES;
                [Weakself countMoney];
                break;
            }
        }
        if (!isHave) {//没有
            [Weakself.tableViewArray addObject:model];
        }
        [Weakself countMoney];
    };

    cell.jianBUttonBlock = ^(ShopControllerGoodsListModel *model) {
        for (ShopControllerGoodsListModel *goodModel in Weakself.tableViewArray) {
            if ([goodModel.goodsId isEqualToString:model.goodsId]) {
                goodModel.selectNum = model.selectNum;
                if (goodModel.selectNum == 0) {
                    [Weakself.tableViewArray removeObject:goodModel];
                }
                [Weakself countMoney];
                break;
            }
        }
    };
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ShopControllerSecondModel *model = self.rightDataSourceArray[section];
    return model.goods.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodController *goodController = [GoodController new];
    ShopControllerSecondModel *m = self.rightDataSourceArray[indexPath.section];
    ShopControllerGoodsListModel *model = m.goods[indexPath.item];
    goodController.goodsId = model.goodsId;
    goodController.model = model;
    goodController.shopID = self.shopId;
    [goodController.selectGoods addObjectsFromArray:self.tableViewArray];
    WeakObj(self);
    goodController.jiaButtonBlock = ^(ShopControllerGoodsListModel *model) {
        //判断有没有 没有就添加  有就替换
        BOOL isHave = NO;
        for (ShopControllerGoodsListModel *goodModel in Weakself.tableViewArray) {
            if ([goodModel.goodsId isEqualToString:model.goodsId]) {
                goodModel.selectNum = model.selectNum;
                isHave = YES;
                [Weakself countMoney];
                break;
            }
        }
        if (!isHave) {//没有
            [Weakself.tableViewArray addObject:model];
        }
        [Weakself countMoney];
        [Weakself.collectionView reloadData];
    };
    [self.navigationController pushViewController:goodController animated:YES];
}


#pragma mark - 进行购物
//计算总金额
- (void)countMoney{
    NSInteger totalNum = 0;
    CGFloat totalPrice = 0.00;
    for (ShopControllerGoodsListModel *goodModel in self.tableViewArray) {
        totalNum += goodModel.selectNum;
        totalPrice += [goodModel.price floatValue] * goodModel.selectNum;
    }
    self.bottomNum.text = [NSString stringWithFormat:@"%tu",totalNum];
    self.bottomPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
}

- (void)buyAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:NO];
    UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tab.selectedIndex = 2;
    
    
    //在进入到购物车详情中
    ShopCarDetailController *vc = [ShopCarDetailController new];
    vc.shopId = self.shopId;
    [tab.selectedViewController pushViewController:vc animated:YES];
}

//首次请求数据，获取的是店内活动：秒杀信息
- (void)loadData{
    //1.请求店铺详细信息
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"shopId"] = self.shopId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getShop parameters:parames successed:^(id json) {
        if (json) {
            ShopHeadViewModel *model = [ShopHeadViewModel mj_objectWithKeyValues:json];
            Weakself.shopControllerView.model = model;
            Weakself.model = model;
        }
    } failure:^(NSError *error) {
        
    }];
    //2.请求店铺 分类 和 商品（默认） 信息
    NSMutableDictionary *parame = [NSMutableDictionary dictionary];
    parame[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parame[@"shopId"] = self.shopId;
    [[NetWorkManager shareManager] POST:USER_getShopCatAndGood parameters:parame successed:^(id json) {
        if (json) {
            
            NSArray *array = [ShopControllerModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataSourceArray addObjectsFromArray:array];
            ShopControllerModel *firstModel = Weakself.dataSourceArray.firstObject;
            firstModel.isSelect = YES;
            ShopControllerSecondModel *firstFirstModel = firstModel.children.firstObject;
            firstFirstModel.isSelect = YES;
            [Weakself.tableView reloadData];


            //1.设置分类信息数组（左数组）
            
            //1.设置分类信息数组（右数组）
            for (ShopControllerModel *model in self.dataSourceArray) {
                [self.rightDataSourceArray addObjectsFromArray:model.children];
            }
            for (ShopControllerSecondModel *goodModel in Weakself.rightDataSourceArray) {
                for (ShopControllerGoodsListModel *m in goodModel.goods) {
                    if (m.selectNum > 0) {
                        [Weakself.tableViewArray addObject:m];
                    }
                }
            }
            
            [self countMoney];
            [Weakself.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    //2.获取店铺超级详情信息
    NSMutableDictionary *paramesa = [NSMutableDictionary dictionary];
    paramesa[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    paramesa[@"shopId"] = self.shopId;
    [[NetWorkManager shareManager] POST:USER_getShopDetail parameters:paramesa successed:^(id json) {
        if (json) {
            ShopMessageModel *model = [ShopMessageModel mj_objectWithKeyValues:json];
            Weakself.detailModel = model;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
