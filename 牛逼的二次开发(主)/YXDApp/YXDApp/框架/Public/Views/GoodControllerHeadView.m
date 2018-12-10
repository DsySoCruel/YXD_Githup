//
//  GoodControllerHeadView.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "GoodControllerHeadView.h"
#import "SDCycleScrollView.h"
#import "StarView.h"
#import "GoodControllerModel.h"

@interface GoodControllerHeadView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *markPriceLabel;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) YXDButton *connectButton;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UILabel *sectionTitle;
@property (nonatomic, strong) UILabel *commentCount;
@property (nonatomic, strong) UIView *aaView;
@property (nonatomic, strong) StarView *starView;

@end

@implementation GoodControllerHeadView


- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}


#pragma mark- UI
- (void)setupUI{
    
    self.backgroundColor = BACK_COLOR;
    
    //1.添加轮播图
    self.cycleScrollView = [SDCycleScrollView new];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"pageHighlight"];
    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"pageNormal"];
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
    
    
//            NSArray *imagesURLStrings = @[
//                                          @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
//                                          @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
//                                          @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
//                                          ];
//
//        self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
    [self.cycleScrollView setClickItemOperationBlock:^(NSInteger index){
        
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
    
    //1.设置中间view
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = BPFFONT(14);
    self.titleLabel.textColor = TEXTBlack_COLOR;
    [self.topView addSubview:self.titleLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textColor = [UIColor redColor];
    [self.topView addSubview:self.priceLabel];
    
    self.markPriceLabel = [UILabel new];
    self.markPriceLabel.textColor = [UIColor grayColor];
    self.markPriceLabel.font = LPFFONT(11);
    [self.topView addSubview:self.markPriceLabel];
    
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.backgroundColor = THEME_COLOR;
    [self.addButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.layer.cornerRadius = 2;
    self.addButton.titleLabel.font = LPFFONT(14);
    self.addButton.layer.masksToBounds = YES;
    [self.topView addSubview:self.addButton];
    
    //2.设置bottemView
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.image = IMAGECACHE(@"icon_46");
    [self.bottomView addSubview:self.iconImageView];
    
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.text  = @"沃尔玛-还原撸点";
    self.shopNameLabel.textColor = TEXTBlack_COLOR;
    self.shopNameLabel.font = BPFFONT(13);
    [self.bottomView addSubview:self.shopNameLabel];
    
    self.connectButton = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.connectButton setTitle:@"联系商家" forState:UIControlStateNormal];
    [self.connectButton setImage:IMAGECACHE(@"icon_70") forState:UIControlStateNormal];
    [self.connectButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    self.connectButton.titleLabel.font = MFFONT(15);
    self.connectButton.status = MoreStyleStatusNormal;
    self.connectButton.padding = 5;
    [self.connectButton addTarget:self action:@selector(connectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.connectButton];
    
    self.line1  = [UIView new];
    self.line1.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.line1];

    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.line2];
    
    self.sectionTitle = [UILabel new];
    self.sectionTitle.text = @"商品评价";
    self.sectionTitle.textColor = TEXTBlack_COLOR;
    self.sectionTitle.font = BPFFONT(13);
    [self.bottomView addSubview:self.sectionTitle];
    
    self.commentCount = [UILabel new];
    self.commentCount.text = @"共4人评价";
    self.commentCount.textColor = TEXTGray_COLOR;
    self.commentCount.font = LPFFONT(12);
    [self.bottomView addSubview:self.commentCount];
    
    self.aaView = [UIView new];
    self.aaView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.aaView];
    
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    self.starView.avgScore = 2;
    [self.aaView addSubview:self.starView];
    
}



- (void)setupLayout{
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset = 0;
        make.bottom.offset = -220;
    }];
    
    //1.topView
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 100;
        make.top.equalTo(self.cycleScrollView.mas_bottom).offset = 10;
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 25;
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 5;
        make.bottom.offset = -10;
    }];
    [self.markPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset = 8;
        make.bottom.equalTo(self.priceLabel);
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -5;
        make.bottom.offset = -10;
        make.width.offset = 100;
        make.height.offset = 28;
    }];
    //2.bottomView
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 100;
        make.top.equalTo(self.topView.mas_bottom).offset = 10;
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 15;
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.centerY.equalTo(self.iconImageView);
    }];
    [self.connectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.connectButton.mas_left).offset = -10;
        make.height.offset = 20;
        make.width.offset = 1;
        make.centerY.equalTo(self.iconImageView);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.offset = 1;
        make.top.equalTo(self.connectButton.mas_bottom).offset = 8;
    }];
    
    [self.sectionTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.line2.mas_bottom).offset = 10;
    }];
    [self.commentCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sectionTitle.mas_right).offset = 5;
        make.centerY.equalTo(self.sectionTitle);
    }];
    
    [self.aaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 80;
        make.height.offset = 20;
        make.bottom.offset = -5;
    }];
    
}

#pragma mark - 按钮执行方法

- (void)connectButtonAction:(UIButton *)sender{
    
    if (self.goodsModel.goodsInfo.shopTel.length) {
        NSString *telStr = self.goodsModel.goodsInfo.shopTel;
        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL *telURL     = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self addSubview:callWebView];

    }else{
        [MBHUDHelper showError:@"暂无联系方式"];
    }
    
}

- (void)addButtonAction:(UIButton *)sender{
    if (self.selectGoodBlock) {
        self.selectGoodBlock();
    }
}

- (void)setGoodsModel:(GoodControllerModel *)goodsModel{
    _goodsModel = goodsModel;
    
    NSArray *imagesURLStrings = @[[NSString stringWithFormat:@"%@/%@",YXDMainPath,goodsModel.goodsInfo.goodsThums]];
    self.cycleScrollView.imageURLStringsGroup = imagesURLStrings;

    self.titleLabel.text = goodsModel.goodsInfo.goodsName;
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",goodsModel.goodsInfo.price]];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(16) range:NSMakeRange(1, titleString.length-1)];
    [self.priceLabel setAttributedText:titleString];
    
    if (self.goodsModel.goodsInfo.intro.length) {
        self.markPriceLabel.hidden = NO;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价:￥%@",goodsModel.goodsInfo.marketPrice]
                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
        //        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"123456"
        //                                                                                    attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleNone)}];
        [attrStr setAttributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                 NSBaselineOffsetAttributeName : @0}
                         range:NSMakeRange(3, attrStr.length - 3)];
        
        
        self.markPriceLabel.attributedText = attrStr;
    }else{
        self.markPriceLabel.hidden = YES;
    }
    
    
    
    self.shopNameLabel.text  = goodsModel.goodsInfo.shopName;

    self.commentCount.text = [NSString stringWithFormat:@"(共%@人评价)",goodsModel.appraise.count];

    self.starView.avgScore = [goodsModel.appraise.res integerValue];
    
}


@end
