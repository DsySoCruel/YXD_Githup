//
//  OrderDetailFirstCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderDetailFirstCell.h"
#import "ShopController.h"
#import "OrderDetailFirstTableViewCell.h"
#import "OrderDetailControllerModel.h"
#import "PeisongAlertView.h"
#import "OrderProducModel.h"

static NSString *kOrderDetailFirstTableViewCell = @"kOrderDetailFirstTableViewCell";

@interface OrderDetailFirstCell()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIButton *shopNameButton;
@property (nonatomic,strong) UIImageView *jiantouImage;
@property (nonatomic,strong) UILabel *stateLabel;//订单状态：待接单 配送中 已完成 退款成功
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *dataArray;

//商品详情
@property (nonatomic,strong) UITableView *maintableView;
@property (nonatomic,strong) UIView *aaView;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UIImageView *jiantouTwo;

//配送信息
@property (nonatomic,strong) UILabel *priceNLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *peisongNLabel;
@property (nonatomic,strong) UILabel *peisongLabel;
@property (nonatomic,strong) UIButton *wenhaoImageView;
@property (nonatomic,strong) UILabel *youhuiNLabel;
@property (nonatomic,strong) UILabel *youhuiLabel;

@property (nonatomic,strong) UIView *linetwoView;

@property (nonatomic,strong) UILabel *priceoneLabel;
@property (nonatomic,strong) UILabel *pricetwoLabel;
@property (nonatomic,strong) UILabel *pricethreeLabel;

@property (nonatomic,strong) UIView *lineThree;
@property (nonatomic,strong) UILabel *backPriceLabel;//退款金额

@end


@implementation OrderDetailFirstCell


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

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
    
    self.shopNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shopNameButton.titleLabel.font = LPFFONT(14);
    [self.shopNameButton setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    [self.shopNameButton setTitle:@"古城生鲜-直营店" forState:UIControlStateNormal];
    [self.backView addSubview:self.shopNameButton];
    [self.shopNameButton addTarget:self action:@selector(pushToShopController) forControlEvents:UIControlEventTouchUpInside];
    
    self.jiantouImage = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_55")];
    [self.backView addSubview:self.jiantouImage];
    
    self.stateLabel = [UILabel new];
    self.stateLabel.text = @"待接单";
    self.stateLabel.font = LPFFONT(14);
    self.stateLabel.textColor = [UIColor redColor];
    [self.backView addSubview:self.stateLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.backView addSubview:self.lineView];
    
    //商品详情
    self.maintableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.maintableView registerClass:[OrderDetailFirstTableViewCell class] forCellReuseIdentifier:kOrderDetailFirstTableViewCell];
    self.maintableView.delegate = self;
    self.maintableView.dataSource = self;
    self.maintableView.estimatedRowHeight = 100;
    self.maintableView.tableFooterView = [UIView new];
    self.maintableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.maintableView.scrollEnabled = NO;
    [self.backView addSubview:self.maintableView];
    
    self.aaView = [UIView new];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
    [self.aaView addGestureRecognizer:tap1];
    self.aaView.backgroundColor = BACK_COLOR;
    [self.backView addSubview:self.aaView];
    self.messageLabel = [UILabel new];
    self.messageLabel.text = @"共3件/1.12kg";
    self.messageLabel.font = LPFFONT(13);
    self.messageLabel.textColor = TEXTGray_COLOR;
    [self.aaView addSubview:self.messageLabel];
    
    self.jiantouTwo = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_56")];
    [self.aaView addSubview:self.jiantouTwo];
    
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
    self.youhuiLabel.text = @"￥7.3";
    self.youhuiLabel.textColor = TEXTBlack_COLOR;
    self.youhuiLabel.font = MFFONT(14);
    [self.backView addSubview:self.youhuiLabel];

    self.linetwoView = [UIView new];
    self.linetwoView.backgroundColor = BACK_COLOR;
    [self.backView addSubview:self.linetwoView];
    
    
    self.priceoneLabel = [UILabel new];
    self.priceoneLabel.text = @"应付￥39.8";
    self.priceoneLabel.textColor = TEXTGray_COLOR;
    self.priceoneLabel.font = MFFONT(14);
    [self.backView addSubview:self.priceoneLabel];
    
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
        make.top.offset = 10;
        make.bottom.right.left.offset = 0;
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
    
    [self.maintableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.top.equalTo(self.lineView.mas_bottom).offset = 0;
        make.height.offset = 160;
    }];
    
    [self.aaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 30;
        make.right.offset = -30;
        make.height.offset = 30;
        make.top.equalTo(self.maintableView.mas_bottom).offset = 0;
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.centerX.offset = -5;
    }];
    
    [self.jiantouTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.equalTo(self.messageLabel.mas_right).offset = 5;
    }];
    
    [self.priceNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.aaView.mas_bottom).offset = 30;
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
    
    [self.linetwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 1;
        make.top.equalTo(self.youhuiNLabel.mas_bottom).offset = 20;
    }];
    
    [self.priceoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.linetwoView.mas_bottom).offset = 20;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -20;
    }];
    [self.pricetwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceoneLabel.mas_right);
        make.centerY.equalTo(self.priceoneLabel);
    }];
    [self.pricethreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.centerY.equalTo(self.priceoneLabel);
    }];
}

#pragma mark -tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isNeedPresentAll) {
        return self.dataArray.count;
    }
    return self.dataArray.count <= 2 ? self.dataArray.count : 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderDetailFirstTableViewCell];
    GoodsListDetailGoodModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)pushToShopController{
    ShopController *shop = [ShopController new];
    shop.shopId = self.model.order.shopId;
    [self.navigationController pushViewController:shop animated:YES];
}


- (void)setModel:(OrderDetailControllerModel *)model{
    _model = model;
    [self.shopNameButton setTitle:model.order.shopName forState:UIControlStateNormal];
    
    //    orderStatus = 0或1或2表示待接单
    //    orderStatus = 3   表示配送中  正常配送 下方确认按钮
    //    orderStatus = -5   表示配送中 配送中 用户提出取消订单 商家不同意 下方确认按钮
    //    orderStatus = 5   表示配送中   表示当前订单指派配送员 待配送员确认订单
    //    orderstauus = 6   表示配送中
    //    orderStatus = 4   表示已完成
    //    orderStatus < 0   表示退款
    
    if ([model.order.orderStatus integerValue] == 0 ||[model.order.orderStatus integerValue] == 1 || [model.order.orderStatus integerValue] == 2 ) {
        self.stateLabel.textColor = [UIColor redColor];
    }else if ([model.order.orderStatus integerValue] == 3 ||[model.order.orderStatus integerValue] == -5 || [model.order.orderStatus integerValue] == 5 ||[model.order.orderStatus integerValue] == 6){
        self.stateLabel.textColor = THEME_COLOR;
    }else if ([model.order.orderStatus integerValue] == 4){
        self.stateLabel.textColor = TEXTGray_COLOR;
    }else{
        self.stateLabel.textColor = TEXTGray_COLOR;
    }
    self.stateLabel.text = model.order.status_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.order.totalMoney];
    self.peisongLabel.text = [NSString stringWithFormat:@"￥%@",model.order.deliverMoney];
    self.youhuiLabel.text = [NSString stringWithFormat:@"￥%@",model.order.couponMoney];
    self.priceoneLabel.text = [NSString stringWithFormat:@"应付￥%.2f",([model.order.totalMoney floatValue] +         [model.order.deliverMoney floatValue])];
    self.pricetwoLabel.text = [NSString stringWithFormat:@"—优惠￥%@",model.order.couponMoney];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付:￥%@",model.order.realTotalMoney]];
    [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(3, titleString.length - 3)];
    [self.pricethreeLabel setAttributedText:titleString];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:model.goodsList];
    

    //如果 self.dataArray.count > 2 开启折叠效果
    if (self.isNeedPresentAll) {
        [self.maintableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = self.dataArray.count * 80;
        }];
        [self.aaView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 30;
        }];
        self.aaView.hidden = NO;
        self.jiantouTwo.image = IMAGECACHE(@"icon_67");

    }else{
        [self.maintableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = self.dataArray.count <= 2 ? self.dataArray.count * 80 : 2 *80;
        }];
        if (self.dataArray.count <= 2) {
            [self.aaView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 0;
            }];
            self.aaView.hidden = YES;
        }else{
            [self.aaView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset = 30;
            }];
            self.aaView.hidden = NO;
            self.messageLabel.text = [NSString stringWithFormat:@"共%tu件",self.dataArray.count];
            self.jiantouTwo.image = IMAGECACHE(@"icon_56");
        }
    }
    [self.maintableView reloadData];
}

- (void)adView1Action{
    //刷新列表
    self.isNeedPresentAll = !self.isNeedPresentAll;
    if (self.isNeedPresentAllBlock) {
        self.isNeedPresentAllBlock(self.isNeedPresentAll);
    }
}

- (void)wenhaoImageViewAction{
    
    OrderProducModel *model = [OrderProducModel new];
    model.transDistance = self.model.order.transDistance;
    model.transRadius = self.model.order.transRadius;
    model.transOutRange = self.model.order.transOutRange;
    model.transInRange = self.model.order.transInRange;
    model.carriage = self.model.order.deliverMoney;
    PeisongAlertView *aa = [[PeisongAlertView alloc] initGetuiWithTitle:@"配送费说明" orderProducModel:model];
    [aa  show];
}


@end
