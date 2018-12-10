//
//  OrderDetailFirstTableViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/5.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderDetailFirstTableViewCell.h"
#import "OrderDetailControllerModel.h"
#import "OrderProducModel.h"

@interface OrderDetailFirstTableViewCell()

@property (nonatomic,strong) UIImageView *goodImageView;

@property (nonatomic,strong) UILabel *titlelLabel;
@property (nonatomic,strong) UILabel *priceNumLabel;

@property (nonatomic,strong) UILabel *oldPriceLabel;
@property (nonatomic,strong) UILabel *relPriceLabel;

@end

@implementation OrderDetailFirstTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.goodImageView = [UIImageView new];
    [self.contentView addSubview:self.goodImageView];
    
    self.titlelLabel = [UILabel new];
    self.titlelLabel.font = MFFONT(16);
    [self.contentView addSubview:self.titlelLabel];
    
    self.priceNumLabel = [UILabel new];
    self.priceNumLabel.font = LPFFONT(13);
    self.priceNumLabel.textColor = TEXTBlack_COLOR;
    [self.contentView addSubview:self.priceNumLabel];
    
    self.oldPriceLabel = [UILabel new];
    self.oldPriceLabel.textColor = TEXTGray_COLOR;
    self.oldPriceLabel.font = LPFFONT(13);
    [self.contentView addSubview:self.oldPriceLabel];
    
    self.relPriceLabel = [UILabel new];
    self.relPriceLabel.textColor = TEXTGray_COLOR;
    self.relPriceLabel.font = MFFONT(15);
    [self.contentView addSubview:self.relPriceLabel];
    
}

- (void)setupLayout{
    
    [self.goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 15;
        make.width.height.offset = 50;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -15;
    }];
    
    [self.titlelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset = 5;
        make.right.offset = -10;
        make.top.equalTo(self.goodImageView);
    }];
    [self.priceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImageView.mas_right).offset = 5;
        make.bottom.equalTo(self.goodImageView);
    }];
    [self.relPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.equalTo(self.priceNumLabel);
    }];
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.relPriceLabel.mas_left).offset = -5;
        make.centerY.equalTo(self.priceNumLabel);
    }];
    
}

#pragma mark-设置数据
- (void)setModel:(GoodsListDetailGoodModel *)model{
    _model = model;
    [self.goodImageView sd_setImageWithURL:URLWithImageName(model.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.titlelLabel.text = model.goodsName;
    self.priceNumLabel.text = [NSString stringWithFormat:@"￥%@ * %@",model.goodsPrice,model.goodsNums];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",model.marketPrice]
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
    self.relPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.goodsPrice floatValue] * [model.goodsNums floatValue]];
}

- (void)setMakeOrderModel:(OrderProducOrderDetailModel *)makeOrderModel{
    _makeOrderModel = makeOrderModel;
    [self.goodImageView sd_setImageWithURL:URLWithImageName(makeOrderModel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.titlelLabel.text = makeOrderModel.goodsName;
    self.priceNumLabel.text = [NSString stringWithFormat:@"￥%@ * %@",makeOrderModel.price,makeOrderModel.num];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",makeOrderModel.shopPrice]
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
    self.relPriceLabel.text = [NSString stringWithFormat:@"￥%@",makeOrderModel.num_price];

}


@end
