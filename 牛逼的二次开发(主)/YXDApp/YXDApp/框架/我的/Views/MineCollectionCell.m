//
//  MineCollectionCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MineCollectionCell.h"

@interface MineCollectionCell()
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UIImageView *delimgv;
@end

@implementation MineCollectionCell


-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = LPFFONT(16);
        _titleLabel.textColor = TEXTBlack_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)delimgv{
    if (!_delimgv) {
        _delimgv = [UIImageView new];
        _delimgv.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _delimgv;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.delimgv];
        [self.delimgv mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.offset = 0;
//            make.height.mas_equalTo(self.contentView.mas_height).multipliedBy(0.25);
            make.centerX.offset = 0;
            make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        }];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.delimgv.mas_bottom).offset = 15;
            make.left.right.offset = 0;
            make.height.equalTo(@15);
        }];
    }
    return self;
}

- (void)setModel:(FunctionCollectCellModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.delimgv.image = IMAGECACHE(model.icon);
}


@end
