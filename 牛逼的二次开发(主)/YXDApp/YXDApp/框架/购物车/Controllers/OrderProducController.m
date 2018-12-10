//
//  OrderProducController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/24.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderProducController.h"
#import "OrderProducFirstCell.h"
#import "MyAddressController.h"
#import "MyAddressModel.h"
#import "DateTimePickerView.h"
#import "PayViewController.h"


static NSString *kOrderProducFirstCell = @"OrderProducFirstCell";

@interface OrderProducController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,DateTimePickerViewDelegate>

@property (nonatomic,strong) UIView *topView;//地址view
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UIImageView *dituImageView;
@property (nonatomic,strong) UILabel *oneLabel;
@property (nonatomic,strong) UILabel *twoLabel;
@property (nonatomic,strong) UIImageView *jiantouOneImage;


@property (nonatomic,strong) UIView *middleView;//配送信息view
@property (nonatomic,strong) UILabel *sendType;//谁送方式
@property (nonatomic,strong) UILabel *needTimeLabel;//配送时间
@property (nonatomic,strong) UIImageView *jiantouTwoImage;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *commintButton;

//存储数据
@property (nonatomic,strong) NSString *totalMoney;//优惠后价格
@property (nonatomic,strong) NSString *couponMoney;//优惠价格
@property (nonatomic,strong) NSString *couponId;//优惠卷Id
@property (nonatomic,strong) NSString *deliveryTime;//配送时间
@property (nonatomic,strong) NSString *addressId;

@end

@implementation OrderProducController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
//    self.navigationController.delegate = self;
    
    [self setupUI];
    [self setupLayout];
    
}
- (void)setupUI{
    self.couponMoney = @"";
    self.totalMoney = @"";
    self.addressId = @"";
    //获取当前时间
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];[formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    self.deliveryTime = dateTime;
    
    //1.设置头部
    self.topView = [UIView new];
    self.topView.backgroundColor = THEME_COLOR;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topViewAction)];
    [self.topView addGestureRecognizer:tap1];
    [self.view addSubview:self.topView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:IMAGECACHE(@"icon_33") forState:UIControlStateNormal];
    self.backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.backButton];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"订单配送至";
    self.titleLabel.font = MFFONT(15);
    [self.topView addSubview:self.titleLabel];
    
    self.dituImageView = [UIImageView new];
    self.dituImageView.image = IMAGECACHE(@"icon_21");
    [self.topView addSubview:self.dituImageView];
    
    self.oneLabel = [UILabel new];
    self.oneLabel.textColor = [UIColor whiteColor];
    self.oneLabel.font = LPFFONT(15);
    self.oneLabel.numberOfLines = 2;
    self.oneLabel.text = [NSString stringWithFormat:@"%@ %@",self.model.address.xiaoqu,self.model.address.address];
    [self.topView addSubview:self.oneLabel];

    self.twoLabel = [UILabel new];
    self.twoLabel.textColor = [UIColor whiteColor];
    self.twoLabel.font = LPFFONT(14);
    self.twoLabel.text = [NSString stringWithFormat:@"%@ %@",self.model.address.userName,self.model.address.userPhone];
    [self.topView addSubview:self.twoLabel];
    
    self.jiantouOneImage = [UIImageView new];
    self.jiantouOneImage.image = IMAGECACHE(@"icon_54");
    [self.topView addSubview:self.jiantouOneImage];
    
    self.middleView = [UIView new];
    self.middleView.layer.cornerRadius = 5;
    self.middleView.layer.masksToBounds = YES;
    self.middleView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(middleViewAction)];
    [self.middleView addGestureRecognizer:tap2];
    [self.view addSubview:self.middleView];
    
    
    self.sendType = [UILabel new];
    self.sendType.textColor = [UIColor whiteColor];
    self.sendType.font = LPFFONT(11);
    self.sendType.backgroundColor = THEME_COLOR;
    self.sendType.layer.cornerRadius = 5;
    self.sendType.textAlignment = NSTextAlignmentCenter;
    self.sendType.text = [self.model.shop.deliveryType integerValue] == 1 ? @"平台配送" : @"商家配送";
    [self.middleView addSubview:self.sendType];
    
    self.needTimeLabel = [UILabel new];
    self.needTimeLabel.textColor = TEXTGray_COLOR;
    self.needTimeLabel.font = LPFFONT(14);
    self.needTimeLabel.text = [NSString stringWithFormat:@"立即配送 [%@]",self.deliveryTime];
    [self.middleView addSubview:self.needTimeLabel];
    
    self.jiantouTwoImage = [UIImageView new];
    self.jiantouTwoImage.image = IMAGECACHE(@"icon_55");
    [self.middleView addSubview:self.jiantouTwoImage];
    
    //设置tableVeiw
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[OrderProducFirstCell class] forCellReuseIdentifier:kOrderProducFirstCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.layer.cornerRadius = 5;
    self.tableView.layer.masksToBounds = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, 0, 150);
    footerView.backgroundColor = BACK_COLOR;
    self.commintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commintButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.commintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commintButton.backgroundColor = THEME_COLOR;
    self.commintButton.layer.cornerRadius = 5;
    [self.commintButton addTarget:self action:@selector(commintAction:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:self.commintButton];
    [self.commintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 35;
        make.top.offset = 50;
    }];
    self.tableView.tableFooterView = footerView;
    [self.view addSubview:self.tableView];

    
}
- (void)setupLayout{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset = 0;
        make.height.offset = 170;
    }];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = 20;
        make.height.offset = 44;
        make.width.offset = 50;
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 30;
    }];
    
    [self.dituImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.offset = 0;
        make.width.offset = 10;
        make.height.offset = 15;
    }];
    
    [self.jiantouOneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.offset = 0;
        make.width.offset = 7;
        make.height.offset = 14;
    }];
    
    [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.equalTo(self.dituImageView.mas_right).offset = 10;
        make.right.equalTo(self.jiantouOneImage.mas_left).offset = -10;
    }];
    [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLabel);
        make.right.equalTo(self.jiantouOneImage);
        make.top.equalTo(self.oneLabel.mas_bottom).offset = 10;
    }];
    
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.offset = 60;
        make.top.equalTo(self.topView.mas_bottom).offset = -30;
    }];
    
    [self.sendType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.offset = 0;
        make.width.offset = 50;
        make.height.offset = 20;
    }];
    
    [self.jiantouTwoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.centerY.offset = 0;
    }];
    [self.needTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.equalTo(self.jiantouTwoImage.mas_left).offset = -10;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset = 10;
        make.right.offset = -10;
        make.left.offset = 10;
        make.bottom.offset = 0;
    }];
}

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderProducFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:kOrderProducFirstCell];
    cell.model = self.model;
    WeakObj(self);
    cell.updataTotalMoneyBlock = ^(NSString *totalMoney, NSString *couponMoney, NSString *couponId) {
        Weakself.totalMoney = totalMoney;
        Weakself.couponMoney = couponMoney;
        Weakself.couponId = couponId;
    };
    return cell;
}


- (void)topViewAction{
    MyAddressController *vc = [MyAddressController new];
    vc.isNeedSelect  = YES;
    WeakObj(self);
    vc.selectAddressBlock = ^(MyAddressModel *addressModel) {
        Weakself.oneLabel.text = [NSString stringWithFormat:@"%@ %@",addressModel.areaName1,addressModel.address];
        Weakself.twoLabel.text = [NSString stringWithFormat:@"%@ %@",addressModel.userName,addressModel.userPhone];
        Weakself.addressId = addressModel.addressId;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)middleViewAction{
    
    DateTimePickerView *pickerView = [[DateTimePickerView alloc] init];
    pickerView.delegate = self;
    pickerView.pickerViewMode = DatePickerViewDateTimeMode;
    [self.view addSubview:pickerView];
    [pickerView showDateTimePickerView];

}

- (void)didClickFinishDateTimePickerView:(NSString *)date{
    self.deliveryTime = date;
    self.needTimeLabel.text = [NSString stringWithFormat:@"立即配送 [%@]",self.deliveryTime];

}

#pragma mark-生成订单

- (void)commintAction:(UIButton *)sender{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"addressId"] = self.addressId.length ? self.addressId : self.model.address.addressId;//收货地址Id ???
    parames[@"preMoney"] = self.model.order.num_num_price;//优惠前价格
    parames[@"deliveryMoney"] = self.model.carriage;//配送费
    parames[@"shopId"] = self.shopId;//店铺ID
    parames[@"deliveryTime"] = self.deliveryTime;//配送时间(Y-m-d H:i格式)
    
    if (self.couponMoney.length) {
        parames[@"totalMoney"] = self.totalMoney;//优惠后价格
        parames[@"couponMoney"] = self.couponMoney;//优惠价格
        parames[@"couponsid"] = self.couponId;;//优惠卷主id
    }else{
        parames[@"totalMoney"] = self.model.price;//优惠后价格
        parames[@"couponMoney"] = @"0";//优惠价格
    }
    
    parames[@"ids"] = self.model.ids;//订单具体信息(例如260:2,264:2,259:2,263:2)
    parames[@"deliveryType"] = self.model.shop.deliveryType;//商家配送或平台配送 0商家 1平台  我有的选吗？？？？
    parames[@"transCondition"] = self.model.transCondition;//配送条件 0正常配送  1特殊配送
    parames[@"transRadius"] = self.model.transRadius;//配送半径
    parames[@"transInRange"] = self.model.transInRange;//配送距离内价格
    parames[@"transOutRange"] = self.model.transOutRange;//超出配送单价
    parames[@"transDistance"] = self.model.transDistance;//配送距离
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toMakeOrder parameters:parames successed:^(id json) {
        if (json) {
            PayViewController *vc = [PayViewController new];
            vc.orderId = json;
            [Weakself.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
