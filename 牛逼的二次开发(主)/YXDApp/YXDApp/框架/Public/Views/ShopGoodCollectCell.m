//
//  ShopGoodCollectCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/4.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopGoodCollectCell.h"
#import "ShopControllerModel.h"

@interface ShopGoodCollectCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *active;//活动
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *markPriceLabel;//原价
//@property (nonatomic, strong) UIButton *buyButton;

@property (nonatomic,strong) UIButton *jian;
@property (nonatomic,strong) UIImageView *jianImage;
@property (nonatomic,strong) UILabel *num;
@property (nonatomic,strong) UIButton *jia;
@property (nonatomic,strong) UIImageView *jiaImage;


@end


@implementation ShopGoodCollectCell

#pragma mark-
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI{
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    self.active = [UILabel new];
    self.active.backgroundColor = [UIColor redColor];
    self.active.textColor = [UIColor whiteColor];
    self.active.font = LPFFONT(11);
    self.active.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.active];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = LPFFONT(13);
    self.titleLabel.textColor = TEXTBlack_COLOR;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.text = @"包装水果玉米 约300g 送这个你蒸煮调料";
    [self.contentView addSubview:self.titleLabel];
    
    self.numLabel = [UILabel new];
    [self.contentView addSubview:self.numLabel];
    self.numLabel.text = @"月售242";
    self.numLabel.textColor = TEXTGray_COLOR;
    self.numLabel.font = LPFFONT(11);
    
    self.priceLabel = [UILabel new];
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.text = @"￥7.9";
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = LPFFONT(13);
    
    self.markPriceLabel = [UILabel new];
    [self.contentView addSubview:self.markPriceLabel];
    self.markPriceLabel.textColor = [UIColor grayColor];
    self.markPriceLabel.font = LPFFONT(11);
    
//    self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.buyButton setImage:IMAGECACHE(@"icon_41") forState:UIControlStateNormal];
//    [self.contentView addSubview:self.buyButton];
    
    self.jian = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.jian setImage:IMAGECACHE(@"icon_52") forState:UIControlStateNormal];
    [self.jian addTarget:self action:@selector(jianButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jianImage = [UIImageView new];
    self.jianImage.image = IMAGECACHE(@"icon_52");
    [self.contentView addSubview:self.jianImage];
    self.jianImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.jian];

    self.num = [UILabel new];
    self.num.textColor = TEXTGray_COLOR;
    self.num.font = LPFFONT(13);
    self.num.text = @"0";
    self.num.textAlignment = NSTextAlignmentCenter;
    self.num.userInteractionEnabled = YES;
    [self.contentView addSubview:self.num];
    
    self.jia = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.jia setImage:IMAGECACHE(@"icon_53") forState:UIControlStateNormal];
    [self.jia addTarget:self action:@selector(jiaButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jiaImage = [UIImageView new];
    self.jiaImage.image = IMAGECACHE(@"icon_53");
    [self.contentView addSubview:self.jiaImage];
    self.jiaImage.userInteractionEnabled = YES;
    [self.contentView addSubview:self.jia];

}

- (void)setupLayout{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 10;
        make.right.offset = -10;
        make.height.equalTo(self.imageView.mas_width);
//        make.bottom.offset = -100;
    }];
    
    [self.active mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 10;
        make.width.offset = 0;
        make.height.offset = 15;
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.top.equalTo(self.imageView.mas_bottom).offset = 8;
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.titleLabel.mas_bottom).offset = 4;
    }];
    
    [self.markPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.numLabel.mas_right).offset = 13;
//        make.top.equalTo(self.priceLabel.mas_bottom).offset = -2;
        make.centerY.equalTo(self.numLabel);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.bottom.offset = -12;
    }];
    
    [self.jiaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.bottom.offset = -10;
        make.width.height.offset = 20;
    }];
    [self.jia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset = 0;
        make.width.height.offset = 45;
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.jiaImage.mas_left).offset = 0;
        make.width.height.offset = 30;
        make.centerY.equalTo(self.jiaImage).offset = 0;
    }];
    
    [self.jianImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.num.mas_left).offset = 0;
        make.centerY.equalTo(self.jiaImage).offset = 0;
        make.width.height.offset = 20;
    }];
    [self.jian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset = 45;
        make.right.equalTo(self.jia.mas_left).offset = 0;
        make.centerY.equalTo(self.jia).offset = 0;
    }];
    
}

- (void)setModel:(ShopControllerGoodsListModel *)model{
    _model = model;
    [self.imageView sd_setImageWithURL:URLWithImageName(model.goodsImg) placeholderImage:IMAGECACHE(@"icon_0000")];
    
    self.active.hidden = model.intro.length ? NO : YES;
    self.active.text = model.intro;
    [self.active mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = self.active.intrinsicContentSize.width + 10;
    }];
    self.titleLabel.text = model.goodsName;
    self.numLabel.text = [NSString stringWithFormat:@"月售%@",model.totalSale];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    self.num.text = [NSString stringWithFormat:@"%tu",self.model.selectNum];
    
    //判断是否有原价
    if (model.intro.length) {
        self.markPriceLabel.hidden = NO;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价:￥%@",model.marketPrice]
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
    

    //判断隐藏减号 数量
    if (model.selectNum > 0) {
        self.jian.hidden = NO;
        self.jianImage.hidden = NO;
        self.num.hidden = NO;
    }else{
        self.jian.hidden = YES;
        self.jianImage.hidden = YES;
        self.num.hidden = YES;
    }
}

- (void)jiaButtonAction:(UIButton *)sender{
    if (self.model.selectNum > [self.model.totalStock integerValue]) {
        [MBHUDHelper showSuccess:@"库存剩余不足"];
        return;
    }
    ++self.model.selectNum ;
    self.num.text = [NSString stringWithFormat:@"%tu",self.model.selectNum];
    
    if (self.model.selectNum > 0 && self.jian.hidden) {
        self.jian.hidden = NO;
        self.jianImage.hidden = NO;
        self.num.hidden = NO;
    }
    
    if (self.jiaButtonBlock) {
        self.jiaButtonBlock(self.model);
    }
    //更改数据
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"goodsId"] = self.model.goodsId;
    parames[@"shopId"] = self.model.shopId;
    parames[@"gcount"] = [NSString stringWithFormat:@"%tu",self.model.selectNum];
    [[NetWorkManager shareManager] POST:USER_addToCart parameters:parames successed:^(id json) {
        if (json) {
            
        }
        sender.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        sender.userInteractionEnabled = YES;
    }];

}

- (void)jianButtonAction:(UIButton *)sender{
    --self.model.selectNum ;
    
    if (self.model.selectNum <= 0) {
        self.jian.hidden = YES;
        self.jianImage.hidden = YES;
        self.num.hidden = YES;
    }
//    NSInteger cnt = self.model.selectNum;
//    --cnt;
    self.num.text = [NSString stringWithFormat:@"%tu",self.model.selectNum];
    if (self.jianBUttonBlock) {
        self.jianBUttonBlock(self.model);
    }
    //更改数据tu

    //减少商品数量
    sender.userInteractionEnabled = NSNotFound;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"goodsId"] = self.model.goodsId;
    parames[@"shopId"] = self.model.shopId;
    parames[@"gcount"] = [NSString stringWithFormat:@"%tu",self.model.selectNum];
    [[NetWorkManager shareManager] POST:USER_addToCart parameters:parames successed:^(id json) {
        if (json) {
        }
        sender.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        sender.userInteractionEnabled = YES;
    }];    
}


@end
