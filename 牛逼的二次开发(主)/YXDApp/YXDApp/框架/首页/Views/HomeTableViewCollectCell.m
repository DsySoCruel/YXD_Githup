//
//  HomeTableViewCollectCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/7.
//  Copyright © 2017年 beijixing. All rights reserved.
//
#import "HomeTableViewCollectCell.h"

@interface HomeTableViewCollectCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *rexiao;

@end

@implementation HomeTableViewCollectCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI{
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    self.titleLabel = [UILabel new];
    self.titleLabel.font = LPFFONT(12);
    self.titleLabel.textColor = [UIColor redColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
//    self.rexiao = [UILabel new];
//    self.rexiao.text = @"热销";
//    self.rexiao.textColor = [UIColor whiteColor];
//    self.rexiao.backgroundColor = [UIColor redColor];
//    self.rexiao.font = MFFONT(13);
//    self.rexiao.layer.cornerRadius = 1;
//    self.rexiao.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:self.rexiao];
//    self.rexiao.hidden = YES;
    
}

- (void)setupLayout{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 5;
        make.right.offset = -5;
        make.bottom.offset = -20;
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = 0;
        make.left.offset = 10;
        make.right.offset = -10;
    }];
//    [self.rexiao mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.offset = 0;
//        make.width.offset = 35;
//        make.height.offset = 18;
//    }];
}

- (void)setModel:(HomeViewModelGoodList *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    [self.imageView sd_setImageWithURL:URLWithImageName(model.img) placeholderImage:IMAGECACHE(@"icon_0000")];
//    self.imageView.image = IMAGECACHE(@"mine_zhaopin_backImage");
}




@end
