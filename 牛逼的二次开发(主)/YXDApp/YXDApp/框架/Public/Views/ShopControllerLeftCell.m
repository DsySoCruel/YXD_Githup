//
//  ShopControllerLeftCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/3.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopControllerLeftCell.h"
#import "ShopControllerModel.h"

@interface ShopControllerLeftCell()

@property (nonatomic,strong) UIImageView *lineView;
@property (nonatomic,strong) UILabel *nameLabel;

@end


@implementation ShopControllerLeftCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    self.contentView.backgroundColor = BACK_COLOR;

    self.lineView = [UIImageView new];
    self.lineView.image = IMAGECACHE(@"icon_38");
    [self.contentView addSubview:self.lineView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = LPFFONT(11);
    [self.contentView addSubview:self.nameLabel];
}

- (void)setupLayout{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.centerY.offset = 0;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.right.offset = 0;
    }];
}

- (void)setModel:(ShopControllerSecondModel *)model{
    _model = model;
    self.nameLabel.text = model.catName;
    if (model.isSelect) {
        self.nameLabel.textColor  = THEME_COLOR;
        self.lineView.image = IMAGECACHE(@"icon_38");
    }else{
        self.nameLabel.textColor  = TEXT_COLOR;
        self.lineView.image = IMAGECACHE(@"icon_39");
    }
}
@end
