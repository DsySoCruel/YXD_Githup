//
//  PayViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/2.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "PayViewController.h"
#import "PayViewModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "WXApi.h"
#import "WeiXinInfoModel.h"

@interface PayViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@property (nonatomic,strong) UIView *firstOneView;
@property (nonatomic,strong) UIImageView *oneIconImageView;
@property (nonatomic,strong) UILabel *oneLabel;
@property (nonatomic,strong) UILabel *one0neLabel;
@property (nonatomic,strong) UIImageView *oneImageView;
@property (nonatomic,strong) UIView *firstTwoView;
@property (nonatomic,strong) UIImageView *twoIconImageView;
@property (nonatomic,strong) UILabel *twoLabel;
@property (nonatomic,strong) UILabel *twotwoLabel;
@property (nonatomic,strong) UIImageView *twoImageView;
@property (nonatomic,strong) UIView *firstThreeView;
@property (nonatomic,strong) UIImageView *threeIconImageView;
@property (nonatomic,strong) UILabel *threeLabel;
@property (nonatomic,strong) UILabel *threethreeLabel;
@property (nonatomic,strong) UIImageView *threeImageView;

@property (nonatomic,strong) PayViewModel *model;
@property (nonatomic,strong) UIButton *commintButton;//支付按钮-立即支付

@end

@implementation PayViewController

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    self.navigationController.delegate = self;
    
    [self setupUI];
    [self setupLayout];
    [self loadData];
    
    //注册支付宝回调通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:@"PayResult" object:nil];
}

- (void)setupUI{
    //1.设置头部
    self.topView = [UIView new];
    self.topView.backgroundColor = THEME_COLOR;
    [self.view addSubview:self.topView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:IMAGECACHE(@"icon_33") forState:UIControlStateNormal];
    self.backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.backButton];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"支付收银台";
    self.titleLabel.font = MFFONT(17);
    [self.topView addSubview:self.titleLabel];
    
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.textColor = [UIColor whiteColor];
    self.shopNameLabel.font = LPFFONT(17);
    self.shopNameLabel.numberOfLines = 2;
    [self.topView addSubview:self.shopNameLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textColor = [UIColor whiteColor];
    self.priceLabel.font = LPFFONT(15);
    [self.topView addSubview:self.priceLabel];
    
    
    //微信支付
    self.firstOneView = [UIView new];
    self.firstOneView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstOneView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstOneViewAction)];
    [self.firstOneView addGestureRecognizer:tap1];
    
    self.oneIconImageView  = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_59")];
    [self.firstOneView addSubview:self.oneIconImageView];
    
    self.oneLabel = [UILabel new];
    self.oneLabel.textColor = TEXTBlack_COLOR;
    self.oneLabel.font = LPFFONT(15);
    self.oneLabel.text = @"微信支付";
    [self.firstOneView addSubview:self.oneLabel];
    
    self.one0neLabel = [UILabel new];
    self.one0neLabel.textColor = TEXTGray_COLOR;
    self.one0neLabel.font = LPFFONT(12);
    self.one0neLabel.text = @"推荐使用最新版本支付";
    [self.firstOneView addSubview:self.one0neLabel];
    
    self.oneImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_62")];
    [self.firstOneView addSubview:self.oneImageView];
    
    
    //支付宝支付
    self.firstTwoView = [UIView new];
    self.firstTwoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstTwoView];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTwoViewAction)];
    [self.firstTwoView addGestureRecognizer:tap2];
    
    
    self.twoIconImageView  = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_60")];
    [self.firstTwoView addSubview:self.twoIconImageView];

    self.twoLabel = [UILabel new];
    self.twoLabel.textColor = TEXTBlack_COLOR;
    self.twoLabel.font = LPFFONT(15);
    self.twoLabel.text = @"支付宝支付";
    [self.firstTwoView addSubview:self.twoLabel];
    
    self.twotwoLabel = [UILabel new];
    self.twotwoLabel.textColor = TEXTGray_COLOR;
    self.twotwoLabel.font = LPFFONT(12);
    self.twotwoLabel.text = @"推荐使用最新版本支付";
    [self.firstTwoView addSubview:self.twotwoLabel];
    
    self.twoImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_62")];
    [self.firstTwoView addSubview:self.twoImageView];
    self.twoImageView.hidden = YES;

    
//    余额支付
    self.firstThreeView = [UIView new];
    self.firstThreeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstThreeView];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstThreeViewAction)];
    [self.firstThreeView addGestureRecognizer:tap3];
    
    
    self.threeIconImageView  = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_61")];
    [self.firstThreeView addSubview:self.threeIconImageView];
    
    self.threeLabel = [UILabel new];
    self.threeLabel.textColor = TEXTBlack_COLOR;
    self.threeLabel.font = LPFFONT(15);
    self.threeLabel.text = @"余额支付";
    [self.firstThreeView addSubview:self.threeLabel];
    
    self.threethreeLabel = [UILabel new];
    self.threethreeLabel.textColor = TEXTGray_COLOR;
    self.threethreeLabel.font = LPFFONT(12);
    [self.firstThreeView addSubview:self.threethreeLabel];
    
    self.threeImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_62")];
    [self.firstThreeView addSubview:self.threeImageView];
    self.threeImageView.hidden = YES;
    
    
    self.commintButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.commintButton setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.commintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.commintButton.backgroundColor = THEME_COLOR;
    self.commintButton.layer.cornerRadius = 5;
    [self.commintButton addTarget:self action:@selector(commintAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.commintButton];
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
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.equalTo(self.titleLabel.mas_bottom).offset = 20;
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.equalTo(self.shopNameLabel.mas_bottom).offset = 20;
    }];
    
    [self.firstOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.height.offset = 70;
        make.width.offset = YXDScreenW;
        make.top.equalTo(self.topView.mas_bottom).offset = 10;
    }];
    
    [self.oneIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.offset = 20;
        make.width.height.offset = 50;
    }];
    
    [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneIconImageView.mas_right).offset = 20;
        make.top.offset = 10;
    }];
    [self.one0neLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneIconImageView.mas_right).offset = 20;
        make.bottom.offset = -10;
    }];
    
    [self.oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -15;
    }];
    
    [self.firstTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.height.offset = 70;
        make.width.offset = YXDScreenW;
        make.top.equalTo(self.firstOneView.mas_bottom).offset = 1;
    }];
    
    [self.twoIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.offset = 20;
        make.width.height.offset = 50;
    }];

    [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoIconImageView.mas_right).offset = 20;
        make.top.offset = 10;
    }];
    [self.twotwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoIconImageView.mas_right).offset = 20;
        make.bottom.offset = -10;
    }];
    [self.twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -15;
    }];
    
    
    [self.firstThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.height.offset = 70;
        make.width.offset = YXDScreenW;
        make.top.equalTo(self.firstTwoView.mas_bottom).offset = 1;
    }];
    
    [self.threeIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.left.offset = 20;
        make.width.height.offset = 50;
    }];
    
    [self.threeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeIconImageView.mas_right).offset = 20;
        make.top.offset = 10;
    }];
    [self.threethreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeIconImageView.mas_right).offset = 20;
        make.bottom.offset = -10;
    }];
    [self.threeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -15;
    }];
    
    [self.commintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.right.offset = -15;
        make.height.offset = 35;
        make.top.equalTo(self.firstThreeView.mas_bottom).offset = 60;
    }];
    
}

- (void)firstOneViewAction{
    self.twoImageView.hidden = YES;
    self.threeImageView.hidden = YES;
    self.oneImageView.hidden = NO;
}

- (void)firstTwoViewAction{
    self.twoImageView.hidden = NO;
    self.threeImageView.hidden = YES;
    self.oneImageView.hidden = YES;
}
- (void)firstThreeViewAction{
    self.twoImageView.hidden = YES;
    self.oneImageView.hidden = YES;
    self.threeImageView.hidden = NO;

}


- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.orderId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toPay parameters:parames successed:^(id json) {
        if (json) {
            Weakself.model = [PayViewModel mj_objectWithKeyValues:json];
            Weakself.shopNameLabel.text =  Weakself.model.orderInfo.shopName;
            NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",Weakself.model.orderInfo.realTotalMoney]];
            [titleString addAttribute:NSFontAttributeName value:LPFFONT(26) range:NSMakeRange(1, titleString.length-1)];
            [Weakself.priceLabel setAttributedText:titleString];
            self.threethreeLabel.text = [NSString stringWithFormat:@"账户余额：￥%@",Weakself.model.userMoney];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)commintAction:(UIButton *)sender{
    //判断是什么支付方式
    //1.余额支付
    if (!self.threeImageView.hidden) {
        if ([self.model.orderInfo.realTotalMoney floatValue] > [self.model.userMoney floatValue]) {
            [MBHUDHelper showError:@"余额不足,请更换支付方式"];
            return;
        }
        
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        parames[@"orderId"] = self.orderId;
        parames[@"payType"] = @"3";
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_toPayNotify parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"支付成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [Weakself.navigationController popToRootViewControllerAnimated:YES];
                });
            }
        } failure:^(NSError *error) {
            
        }];
    }
    //支付宝支付
    if (!self.twoImageView.hidden) {
        //获取加签后的信息（从自己的服务器获取）
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        parames[@"orderId"] = self.orderId;
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_getAliCallInfo parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"获取支付信息成功"];
                [[AlipaySDK defaultService] payOrder:json fromScheme:@"com.cloudShop.maidianer" callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);//没有安装支付宝的时候回调  ps:有支付宝app回调在appdelegate中  利用通知刷新界面
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [Weakself.navigationController popToRootViewControllerAnimated:YES];
                    });
                }];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
    //微信支付
    if (!self.oneImageView.hidden) {
        
        //获取加签后的信息（从自己的服务器获取）
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        parames[@"orderId"] = self.orderId;
//        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_getWxCallInfo parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"获取支付信息成功"];
                WeiXinInfoModel *model = [WeiXinInfoModel mj_objectWithKeyValues:json];
                
                PayReq *request = [[PayReq alloc] init];
                
                request.partnerId = model.partnerid;//微信支付分配的商户号
                
                request.prepayId = model.prepayid;//微信返回的支付交易会话ID
                
                request.package = model.package;//暂填写固定值Sign=WXPay
                
                request.nonceStr = model.noncestr;//随机字符串，不长于32位。推荐随机数生成算法
                
                request.timeStamp = [model.timestamp integerValue];//时间戳，请见接口规则-参数规定
                
                request.sign= model.sign;//签名，详见签名生成算法注意：签名方式一定要与统一下单接口使用的一致
                
                [WXApi sendReq:request];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

//支付回调通知（支付宝）
- (void)InfoNotificationAction:(NSNotification *)notification{
    if ([notification.object isEqualToString:@"ali_success"]) {//支付成功
        [MBHUDHelper showSuccess:@"支付成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    }else{
        [MBHUDHelper showSuccess:@"支付失败"];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
