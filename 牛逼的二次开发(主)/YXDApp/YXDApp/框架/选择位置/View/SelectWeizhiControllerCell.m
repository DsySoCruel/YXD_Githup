//
//  SelectWeizhiControllerCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/19.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "SelectWeizhiControllerCell.h"
#import "SelectWeizhiControllerModel.h"
#import "SelectWeizhiHistoryModel.h"

@interface SelectWeizhiControllerCell()

@property (nonatomic,strong) UIImageView *iconImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation SelectWeizhiControllerCell



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
    
    self.iconImage = [UIImageView new];
    self.iconImage.image = IMAGECACHE(@"icon_68");
    self.iconImage.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.iconImage];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = MFFONT(13);
    self.nameLabel.textColor = TEXTBlack_COLOR;
    self.nameLabel.numberOfLines = 1;
    [self.contentView addSubview:self.nameLabel];
    
    self.addressLabel = [UILabel new];
    self.addressLabel.font = LPFFONT(12);
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.textColor  = TEXT_COLOR;
    self.addressLabel.numberOfLines = 1;
    [self.contentView addSubview:self.addressLabel];
    
    self.lineView = [UILabel new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.lineView];
    
}

- (void)setupLayout{
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 10;
        make.bottom.offset = -10;
        make.width.height.offset = 40;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset = 0;
        make.right.offset = -10;
        make.top.offset = 10;
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImage.mas_right).offset = 0;
        make.right.offset = -10;
        make.bottom.offset = -10;
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}

- (void)setModel:(SelectWeizhiControllerModel *)model{
    _model = model;
    self.nameLabel.text = model.name;
    self.addressLabel.text = model.address;
}
- (void)setHistoryModel:(SelectWeizhiHistoryModel *)historyModel{
    _historyModel = historyModel;
    self.nameLabel.text = historyModel.place;
    self.addressLabel.text = historyModel.address;
}

@end
