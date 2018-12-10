//
//  CategoryCollectCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "CategoryCollectCell.h"
#import "CategoryCollecModel.h"


@interface CategoryCollectCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation CategoryCollectCell

#pragma mark- UI

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
    [self.contentView addSubview:self.imageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = LPFFONT(14);
    self.titleLabel.textColor = TEXTBlack_COLOR;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];

}

- (void)setupLayout{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = -30;
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = 0;
        make.left.offset = 10;
        make.right.offset = -10;
        make.top.equalTo(self.imageView.mas_bottom).offset = 0;
    }];
}
- (void)setCollecModel:(CategoryCollecDataModel *)collecModel{
    _collecModel = collecModel;
    self.titleLabel.text = collecModel.catName;
    [self.imageView sd_setImageWithURL:URLWithImageName(collecModel.catPath) placeholderImage:IMAGECACHE(@"icon_0000")];
}

@end
