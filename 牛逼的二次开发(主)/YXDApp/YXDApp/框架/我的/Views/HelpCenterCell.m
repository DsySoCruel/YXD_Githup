//
//  HelpCenterCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/2/6.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "HelpCenterCell.h"
#import "HeipCenterModel.h"

@interface HelpCenterCell()

@property (nonatomic,strong) UIImageView *jiantouImage1;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *jiantouImage2;
@property (nonatomic,strong) UIView *lineView;

@end


@implementation HelpCenterCell


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
    
    self.jiantouImage1 = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_131415")];
    [self.contentView addSubview:self.jiantouImage1];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = MFFONT(13);
    self.titleLabel.textColor = TEXTGray_COLOR;
    [self.contentView addSubview:self.titleLabel];
    
    self.jiantouImage2 = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_55")];
    [self.contentView addSubview:self.jiantouImage2];
    
    self.lineView = [UILabel new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.lineView];
    
}

- (void)setupLayout{
    [self.jiantouImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.offset = 0;
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 25;
        make.right.offset = - 40;
        make.top.bottom.offset = 0;
        make.height.offset = 44;
    }];
    
    [self.jiantouImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.centerY.offset = 0;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}

- (void)setModel:(HeipCenterModelTwoModel *)model{
    _model = model;
    self.titleLabel.text = model.articleTitle;
}

@end
