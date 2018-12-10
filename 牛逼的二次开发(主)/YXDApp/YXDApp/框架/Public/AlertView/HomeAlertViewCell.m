//
//  HomeAlertViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeAlertViewCell.h"
#import "HomeAlertViewModel.h"


@interface HomeAlertViewCell()

@property (nonatomic, strong) UILabel *leLabel;
@property (nonatomic, strong) UIImageView *icon;

@end


@implementation HomeAlertViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setupUI{
    
    self.leLabel = [UILabel new];
    self.leLabel.font = LPFFONT(12);
    self.leLabel.textAlignment = NSTextAlignmentLeft;
    self.leLabel.numberOfLines = 1;
    self.leLabel.text = @"按好评排序";
    [self.contentView addSubview:self.leLabel];
    
    self.icon = [UIImageView new];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.image = IMAGECACHE(@"icon_62");
    [self.contentView addSubview:self.icon];
}

- (void)setupLayout{
    [self.leLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.centerY.offset = 0;
//        make.top.offset = 0;
//        make.height.offset = 44;
//        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
//        make.width.offset = YXDScreenW - 100;
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.centerY.offset = 0;
    }];
}


- (void)setModel:(HomeAlertViewModel *)model{
    _model = model;
    self.icon.hidden = !model.isSelect;
    self.leLabel.text = model.name;
    self.leLabel.textColor = model.isSelect ? THEME_COLOR : TEXTGray_COLOR;
}

@end
