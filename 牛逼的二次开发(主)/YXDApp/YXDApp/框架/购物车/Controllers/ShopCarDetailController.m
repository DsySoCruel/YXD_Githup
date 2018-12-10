//
//  ShopCarDetailController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/26.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopCarDetailController.h"
#import "ShopCarViewModel.h"
#import "ShopCarDetailCell.h"
#import "ShopCarDetailModel.h"
#import "OrderProducController.h"
#import "OrderProducModel.h"

static NSString *kShopCarDetailCell = @"ShopCarDetailCell";

@interface ShopCarDetailController ()<UITableViewDelegate,UITableViewDataSource>
//1.topViwe
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *selectAllButton;
@property (nonatomic,strong) UIButton *deletAllButton;

//2.tableView
@property (nonatomic,strong) UITableView *tableView;

//3.bottomView
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *buyButton;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) ShopCarDetailModel *model;

@end

@implementation ShopCarDetailController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self setupUI];
    [self setupLayout];

}
- (void)setupUI{
    self.view.backgroundColor = BACK_COLOR;

    //1.
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    
    self.selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectAllButton setImage:IMAGECACHE(@"icon_weixuan") forState:UIControlStateNormal];
    [self.selectAllButton setImage:IMAGECACHE(@"icon_50") forState:UIControlStateSelected];
    [self.selectAllButton addTarget:self action:@selector(selectAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    [self.selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
    self.selectAllButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.selectAllButton.titleLabel.font = LPFFONT(13);
    [self.topView addSubview:self.selectAllButton];
    
    self.deletAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deletAllButton setTitle:@"清除购物车" forState:UIControlStateNormal];
    [self.deletAllButton setImage:IMAGECACHE(@"icon_51") forState:UIControlStateNormal];
    [self.deletAllButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    self.deletAllButton.titleLabel.font = LPFFONT(13);
    [self.deletAllButton addTarget:self action:@selector(deletAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.deletAllButton];
    //2.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[ShopCarDetailCell class] forCellReuseIdentifier:kShopCarDetailCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self loadData];
    
    
    
    //3.
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.priceLabel = [UILabel new];
    [self.bottomView addSubview:self.priceLabel];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥0.00"]];
    [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleString.length)];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(20) range:NSMakeRange(1, titleString.length-1)];
    [self.priceLabel setAttributedText:titleString];

    
    self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyButton.backgroundColor = THEME_COLOR;
    [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyButton.titleLabel.font = LPFFONT(15);
    [self.buyButton setTitle:@"去结算" forState:UIControlStateNormal];
    [self.bottomView addSubview:self.buyButton];
    [self.buyButton addTarget:self action:@selector(buyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)setupLayout{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 64 + SafeTopSpace;
        make.left.right.offset = 0;
        make.height.offset = 50;
    }];
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 2;
        make.centerY.offset = 0;
        make.width.offset = 70;
        make.height.offset = 50;
    }];
    [self.deletAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.offset = 0;
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset = 1;
        make.right.left.offset = 0;
        make.bottom.offset = -50;
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 50;
        make.bottom.offset = 0;
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.offset = 0;
    }];
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.offset = 0;
        make.width.offset = 100;
    }];
    
}

#pragma mark-tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopCarDetailCell];
    ShopCarDetailGoodsModel *model = self.dataArray[indexPath.row];
    cell.goodModel = model;
    cell.shopId = self.model.cartgoods.shopId;
    WeakObj(self);
    cell.needContTotalPriceBlock = ^{
        [Weakself countTotalPrice];
    };
    cell.selectButtonActionBlock = ^{
        //统计全选按钮是否需要选中
        BOOL isSelectAll = YES;
        for (ShopCarDetailGoodsModel *model in Weakself.dataArray) {
            if (!model.isSelect) {
                isSelectAll = NO;
                break;
            }
        }
        Weakself.selectAllButton.selected = isSelectAll;
        [Weakself countTotalPrice];
    };
    cell.needUpdataBlock = ^{
        [Weakself loadData];
    };
    return cell;
}

- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"shopId"] = self.shopId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toShopCart parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            ShopCarDetailModel *model = [ShopCarDetailModel mj_objectWithKeyValues:json];
            [Weakself.dataArray addObjectsFromArray:model.cartgoods.shopgoods];
            Weakself.model = model;
            [Weakself.tableView reloadData];
            [self selectAllButtonAction:self.selectAllButton];
            if (Weakself.dataArray.count == 0) {
                [Weakself showEmptyMessage:@"购物车为空"];
            }else{
                [Weakself hideEmptyView];
            }
        }
    } failure:^(NSError *error) {
    }];
}




- (void)selectAllButtonAction:(UIButton *)sender{
    BOOL isSelectAll = YES;
    for (ShopCarDetailGoodsModel *model in self.dataArray) {
        if (!model.isSelect) {
            isSelectAll = NO;
            break;
        }
    }
    for (ShopCarDetailGoodsModel *model in self.dataArray) {
        if (isSelectAll) {
            model.isSelect = NO;
        }else{
            if (!model.isSelect) {
                model.isSelect = YES;
            }
        }
    }
    sender.selected = !sender.selected;
    [self.tableView reloadData];
    [self countTotalPrice];
}
- (void)deletAllButtonAction:(UIButton *)sender{
    //删除所有
    //进行删除操作
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"shopId"] = self.shopId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_removeCart parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"删除成功"];
            //刷新购物车数据
//            if (Weakself.deletSuccessBlock) {
//                Weakself.deletSuccessBlock();
//            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMyShopCar" object:nil];

            [Weakself.navigationController popViewControllerAnimated:YES];
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}
#pragma mark--生成订单
- (void)buyButtonAction:(UIButton *)sender{
    BOOL isCanPush = NO;
    for (ShopCarDetailGoodsModel *model in self.dataArray) {
        if (model.isSelect) {
            isCanPush = YES;
            break;
        }
    }
    if (!isCanPush) {
        [MBHUDHelper showSuccess:@"没有选中商品"];
        return;
    }
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"shopId"] = self.shopId;
    
    NSString *str = @"";
    for (ShopCarDetailGoodsModel *model in self.dataArray) {
        if (model.isSelect) {
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@:%@,",model.goodsId,model.cnt]];
        }
    }
    NSString *ids = [str substringToIndex:str.length - 1];
    parames[@"ids"] = ids;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toOrderCart parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"下单成功"];
            OrderProducModel *model = [OrderProducModel mj_objectWithKeyValues:json];
            OrderProducController *vc = [OrderProducController new];
            vc.model = model;
            vc.shopId = Weakself.shopId;
            [Weakself.navigationController pushViewController:vc animated:YES];
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}


#pragma mark--计算价钱
- (void)countTotalPrice{
    CGFloat totalPrice = 0.00;
    for (ShopCarDetailGoodsModel *model in self.dataArray) {
        if (model.isSelect) {
            totalPrice += [model.price floatValue]*[model.cnt integerValue];
        }
    }
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2f",totalPrice]];
    [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleString.length)];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(20) range:NSMakeRange(1, titleString.length-1)];
    [self.priceLabel setAttributedText:titleString];
}

@end
