//
//  ShopControllerView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/4.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopControllerView.h"
#import "ShopHeadViewModel.h"

@interface ShopControllerView()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *likeButton;

@property (nonatomic,strong) UIImageView *heardImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *xiajianImageView;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *yunfeiLabel;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UIImageView *jianjianImageView;
@property (nonatomic,strong) UILabel *activeLabel;
@property (nonatomic,strong) UIImageView *youjianImageView;


@end

@implementation ShopControllerView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"backImageView_00")];
//    self.backImageView = [[UIImageView alloc] init];

    [self addSubview:self.backImageView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:IMAGECACHE(@"icon_33") forState:UIControlStateNormal];
    self.backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];

    self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.likeButton setImage:IMAGECACHE(@"icon_34") forState:UIControlStateNormal];
    [self.likeButton setImage:IMAGECACHE(@"mine_guanzhu") forState:UIControlStateSelected];
    self.likeButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.likeButton addTarget:self action:@selector(likeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.likeButton];

    
    
    self.heardImageView = [[UIImageView alloc] init];
//    self.heardImageView.layer.cornerRadius = 25;
    self.heardImageView.layer.masksToBounds = YES;
    [self addSubview:self.heardImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.text = @"沃尔玛—花园路店";
    self.nameLabel.font = BPFFONT(17);
    self.nameLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    
    self.xiajianImageView = [UIImageView new];
    self.xiajianImageView.image = IMAGECACHE(@"icon_35");
    [self addSubview:self.xiajianImageView];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"商家配送-30分钟";
    self.timeLabel.font = LPFFONT(12);
    self.timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.timeLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineView];

    self.yunfeiLabel = [UILabel new];
    self.yunfeiLabel.text = @"基础运费7元";
    self.yunfeiLabel.font = LPFFONT(12);
    self.yunfeiLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.yunfeiLabel];


    
    self.bottomLabel = [UILabel new];
    self.bottomLabel.font = LPFFONT(12);
    self.bottomLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.bottomLabel];
    
    self.jianjianImageView = [UIImageView new];
    self.jianjianImageView.image = IMAGECACHE(@"icon_615");
    [self addSubview:self.jianjianImageView];
    
    self.activeLabel = [UILabel new];
    self.activeLabel.font = LPFFONT(12);
    self.activeLabel.textColor = RGB(0xFAD824);
    [self addSubview:self.activeLabel];

    self.youjianImageView = [UIImageView new];
    self.youjianImageView.image = IMAGECACHE(@"icon_615_02");
    [self addSubview:self.youjianImageView];

}

- (void)setupLayout{
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.offset = 0;
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.top.offset = 20 + SafeTopSpace;
        make.height.offset = 44;
        make.width.offset = 50;
    }];
    
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.top.offset = 20 + SafeTopSpace;
        make.height.offset = 44;
        make.width.offset = 50;
    }];

    [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.bottom.offset = - 40;
        make.width.height.offset = 50;
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.heardImageView.mas_top);
        make.left.equalTo(self.heardImageView.mas_right).offset = 10;
    }];
    
    [self.xiajianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset = 5;
        make.centerY.equalTo(self.nameLabel);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.heardImageView.mas_bottom);
        make.left.equalTo(self.heardImageView.mas_right).offset = 10;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 1;
        make.height.offset = 5;
        make.left.equalTo(self.timeLabel.mas_right).offset = 5;
        make.centerY.equalTo(self.timeLabel);
    }];
    [self.yunfeiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.heardImageView.mas_bottom);
        make.left.equalTo(self.lineView.mas_right).offset = 5;
    }];
    
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.right.offset = -110;
        make.bottom.offset = -5;
    }];
    
    [self.youjianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -8;
        make.bottom.offset = -10;
    }];
    [self.activeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -16;
        make.centerY.equalTo(self.youjianImageView);
    }];
    
    [self.jianjianImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.activeLabel.mas_left).offset = -5;
        make.bottom.offset = -5;
        make.centerY.equalTo(self.youjianImageView);
    }];
    
}


- (void)setModel:(ShopHeadViewModel *)model{
    _model = model;
    self.likeButton.selected = [model.isFavorite integerValue] ? YES : NO;
    [self.heardImageView sd_setImageWithURL:URLWithImageName(model.shopImg) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.nameLabel.text = model.shopName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@分钟",model.remark];
    self.yunfeiLabel.text = [NSString stringWithFormat:@"基础运费%@元",model.baseDeliveryMoney];
    self.bottomLabel.text = model.couponName;

    
    if ([model.couponNum integerValue] > 0) {
        self.activeLabel.text = [NSString stringWithFormat:@"%@个优惠卷",model.couponNum];
        self.activeLabel.hidden = NO;
        self.jianjianImageView.hidden = NO;
    }else{
        self.activeLabel.hidden = YES;
        self.jianjianImageView.hidden = YES;
    }
}


- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)likeButtonAction:(UIButton *)sender{
    
    NSString *url = @"";
    url = sender.selected ? USER_delFav : USER_addFav;
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"id"] = self.model.shopId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:url parameters:parames successed:^(id json) {
        if (json) {
            if (Weakself.likeButton.selected) {
                [MBHUDHelper showSuccess:@"取消关注成功"];
                [Weakself.likeButton setImage:IMAGECACHE(@"icon_34") forState:UIControlStateHighlighted];
            }else{
                [MBHUDHelper showSuccess:@"关注成功"];
                [Weakself.likeButton setImage:IMAGECACHE(@"mine_guanzhu") forState:UIControlStateHighlighted];
            }
            Weakself.likeButton.selected = !Weakself.likeButton.selected;
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
