//
//  ShopCarDetailCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/27.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopCarDetailCell.h"

@interface ShopCarDetailCell()

@property (nonatomic,strong) UIButton *selectButton;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UIButton *jian;
@property (nonatomic,strong) UILabel *num;
@property (nonatomic,strong) UIButton *jia;
@property (nonatomic,strong) UIView *line;

@end

@implementation ShopCarDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
//    self.contentView.backgroundColor = BACK_COLOR;
    
    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectButton setImage:IMAGECACHE(@"icon_weixuan") forState:UIControlStateNormal];
    [self.selectButton setImage:IMAGECACHE(@"icon_50") forState:UIControlStateSelected];
    [self.contentView addSubview:self.selectButton];
    [self.selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    self.iconImageView = [UIImageView new];
    [self.contentView addSubview:self.iconImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = LPFFONT(15);
    self.nameLabel.textColor = TEXTBlack_COLOR;
    self.nameLabel.numberOfLines = 2;
    [self.contentView addSubview:self.nameLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.font = LPFFONT(13);
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    
    self.jian = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.jian setImage:IMAGECACHE(@"icon_52") forState:UIControlStateNormal];
    [self.contentView addSubview:self.jian];
    [self.jian addTarget:self action:@selector(jianButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.num = [UILabel new];
    self.num.textColor = TEXTGray_COLOR;
    self.num.font = LPFFONT(13);
    self.num.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.num];
    
    self.jia = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.jia setImage:IMAGECACHE(@"icon_53") forState:UIControlStateNormal];
    [self.contentView addSubview:self.jia];
    [self.jia addTarget:self action:@selector(jiaButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    self.line = [UIView new];
    self.line.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.line];
    
}

- (void)setupLayout{
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 50;
        make.height.width.offset = 45;
        make.top.offset = 15;
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.equalTo(self.iconImageView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.right.offset = -15;
        make.top.equalTo(self.iconImageView.mas_top).offset = 0;
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.top.equalTo(self.nameLabel.mas_bottom).offset = 10;
        make.bottom.offset = -10;
    }];
    
    [self.jia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.bottom.offset = -10;
        make.width.height.offset = 25;
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.jia.mas_left).offset = -10;
        make.width.height.offset = 30;
        make.centerY.equalTo(self.jia).offset = 0;
    }];
    
    [self.jian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.num.mas_left).offset = -10;
        make.centerY.equalTo(self.jia).offset = 0;
        make.width.height.offset = 25;
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 0.5;
        make.bottom.offset = 0;
    }];
    
}



- (void)setGoodModel:(ShopCarDetailGoodsModel *)goodModel{
    _goodModel = goodModel;
    [self.iconImageView sd_setImageWithURL:URLWithImageName(goodModel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.nameLabel.text = goodModel.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",goodModel.price];
    self.num.text = goodModel.cnt;
    self.selectButton.selected = goodModel.isSelect;
}

- (void)selectButtonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.goodModel.isSelect = sender.selected;
    if (self.selectButtonActionBlock) {
        self.selectButtonActionBlock();
    }
}

- (void)jianButtonAction:(UIButton *)sender{
//    if ([self.goodModel.cnt integerValue] <= 1) {
//        [MBHUDHelper showSuccess:@"亲,真的不能再少了"];
//        return;
//    }
    NSInteger cnt = [self.goodModel.cnt integerValue];
    --cnt;
    
    //减少商品数量
    sender.userInteractionEnabled = NSNotFound;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"goodsId"] = self.goodModel.goodsId;
    parames[@"shopId"] = self.shopId;
    parames[@"gcount"] = [NSString stringWithFormat:@"%tu",cnt];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_addToCart parameters:parames successed:^(id json) {
        if (json) {
            Weakself.goodModel.cnt = [NSString stringWithFormat:@"%tu",cnt];
            Weakself.num.text = Weakself.goodModel.cnt;
            //改变商品数量更新总价
            if (Weakself.needContTotalPriceBlock && Weakself.selectButton.selected) {
                Weakself.needContTotalPriceBlock();
            }
            if ([Weakself.goodModel.cnt integerValue] <= 0) {
                if (self.needUpdataBlock) {
                    self.needUpdataBlock();
                }
            }
        }
        sender.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        sender.userInteractionEnabled = YES;

    }];
}

- (void)jiaButtonAction:(UIButton *)sender{
    NSInteger cnt = [self.goodModel.cnt integerValue];
    ++cnt;
    //增加商品数量
    sender.userInteractionEnabled = NO;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"goodsId"] = self.goodModel.goodsId;
    parames[@"shopId"] = self.shopId;
    parames[@"gcount"] = [NSString stringWithFormat:@"%tu",cnt];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_addToCart parameters:parames successed:^(id json) {
        if (json) {
            Weakself.goodModel.cnt = [NSString stringWithFormat:@"%tu",cnt];
            Weakself.num.text = Weakself.goodModel.cnt;
            //改变商品数量更新总价
            if (Weakself.needContTotalPriceBlock && Weakself.selectButton.selected) {
                Weakself.needContTotalPriceBlock();
            }
        }
        sender.userInteractionEnabled = YES;
    } failure:^(NSError *error) {
        sender.userInteractionEnabled = YES;
    }];
}

@end
