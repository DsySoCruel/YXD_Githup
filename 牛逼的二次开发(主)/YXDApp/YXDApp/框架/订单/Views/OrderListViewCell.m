//
//  OrderListViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/22.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderListViewCell.h"
#import "HomeCateCollectionViewCell.h"
#import "ShopController.h"
#import "OrderListViewControllerModel.h"

static NSString *homeCateCollectionViewCell = @"homeCateCollectionViewCell";

@interface OrderListViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *shopNameButton;
@property (nonatomic,strong) UIImageView *jiantouImage;
@property (nonatomic,strong) UILabel *stateLabel;//订单状态：待接单 配送中 已完成 退款成功
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *totalPriceLabel;
@property (nonatomic,strong) UILabel *numberLabel;

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *line2View;//底部的line2
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *cuidanButton;//催单  （待接单）
@property (nonatomic,strong) UIButton *cancleButton;//取消订单 （待接单）
@property (nonatomic,strong) UIButton *sureButton;//确认收货    （配送中）
@property (nonatomic,strong) UIButton *commentButton;//评价  （已完成）
@property (nonatomic,strong) UILabel *canclePriceLabel;//退款金额 （退款成功）

@end
@implementation OrderListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    self.contentView.backgroundColor = BACK_COLOR;
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 8;
    self.backView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backView];
    
    self.shopNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shopNameButton.titleLabel.font = LPFFONT(14);
    [self.shopNameButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    [self.backView addSubview:self.shopNameButton];
    [self.shopNameButton addTarget:self action:@selector(pushToShopController) forControlEvents:UIControlEventTouchUpInside];
    
    self.jiantouImage = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_55")];
    [self.backView addSubview:self.jiantouImage];
    
    self.stateLabel = [UILabel new];
    self.stateLabel.font = LPFFONT(14);
    [self.backView addSubview:self.stateLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.backView addSubview:self.lineView];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 100) / 4, 90);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[HomeCateCollectionViewCell class] forCellWithReuseIdentifier:homeCateCollectionViewCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.userInteractionEnabled = NO;
    [self.backView addSubview:self.collectionView];
    
    self.totalPriceLabel = [UILabel new];
    self.totalPriceLabel.textAlignment = NSTextAlignmentCenter;
    self.totalPriceLabel.font = LPFFONT(15);
    self.totalPriceLabel.textColor = [UIColor redColor];
    [self.backView addSubview:self.totalPriceLabel];
    
    self.numberLabel = [UILabel new];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = LPFFONT(11);
    self.numberLabel.textColor = TEXTBlack_COLOR;
    [self.backView addSubview:self.numberLabel];
    
    //设置底部bottomView
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:self.bottomView];

    self.line2View = [UIView new];
    self.line2View.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.line2View];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"10-31 17:27";
    self.timeLabel.font = LPFFONT(12);
    self.timeLabel.textColor = TEXTGray_COLOR;
    [self.bottomView addSubview:self.timeLabel];
    
    self.canclePriceLabel = [UILabel new];
    self.canclePriceLabel.text = @"退款金额：￥44.8";
    self.canclePriceLabel.font = LPFFONT(16);
    self.canclePriceLabel.textColor = [UIColor redColor];
    [self.bottomView addSubview:self.canclePriceLabel];
    
    //四种交互button
    self.cuidanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cuidanButton.titleLabel.font = LPFFONT(13);
    [self.cuidanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cuidanButton.backgroundColor = THEME_COLOR;
    self.cuidanButton.layer.cornerRadius = 2;
    [self.cuidanButton setTitle:@"催单" forState:UIControlStateNormal];
    [self.cuidanButton setTitle:@"已催单" forState:UIControlStateSelected];
    [self.cuidanButton addTarget:self action:@selector(cuidanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.cuidanButton];
    
    self.cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancleButton.titleLabel.font = LPFFONT(13);
    [self.cancleButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    self.cancleButton.layer.cornerRadius = 2;
    self.cancleButton.layer.borderWidth = 0.5;
    self.cancleButton.layer.borderColor = TEXTGray_COLOR.CGColor;
    [self.cancleButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.cancleButton];
    
    self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureButton.titleLabel.font = LPFFONT(13);
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureButton.backgroundColor = THEME_COLOR;
    self.sureButton.layer.cornerRadius = 2;
    [self.sureButton setTitle:@"确认收货" forState:UIControlStateNormal];
    [self.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.sureButton];

    self.commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentButton.titleLabel.font = LPFFONT(13);
    [self.commentButton setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [self.commentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    self.commentButton.layer.cornerRadius = 2;
    self.commentButton.layer.borderWidth = 0.5;
    self.commentButton.layer.borderColor = THEME_COLOR.CGColor;
    [self.commentButton setTitle:@"评价" forState:UIControlStateNormal];
    [self.commentButton setTitle:@"已评价" forState:UIControlStateSelected];
    [self.commentButton addTarget:self action:@selector(commentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.commentButton];

}

- (void)setupLayout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 10;
        make.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = 0;
    }];
    [self.shopNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 0;
        make.height.offset = 45;
    }];
    [self.jiantouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopNameButton).offset = 0;
        make.left.equalTo(self.shopNameButton.mas_right).offset = 10;
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopNameButton).offset = 0;
        make.right.offset = -10;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.offset = 1;
        make.top.equalTo(self.shopNameButton.mas_bottom).offset = 0;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = -60;
        make.top.equalTo(self.lineView.mas_bottom).offset = 0;
        make.height.offset = 90;
    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.left.equalTo(self.collectionView.mas_right).offset = 0;
        make.centerY.equalTo(self.collectionView).offset = -10;
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.left.equalTo(self.collectionView.mas_right).offset = 0;
        make.centerY.equalTo(self.collectionView).offset = 10;
    }];
    
    //设置底部bottomView
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.collectionView.mas_bottom).offset = 0;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.offset = 1;
        make.top.offset = 0;
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.bottom.offset = 0;
    }];
    
    //设置交互方式
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 30;
        make.width.offset = 70;
        make.centerY.offset = 0;
        make.right.offset = - 10;
    }];
    
    [self.cuidanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 30;
        make.width.offset = 60;
        make.centerY.offset = 0;
        make.right.equalTo(self.cancleButton.mas_left).offset = - 15;
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 30;
        make.width.offset = 70;
        make.centerY.offset = 0;
        make.right.offset = - 10;
    }];
    [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 30;
        make.width.offset = 70;
        make.centerY.offset = 0;
        make.right.offset = - 10;
    }];
    [self.canclePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = - 10;
    }];
}



#pragma mark- UICollectionViewDatasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCateCollectionViewCell forIndexPath:indexPath];
    cell.listGoodsModel = self.model.goodslist[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.goodslist.count;
}

#pragma mark - 设置数据
- (void)setModel:(OrderListViewControllerModel *)model{
    _model = model;
    
    [self.shopNameButton setTitle:model.shopName forState:UIControlStateNormal];
    self.stateLabel.text = model.statusName;
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.realTotalMoney];
    self.numberLabel.text = [NSString stringWithFormat:@"共%@件",model.goodsNum];
    self.timeLabel.text = model.createTime;
    [self.collectionView reloadData];
    
//    orderStatus = 0或1或2表示待接单
//    orderStatus = 3  -5  5  6  表示配送中
//    orderStatus = 4   表示已完成
//    orderStatus < 0   表示退款
    
    if ([model.orderStatus integerValue] == 0 ||[model.orderStatus integerValue] == 1 || [model.orderStatus integerValue] == 2 ) {
        self.sureButton.hidden = YES;
        self.commentButton.hidden = YES;
        self.canclePriceLabel.hidden = YES;
        self.cuidanButton.hidden = NO;
        self.cancleButton.hidden = NO;
        self.stateLabel.textColor = [UIColor redColor];
        self.cuidanButton.selected = [model.reminder integerValue];
        if (self.cuidanButton.selected) {
            self.cuidanButton.backgroundColor = UNAble_color;
        }else{
            self.cuidanButton.backgroundColor = THEME_COLOR;
        }
    }else if ([model.orderStatus integerValue] == 3 ||[model.orderStatus integerValue] == -5 || [model.orderStatus integerValue] == 5 ||[model.orderStatus integerValue] == 6 ){
        self.sureButton.hidden = NO;
        self.commentButton.hidden = YES;
        self.canclePriceLabel.hidden = YES;
        self.cuidanButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.stateLabel.textColor = THEME_COLOR;
    }else if ([model.orderStatus integerValue] == 4){
        self.sureButton.hidden = YES;
        self.commentButton.hidden = NO;
        self.commentButton.selected = [model.isAppraises integerValue];
        self.commentButton.userInteractionEnabled = !self.commentButton.selected;
        if (self.commentButton.selected) {
            self.commentButton.backgroundColor = UNAble_color;
            self.commentButton.layer.borderWidth = 0;
        }else{
            self.commentButton.backgroundColor = [UIColor whiteColor];
            self.commentButton.layer.borderWidth = 0.5;
        }
        self.canclePriceLabel.hidden = YES;
        self.cuidanButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.stateLabel.textColor = TEXTGray_COLOR;
    }else{
        self.sureButton.hidden = YES;
        self.commentButton.hidden = YES;
        self.canclePriceLabel.hidden = NO;
        self.cuidanButton.hidden = YES;
        self.cancleButton.hidden = YES;
        self.canclePriceLabel.text = [NSString stringWithFormat:@"退款金额：￥%@",model.realTotalMoney];
        self.stateLabel.textColor = TEXTGray_COLOR;
    }
    
//    if ([model.statusName isEqualToString:@"待接单"]) {
//    }else if ([model.statusName isEqualToString:@"配送中"]){
//    }else if ([model.statusName isEqualToString:@"已完成"]){
//    }else if ([model.statusName isEqualToString:@"退款成功"]){
//    }
    
}

#pragma mark--执行方法
- (void)pushToShopController{
    ShopController *shop = [ShopController new];
    shop.shopId = self.model.shopId;
    [self.navigationController pushViewController:shop animated:YES];
}
//评价
- (void)commentButtonAction:(UIButton *)sender{
    if (self.commentActionBlock) {
        self.commentActionBlock(self.model.orderId);
    }
}
//取消订单
- (void)cancleButtonAction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.model.orderId;
    parames[@"type"] = @"1";
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_changeOrder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"取消订单成功"];
            sender.userInteractionEnabled = YES;
            if (Weakself.cancleOrderBlock) {
                Weakself.cancleOrderBlock();
            }
        }
    } failure:^(NSError *error) {
    }];
}
//催单
- (void)cuidanButtonAction:(UIButton *)sender{
    if (sender.isSelected) {
        [MBHUDHelper showSuccess:@"已催单"];
        return;
    }
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.model.orderId;
    [[NetWorkManager shareManager] POST:USER_toReminder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"催单成功"];
            sender.selected = YES;
            sender.userInteractionEnabled = NO;
            sender.backgroundColor = UNAble_color;
        }
    } failure:^(NSError *error) {
    }];
 
}
//确认订单
- (void)sureButtonAction:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.model.orderId;
    parames[@"type"] = @"2";
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_changeOrder parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"确认收货成功"];
            sender.userInteractionEnabled = YES;
            if (Weakself.cancleOrderBlock) {
                Weakself.cancleOrderBlock();
            }
        }
    } failure:^(NSError *error) {
    }];
}

@end
