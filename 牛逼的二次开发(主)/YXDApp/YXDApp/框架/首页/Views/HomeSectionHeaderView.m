//
//  HomeSectionHeaderView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@interface HomeSectionHeaderView()
@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *line3;


@end

@implementation HomeSectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}


- (void)setupUI{
    
    self.backgroundColor = [UIColor whiteColor];
    self.line1 = [UIView new];
    self.line1.backgroundColor = BACK_COLOR;
    [self addSubview:self.line1];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.text =@"附近店铺";
    self.titleLabel.textColor = TEXT_COLOR;
    self.titleLabel.font = LPFFONT(14);
    [self addSubview:self.titleLabel];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self addSubview:self.line2];
    
    self.line3 = [UIView new];
    self.line3.backgroundColor = BACK_COLOR;
    [self addSubview:self.line3];

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
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}

- (void)setName:(NSString *)name{
    _name = name;
    self.titleLabel.text =name;
    self.backgroundColor = BACK_COLOR;
}
         
 
@end
