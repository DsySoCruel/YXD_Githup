//
//  OrderProducFirstCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/28.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderProducFirstCell.h"
#import "OrderDetailFirstTableViewCell.h"
#import "OrderProducFirstCollectionCell.h"
#import "PeisongAlertView.h"

static NSString *kOrderProducFirstDetailCell = @"OrderProducFirstDetailCell";

@interface OrderProducFirstCell()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *leftLine;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UIView *rightLine;
@property (nonatomic,strong) UIView *lineView;

//商品详情
@property (nonatomic,strong) UITableView *maintableView;


@property (nonatomic,strong) UIView *aaView;//隐藏
@property (nonatomic,strong) UILabel *messageLabel;//隐藏
@property (nonatomic,strong) UIImageView *jiantouTwo;//隐藏

//配送信息
@property (nonatomic,strong) UILabel *priceNLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *peisongNLabel;
@property (nonatomic,strong) UILabel *peisongLabel;
@property (nonatomic,strong) UIButton *wenhaoImageView;
@property (nonatomic,strong) UILabel *youhuiNLabel;
@property (nonatomic,strong) UILabel *youhuiLabel;
//优惠卷

@property (nonatomic,strong) UICollectionView *mainCollectionView;

@property (nonatomic,strong) UIView *linetwoView;

@property (nonatomic,strong) UILabel *pricetwoLabel;
@property (nonatomic,strong) UILabel *pricethreeLabel;

@property (nonatomic,strong) UIView *lineThree;
@property (nonatomic,strong) UILabel *backPriceLabel;//退款金额

@end

static NSString *kOrderProducFirstCollectionCell = @"OrderProducFirstCollectionCell";

@implementation OrderProducFirstCell


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
    [self.contentView addSubview:self.backView];
    
    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:self.topView];
    
    self.leftLine = [UIView new];
    self.leftLine.backgroundColor = BACK_COLOR;
    [self.topView addSubview:self.leftLine];
    
    self.rightLine= [UIView new];
    self.rightLine.backgroundColor = BACK_COLOR;
    [self.topView addSubview:self.rightLine];
    
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.font = LPFFONT(14);
    self.shopNameLabel.textColor = TEXTGray_COLOR;
    [self.topView addSubview:self.shopNameLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.topView addSubview:self.lineView];
    
    //商品详情
    self.maintableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.maintableView registerClass:[OrderDetailFirstTableViewCell class] forCellReuseIdentifier:kOrderProducFirstDetailCell];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    self.maintableView.estimatedRowHeight = 100;
    self.maintableView.tableFooterView = [UIView new];
    self.maintableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.maintableView.scrollEnabled = NO;
    [self.backView addSubview:self.maintableView];
    
    self.aaView = [UIView new];
    self.aaView.backgroundColor = BACK_COLOR;
//    [self.backView addSubview:self.aaView];
    self.messageLabel = [UILabel new];
    self.messageLabel.text = @"共3件/1.12kg";
    self.messageLabel.font = LPFFONT(13);
    self.messageLabel.textColor = TEXTGray_COLOR;
//    [self.aaView addSubview:self.messageLabel];
    
    self.jiantouTwo = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_56")];
//    [aaView addSubview:self.jiantouTwo];
    
    self.priceNLabel = [UILabel new];
    self.priceNLabel.text = @"商品金额";
    self.priceNLabel.textColor = TEXTBlack_COLOR;
    self.priceNLabel.font = LPFFONT(14);
    [self.backView addSubview:self.priceNLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.text = @"￥32.3";
    self.priceLabel.textColor = TEXTBlack_COLOR;
    self.priceLabel.font = MFFONT(14);
    [self.backView addSubview:self.priceLabel];
    
    self.peisongNLabel = [UILabel new];
    self.peisongNLabel.text = @"配送费";
    self.peisongNLabel.textColor = TEXTBlack_COLOR;
    self.peisongNLabel.font = LPFFONT(14);
    [self.backView addSubview:self.peisongNLabel];
    
    self.wenhaoImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.wenhaoImageView setImage:IMAGECACHE(@"icon_57") forState:UIControlStateNormal];
    [self.wenhaoImageView addTarget:self action:@selector(wenhaoImageViewAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.wenhaoImageView];
    
    self.peisongLabel = [UILabel new];
    self.peisongLabel.text = @"￥7.3";
    self.peisongLabel.textColor = TEXTBlack_COLOR;
    self.peisongLabel.font = MFFONT(14);
    [self.backView addSubview:self.peisongLabel];
    
    
    self.youhuiNLabel = [UILabel new];
    self.youhuiNLabel.text = @"优惠卷";
    self.youhuiNLabel.textColor = TEXTBlack_COLOR;
    self.youhuiNLabel.font = LPFFONT(14);
    [self.backView addSubview:self.youhuiNLabel];
    
    self.youhuiLabel = [UILabel new];
    self.youhuiLabel.text = @"暂无优惠";
    self.youhuiLabel.textColor = TEXTGray_COLOR;
    self.youhuiLabel.font = MFFONT(14);
    [self.backView addSubview:self.youhuiLabel];
    
    //*******************************************************
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 180), 90);
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.mainCollectionView registerClass:[OrderProducFirstCollectionCell class] forCellWithReuseIdentifier:kOrderProducFirstCollectionCell];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    [self.mainCollectionView setShowsHorizontalScrollIndicator:NO];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.backView addSubview:self.mainCollectionView];
    
    //*******************************************************
    
    
    self.linetwoView = [UIView new];
    self.linetwoView.backgroundColor = BACK_COLOR;
    [self.backView addSubview:self.linetwoView];
    
    
//    self.priceoneLabel = [UILabel new];
//    self.priceoneLabel.text = @"应付￥39.8";
//    self.priceoneLabel.textColor = TEXTGray_COLOR;
//    self.priceoneLabel.font = MFFONT(14);
//    [self.backView addSubview:self.priceoneLabel];
    
    self.pricetwoLabel = [UILabel new];
    self.pricetwoLabel.text = @"—优惠￥39.8";
    self.pricetwoLabel.textColor = TEXTGray_COLOR;
    self.pricetwoLabel.font = MFFONT(14);
    [self.backView addSubview:self.pricetwoLabel];
    
    self.pricethreeLabel = [UILabel new];
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥24.8"]];
    [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(3, titleString.length - 3)];
    [self.pricethreeLabel setAttributedText:titleString];
    self.pricethreeLabel.font = MFFONT(14);
    [self.backView addSubview:self.pricethreeLabel];
    
}

- (void)setupLayout{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.bottom.right.left.offset = 0;
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset = 0;
        make.height.offset = 40;
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.centerY.offset = 0;
    }];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.height.offset = 0.5;
        make.width.offset = 40;
        make.right.equalTo(self.shopNameLabel.mas_left).offset = -10;
    }];
    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.height.offset = 0.5;
        make.width.offset = 40;
        make.left.equalTo(self.shopNameLabel.mas_right).offset = 10;
    }];

    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.offset = 0.5;
        make.bottom.offset = 0;
    }];
    
    [self.maintableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.equalTo(self.topView.mas_bottom).offset = 0;
        make.height.offset = 160;
    }];
    
//    [self.aaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset = 30;
//        make.right.offset = -30;
//        make.height.offset = 30;
//        make.top.equalTo(self.maintableView.mas_bottom).offset = 0;
//    }];
//
//    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset = 0;
//        make.centerX.offset = -5;
//    }];
//
//    [self.jiantouTwo mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.offset = 0;
//        make.left.equalTo(self.messageLabel.mas_right).offset = 5;
//    }];
    
    [self.priceNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.maintableView.mas_bottom).offset = 30;
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceNLabel.mas_centerY);
        make.right.offset = -10;
    }];
    
    [self.peisongNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.priceNLabel.mas_bottom).offset = 20;
        
    }];
    [self.wenhaoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.peisongNLabel.mas_centerY);
        make.left.equalTo(self.peisongNLabel.mas_right).offset = 10;
    }];
    
    [self.peisongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.peisongNLabel.mas_centerY);
        make.right.offset = -10;
    }];
    
    [self.youhuiNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.peisongNLabel.mas_bottom).offset = 20;
    }];
    
    [self.youhuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.youhuiNLabel.mas_centerY);
        make.right.offset = -10;
    }];
    
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 90;
        make.top.equalTo(self.youhuiLabel.mas_bottom).offset = 10;
    }];
    
    
    [self.linetwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 1;
        make.top.equalTo(self.mainCollectionView.mas_bottom).offset = 20;
    }];
    
//    [self.priceoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset = 10;
//        make.top.equalTo(self.linetwoView.mas_bottom).offset = 20;
//        make.bottom.equalTo(self.contentView.mas_bottom).offset = -20;
//    }];
    [self.pricethreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.top.equalTo(self.linetwoView.mas_bottom).offset = 20;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -20;
    }];

    [self.pricetwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pricethreeLabel.mas_left).offset = -15;
        make.centerY.equalTo(self.pricethreeLabel);
    }];
}

#pragma mark -tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.order.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderProducFirstDetailCell];
        OrderProducOrderDetailModel *model = self.model.order.data[indexPath.row];
        cell.makeOrderModel = model;
    return cell;
}


- (void)pushToShopController{
    ShopController *shop = [ShopController new];
    [self.navigationController pushViewController:shop animated:YES];
}

#pragma mark-设置数据
- (void)setModel:(OrderProducModel *)model{
    _model = model;
    self.shopNameLabel.text = model.shop.shopName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",model.order.num_num_price];
    self.peisongLabel.text = [NSString stringWithFormat:@"%@",model.carriage];
    
    self.pricetwoLabel.text = [NSString stringWithFormat:@"已优惠￥0"];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥%@",self.model.price]];
    [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(3, titleString.length - 3)];
    [self.pricethreeLabel setAttributedText:titleString];

    [self.maintableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = model.order.data.count * 80;
    }];
    [self.mainCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.model.coupon.count) {
            make.height.offset = 90;
        }else{
            make.height.offset = 0;
        }
    }];
    [self.maintableView reloadData];
    [self.mainCollectionView reloadData];
}


#pragma mark- UICollectionViewDatasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OrderProducFirstCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kOrderProducFirstCollectionCell forIndexPath:indexPath];
    cell.model = self.model.coupon[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.coupon.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //遍历优惠卷 只能选一个
    OrderProducCouponModel *a = self.model.coupon[indexPath.row];
    for (OrderProducCouponModel *amodel in self.model.coupon) {
        if ([amodel.couponId isEqualToString:a.couponId]) {
            //判断能否使用
            if ([amodel.couponType integerValue] == 1) {//满减优惠
                if ([self.model.order.num_num_price floatValue] >= [amodel.spendMoney floatValue]) {
                    amodel.isSelect = !amodel.isSelect;
                }else{
                    [MBHUDHelper showError:@"使用此优惠卷条件不足"];
                    amodel.isSelect = NO;
                }
            }else{//折扣卷
                if ([self.model.order.num_num_price floatValue] <= [amodel.spendMoney floatValue] && [self.model.order.num_num_price floatValue] >= [amodel.couponMoney floatValue]) {
                    amodel.isSelect = !amodel.isSelect;
                }else{
                    [MBHUDHelper showError:@"使用此优惠卷条件不足"];
                    amodel.isSelect = NO;
                }
            }
        }else{
            amodel.isSelect = NO;
        }
    }
    [self.mainCollectionView reloadData];
    for (OrderProducCouponModel *bmodel in self.model.coupon) {
        if (bmodel.isSelect) {//计算优惠价值
            //1.满减卷
            self.youhuiLabel.textColor = [UIColor redColor];
            NSString *youhuiMoneyu = @"";
            
            if ([bmodel.couponType integerValue] == 1) {//满减优惠
                youhuiMoneyu = bmodel.couponMoney;
                
            }else{            //2.只扣卷
                CGFloat cc = 1 - [bmodel.discountRate floatValue];
                youhuiMoneyu = [NSString stringWithFormat:@"%.2f",(cc * [self.model.order.num_num_price floatValue])];
            }
            
            NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"-￥%@元",youhuiMoneyu]];
            [titleString addAttribute:NSFontAttributeName value:LPFFONT(15) range:NSMakeRange(2, titleString.length - 2)];
            [self.youhuiLabel setAttributedText:titleString];
            
            //从新计算数值
            //1.优惠多少钱
            self.pricetwoLabel.text = [NSString stringWithFormat:@"已优惠￥%@",youhuiMoneyu];
            //2.应付多少钱
            CGFloat totalPrice = [self.model.price floatValue] - [youhuiMoneyu floatValue];
            NSMutableAttributedString *reltotalPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥%.2f",totalPrice]];
            [reltotalPrice addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(3, reltotalPrice.length - 3)];
            [self.pricethreeLabel setAttributedText:reltotalPrice];
            if (self.updataTotalMoneyBlock) {
                self.updataTotalMoneyBlock([NSString stringWithFormat:@"%.2f",totalPrice], youhuiMoneyu,bmodel.CId);
            }
            return;
        }
        self.youhuiLabel.text = @"暂无优惠";
        self.youhuiLabel.textColor = TEXTGray_COLOR;
        self.pricetwoLabel.text = [NSString stringWithFormat:@"已优惠￥0"];
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥%@",self.model.price]];
        [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(3, titleString.length - 3)];
        [self.pricethreeLabel setAttributedText:titleString];
        if (self.updataTotalMoneyBlock) {
            self.updataTotalMoneyBlock(@"", @"",@"");
        }
    }
}


- (void)wenhaoImageViewAction{
    PeisongAlertView *aa = [[PeisongAlertView alloc] initGetuiWithTitle:@"配送费说明" orderProducModel:self.model];
    [aa  show];
}

@end
