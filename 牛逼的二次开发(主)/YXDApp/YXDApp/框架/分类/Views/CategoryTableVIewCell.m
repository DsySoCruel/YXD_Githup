//
//  CategoryTableVIewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "CategoryTableVIewCell.h"
#import "CategoryTableVIewModel.h"


@interface CategoryTableVIewCell()
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *nameLabel;
@end


@implementation CategoryTableVIewCell

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
    
    self.lineView = [UILabel new];
    [self.contentView addSubview:self.lineView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = LPFFONT(11);
    [self.contentView addSubview:self.nameLabel];
}

- (void)setupLayout{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.offset = 0;
        make.width.offset = 2;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 2;
        make.top.bottom.right.offset = 0;
    }];
}


- (void)setModel:(CategoryTableVIewModel *)model{
    _model = model;
    self.nameLabel.text = model.catName;
    if (model.isSelect) {
        self.nameLabel.textColor  = THEME_COLOR;
        self.lineView.backgroundColor = THEME_COLOR;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else{
        self.nameLabel.textColor  = TEXT_COLOR;
        self.lineView.backgroundColor = BACK_COLOR;
        self.contentView.backgroundColor = BACK_COLOR;
    }
    
}
@end
