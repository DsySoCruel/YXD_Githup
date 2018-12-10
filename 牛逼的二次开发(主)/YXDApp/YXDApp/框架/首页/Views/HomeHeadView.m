//
//  HomeHeadView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeHeadView.h"
#import "SDCycleScrollView.h"
#import "HomeCateCollectionViewCell.h"
#import "FunctionCollectCellModel.h"
#import "HomeSeckillController.h"
#import "HomBannerModel.h"
#import "HomeIndustryModel.h"
#import "HomeCategoryDetailController.h"
#import "HomeHeaderModel.h"

static NSString *homeCateCollectionViewCell = @"homeCateCollectionViewCell";


@interface HomeHeadView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource
>
@property (nonatomic, strong) UIImageView *homeBackImageView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIImageView *adView;//广告条

@property (nonatomic, strong) UIImageView *adView1;//广告秒杀

@property (nonatomic, strong) UIImageView *adView2;//天天特价

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *bannerModelDataArray;

@property (nonatomic,strong) HomBannerModel *middleModel;//中间广告条的信息

@end

@implementation HomeHeadView

- (NSMutableArray *)bannerModelDataArray{
    if (!_bannerModelDataArray) {
        _bannerModelDataArray = [NSMutableArray array];
    }
    return _bannerModelDataArray;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}


#pragma mark- Set

//- (void)setBannerDatas:(BannerRequestItem *)bannerDatas{
//    _bannerDatas = bannerDatas;
//    NSMutableArray *images = [NSMutableArray new];
//    [bannerDatas.data enumerateObjectsUsingBlock:^(BannerRequestItemDataBanner  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if(!isEmpty(obj.picture)){
//            [images addObject:obj.picture.ori];
//        }
//    }];
//    self.cycleScrollView.imageURLStringsGroup = images;
//    [self.cycleScrollView adjustWhenControllerViewWillAppera];
//}


//- (void)setHomeFunctions:(HomeFunctionRequsetItem *)homeFunctions{
//    _homeFunctions = homeFunctions;
//    [self.collectionView reloadData];
//}


#pragma mark- UI
- (void)setupUI{
    
    self.backgroundColor = BACK_COLOR;
    
    //取出缓存数据
    NSString *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeFunctions"];
    if (data.length) {
//        self.homeFunctions = [[HomeFunctionRequsetItem alloc] initWithDictionary:[data dictionary] error:nil];
    }
    
    self.homeBackImageView = [UIImageView new];
    self.homeBackImageView.image = IMAGECACHE(@"home_bback");
    [self addSubview:self.homeBackImageView];
    
    //1.添加轮播图
    self.cycleScrollView = [SDCycleScrollView new];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageHighlight"];
    self.cycleScrollView.layer.cornerRadius = 5;
    self.cycleScrollView.layer.masksToBounds = YES;
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageNormal"];
    self.cycleScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.cycleScrollView];
    //    NSString *bannerData = [[NSUserDefaults standardUserDefaults] objectForKey:@"banner"];
    //    if (bannerData.length) {
    //
    //        self.bannerDatas = [[BannerRequestItem alloc] initWithDictionary:[bannerData dictionary] error:nil];
    //
    //        NSMutableArray *images = [NSMutableArray new];
    //        [self.bannerDatas.data enumerateObjectsUsingBlock:^(BannerRequestItemDataBanner  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //            if(!isEmpty(obj.picture)){
    //                [images addObject:obj.picture.ori];
    //            }
    //        }];
    //        self.cycleScrollView.imageURLStringsGroup = images;
    //    }
    
    
//        NSArray *imagesURLStrings = @[
//                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                      ];

//    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;

    WeakObj(self)
    [self.cycleScrollView setClickItemOperationBlock:^(NSInteger index){
        
        HomBannerModel *model = Weakself.bannerModelDataArray[index];
        ShopController *shopView = [ShopController new];
        shopView.shopId = model.adURL;
        [Weakself.navigationController pushViewController:shopView animated:YES];
        
//        BannerRequestItemDataBanner *bannerData = self.bannerDatas.data[index];
//        if (isEmpty(bannerData.hyprLink)) {
//            return;
//        }
//        if ([bannerData.hyprLink hasPrefix:@"http"]) {
//            [NewsWebViewManager openNewsWebViewController:[BaseViewController topViewController].navigationController startPageUrlString:bannerData.hyprLink navTitle:nil];
//            [[NewsWebViewManager sharedManager].newsWebVC setBannerShareInfo:bannerData];
//            return;
//        } else {
//            ArticleDetailViewController *vc = [[ArticleDetailViewController alloc] initWithEmpty:NO];
//            vc.articleID = bannerData.hyprLink;
//            vc.bannerTitile = bannerData.title;
//            [[BaseViewController topViewController].navigationController pushViewController:vc animated:YES];
//        }
    }];
    //2.添加功能区
    self.dataArray = [NSMutableArray array];
    
//    FunctionCollectCellModel *mode1 = [FunctionCollectCellModel itemWithTitle:@"超市便利" icon:@"icon_23"];
//    [self.dataArray addObject:mode1];
//    FunctionCollectCellModel *mode2 = [FunctionCollectCellModel itemWithTitle:@"新鲜果蔬" icon:@"icon_24"];
//    [self.dataArray addObject:mode2];
//    FunctionCollectCellModel *mode3 = [FunctionCollectCellModel itemWithTitle:@"零食烘培" icon:@"icon_25"];
//    [self.dataArray addObject:mode3];
//    FunctionCollectCellModel *mode4 = [FunctionCollectCellModel itemWithTitle:@"鲜花蛋糕" icon:@"icon_26"];
//    [self.dataArray addObject:mode4];
//    FunctionCollectCellModel *mode5 = [FunctionCollectCellModel itemWithTitle:@"医药健康" icon:@"icon_27"];
//    [self.dataArray addObject:mode5];
    
    
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW) / 5, 93-13);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[HomeCateCollectionViewCell class] forCellWithReuseIdentifier:homeCateCollectionViewCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self addSubview:self.collectionView];
    
    //3.广告条
//    self.announceView = [AnnounceView new];
//    [self addSubview:self.announceView];
    self.adView = [UIImageView new];
//    self.adView.backgroundColor = [UIColor whiteColor];
    self.adView.userInteractionEnabled = YES;
    self.adView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:self.adView];
    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adViewAction)];
    [self.adView addGestureRecognizer:tap];

    
    //4.添加秒杀
    self.adView1 = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_1002")];
    self.adView1.backgroundColor = [UIColor whiteColor];
    self.adView1.layer.masksToBounds = YES;
    self.adView1.userInteractionEnabled = YES;
    self.adView1.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.adView1];
    //添加手势
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
    [self.adView1 addGestureRecognizer:tap1];
    
    
    //5.添加天天特价
    self.adView2 =  [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_1001")];
    self.adView2.backgroundColor = [UIColor whiteColor];
    self.adView2.contentMode = UIViewContentModeScaleAspectFill;
    self.adView2.layer.masksToBounds = YES;
    self.adView2.userInteractionEnabled = YES;
    [self addSubview:self.adView2];
    //添加手势
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView2Action)];
    [self.adView2 addGestureRecognizer:tap2];
    //建议使用组信息
    //加载轮播图
    [self loadBanner];
}
- (void)adViewAction{
    ShopController *shopView = [ShopController new];
    shopView.shopId = self.middleModel.adURL;
    [self.navigationController pushViewController:shopView animated:YES];
}

- (void)adView1Action{
    HomeSeckillController *vc = [HomeSeckillController new];
    vc.seckillType = SeckillTypeOne;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)adView2Action{
    HomeSeckillController *vc = [HomeSeckillController new];
    vc.seckillType = SeckillTypeTwo;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setupLayout{
    
    [self.homeBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 0;
        make.right.offset = -0;
        make.bottom.offset = - 280;
    }];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = - 280;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.offset = 0;
        make.height.offset = 74;
    }];
    
    [self.adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).offset = 10;
        make.left.offset = 5;
        make.right.offset = -5;
        make.height.offset = 93;
    }];
    
    [self.adView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adView.mas_bottom).offset = 10;
        make.left.offset = 5;
        make.height.offset = 90;
        make.width.mas_equalTo(YXDScreenW*0.5 - 5 - 0.5);
    }];

    [self.adView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adView.mas_bottom).offset = 10;
        make.right.offset = -5;
        make.height.offset = 90;
        make.width.mas_equalTo(YXDScreenW*0.5 - 5 - 0.5);
    }];
    
}

#pragma mark- UICollectionViewDatasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCateCollectionViewCell forIndexPath:indexPath];
    cell.industryModel = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

#pragma mark- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeIndustryModel *model = self.dataArray[indexPath.row];
    HomeCategoryDetailController *vc = [HomeCategoryDetailController new];
    vc.catId = model.catId;
    vc.title = model.catName;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark-获取首页数据

- (void)loadBanner{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_homeBanner parameters:parames successed:^(id json) {
        if (json) {
            HomeHeaderModel *model = [HomeHeaderModel mj_objectWithKeyValues:json];
            //1.获取轮播图数据
            NSMutableArray *images = [NSMutableArray new];
            [self.bannerModelDataArray removeAllObjects];
            [model.banners enumerateObjectsUsingBlock:^(HomBannerModel  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:[NSString stringWithFormat:@"%@/%@",YXDMainPath,obj.adFile]];
                [self.bannerModelDataArray addObject:obj];
            }];
            Weakself.cycleScrollView.imageURLStringsGroup = images;
            //2.获取中部广告数据
            HomBannerModel *model2 = model.cenads.firstObject;
            self.middleModel = model2;
            [Weakself.adView sd_setImageWithURL:URLWithImageName(model2.adFile) placeholderImage:IMAGECACHE(@"login_icon")];
            //3.获取行业分类
            [Weakself.dataArray removeAllObjects];
            [Weakself.dataArray addObjectsFromArray:model.cats];
            [Weakself.collectionView reloadData];
            //4.秒杀
            [self.adView1 sd_setImageWithURL:URLWithImageName(model.seckillads.adFile) placeholderImage:IMAGECACHE(@"icon_0000")];
            //5.秒杀
            [self.adView2 sd_setImageWithURL:URLWithImageName(model.groupads.adFile)placeholderImage:IMAGECACHE(@"icon_0000")];
        }
        
    } failure:^(NSError *error) {
        
    }];
}


@end
