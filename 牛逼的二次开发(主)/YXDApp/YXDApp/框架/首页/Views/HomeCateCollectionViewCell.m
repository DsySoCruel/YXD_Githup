//
//  HomeCateCollectionViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeCateCollectionViewCell.h"


@interface HomeCateCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeCateCollectionViewCell

#pragma mark- UI
- (void)setupUI{
    self.titleLabel = [UILabel new];
    self.titleLabel.font = LPFFONT(13);
    [self.contentView addSubview:self.titleLabel];
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
}

- (void)setupLayout{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 10;
        make.width.offset = 40;
        make.height.offset = 38;
        make.centerX.offset = 0;
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -8;
        make.height.offset = 20;
    }];
    
}

#pragma mark-
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setModel:(FunctionCollectCellModel *)model{
    _model = model;
     self.titleLabel.text = model.title;
    self.imageView.image = IMAGECACHE(model.icon);
}

- (void)setIndustryModel:(HomeIndustryModel *)industryModel{
    _industryModel = industryModel;
    self.titleLabel.text = industryModel.catName;
    [self.imageView sd_setImageWithURL:URLWithImageName(industryModel.catPath) placeholderImage:IMAGECACHE(@"icon_0000")];
}
- (void)setGoodModel:(GoodModel *)goodModel{
    _goodModel = goodModel;
    self.titleLabel.text = [NSString stringWithFormat:@"￥%@",goodModel.res.shopPrice];
    [self.imageView sd_setImageWithURL:URLWithImageName(goodModel.res.goodsImg) placeholderImage:IMAGECACHE(@"icon_0000")];
}
- (void)setListGoodsModel:(OrderListGoodsModel *)listGoodsModel{
    _listGoodsModel = listGoodsModel;
    self.titleLabel.text = [NSString stringWithFormat:@"￥%@",listGoodsModel.goodsPrice];
    [self.imageView sd_setImageWithURL:URLWithImageName(listGoodsModel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];

}


@end
