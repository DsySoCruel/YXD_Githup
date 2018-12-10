//
//  ShopDetailSectionHeaderView.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailSectionHeaderView.h"

@interface ShopDetailSectionHeaderView()
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ShopDetailSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.line1 = [UIView new];
    self.line1.backgroundColor = BACK_COLOR;
    [self addSubview:self.line1];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text =@"附近店铺";
    self.titleLabel.textColor = BACK_COLOR;
    self.titleLabel.font = LPFFONT(14);
    [self addSubview:self.titleLabel];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self addSubview:self.line2];
    
}

- (void)setupLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.offset = 0;
        make.top.offset = 0;
        make.bottom.offset = 0;
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.height.offset = 1;
        make.width.offset = 80;
        make.right.equalTo(self.titleLabel.mas_left).offset = -20;
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.height.offset = 1;
        make.width.offset = 80;
        make.left.equalTo(self.titleLabel.mas_right).offset = 20;
    }];
}

- (void)setName:(NSString *)name{
    _name = name;
    self.titleLabel.text =name;
}

@end
