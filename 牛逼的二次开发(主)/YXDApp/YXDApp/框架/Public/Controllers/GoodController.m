//
//  GoodController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/21.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "GoodController.h"
#import "GoodControllerHeadView.h"
#import "HomeSectionHeaderView.h"
#import "GoodControllerModel.h"
#import "ShopControllerModel.h"
#import "ShopCarDetailController.h"

static NSString * kGoodController = @"GoodController";


@interface GoodController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GoodControllerHeadView *headView;
@property (nonatomic, strong) UIButton *backButton;
//保存数组
@property (nonatomic, strong) NSMutableArray *dataSourceArray;//咨询数组
@property (nonatomic, strong) GoodControllerModel *goodsModel;

//底部工具条
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *lineBottom;
@property (nonatomic,strong) UIImageView *bottomImageView;
@property (nonatomic,strong) UILabel *bottomNum;
@property (nonatomic,strong) UILabel *bottomPriceLabel;
@property (nonatomic,strong) UIButton *bottomButton;

@end

@implementation GoodController

- (NSMutableArray *)selectGoods{
    if (!_selectGoods) {
        _selectGoods = [NSMutableArray array];
    }
    return _selectGoods;
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


- (GoodControllerHeadView *)headView{
    if(!_headView){
        _headView = [GoodControllerHeadView new];
        CGFloat height = 0;
        height = YXDScreenW + 220;
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
    self.view.backgroundColor = BACK_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //设置navigationView
    [self.view addSubview:self.tableView];
    [self loadNewsData];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:IMAGECACHE(@"icon_44") forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
        
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
    
    [self countMoney];
    
    [self setupLayout];
    
    //添加到购物车里的操作
    WeakObj(self);
    self.headView.selectGoodBlock = ^{
        
        if (Weakself.shopId.length) {
            
        }else{
            if (Weakself.model.selectNum > [Weakself.model.totalStock integerValue]) {
                [MBHUDHelper showSuccess:@"库存剩余不足"];
                return;
            }
            ++Weakself.model.selectNum ;
            
            if (Weakself.jiaButtonBlock) {
                Weakself.jiaButtonBlock(Weakself.model);
            }
        }

        //更改数据
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        if (Weakself.shopId.length) {
            parames[@"goodsId"] = Weakself.goodsId;
            parames[@"shopId"] = Weakself.shopId;
            parames[@"gcount"] = @"1";
        }else{
            parames[@"goodsId"] = Weakself.model.goodsId;
            parames[@"shopId"] = Weakself.model.shopId;
            parames[@"gcount"] = [NSString stringWithFormat:@"%tu",Weakself.model.selectNum];
        }
        [[NetWorkManager shareManager] POST:USER_addToCart parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"添加购物车成功"];
                //添加本地数组
                //判断有没有 没有就添加  有就替换
                BOOL isHave = NO;
                for (ShopControllerGoodsListModel *goodModel in Weakself.selectGoods) {
                    if ([goodModel.goodsId isEqualToString:Weakself.model.goodsId]) {
                        goodModel.selectNum = Weakself.model.selectNum;
                        isHave = YES;
                        [Weakself countMoney];
                        break;
                    }
                }
                if (Weakself.shopId.length) {
                    if (!isHave) {//没有
                        ShopControllerGoodsListModel *model = [ShopControllerGoodsListModel new];
                        model.shopId = Weakself.goodsModel.goodsInfo.shopId;
                        model.shopName = Weakself.goodsModel.goodsInfo.shopName;
                        model.goodsId = Weakself.goodsModel.goodsInfo.goodsId;
                        model.goodsName = Weakself.goodsModel.goodsInfo.goodsName;
                        model.price = Weakself.goodsModel.goodsInfo.price;
                        [Weakself.selectGoods addObject:model];
                    }
                }else{
                    if (!isHave) {//没有
                        [Weakself.selectGoods addObject:Weakself.model];
                    }
                }

                [Weakself countMoney];                
            }
        } failure:^(NSError *error) {
            
        }];  
    };
}

- (void)setupLayout{
    if (@available(iOS 11.0, *)){//避免滚动视图顶部出现20的空白以及push或者pop的时候页面有一个上移或者下移的异常动画的问题
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset = 0;
            make.top.offset = -20 - SafeTopSpace;
            make.bottom.offset = -49;
        }];
    }else{
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.offset = 0;
            make.bottom.offset = -49;
        }];
    }

    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 23 + SafeTopSpace;
        make.left.offset = 10;
    }];
    
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.tableView.mas_bottom).offset = 0;
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



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kGoodController];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 150;
        _tableView.tableHeaderView = self.headView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = BACK_COLOR;
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [self loadNewsData];
        }];
        _tableView.mj_footer = [RefreshFooterView footerWithRefreshingBlock:^{
            [self loadMoreData];
        }];

    }
    return _tableView;
}

#pragma mark tableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HomeSectionHeaderView *headView = [[HomeSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 50)];
    headView.name = @"继续滑动,查看更多内容";
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kGoodController];
    return cell;
}

#pragma mark-获取首页数据
- (void)loadNewsData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"goodsId"] = self.goodsId;
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    }
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_goodsDetail parameters:parames successed:^(id json) {
        if (json) {
            self.goodsModel = [GoodControllerModel mj_objectWithKeyValues:json];
            self.headView.goodsModel = self.goodsModel;
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    [MBHUDHelper showSuccess:@"暂无更多信息"];
    [self.tableView.mj_footer endRefreshing];
}

- (void)backButtonAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)setModel:(ShopControllerGoodsListModel *)model{
    _model = model;
}


//计算总金额
- (void)countMoney{
    NSInteger totalNum = 0;
    CGFloat totalPrice = 0.00;
    for (ShopControllerGoodsListModel *goodModel in self.selectGoods) {
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
    vc.shopId = self.shopID;
    [tab.selectedViewController pushViewController:vc animated:YES];
}
@end
