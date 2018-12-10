//
//  HomeTableCellTopView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeTableCellTopView.h"
#import "StarView.h"
#import "MyAttentionModel.h"
#import "HomeViewModel.h"

@interface HomeTableCellTopView()

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *aaView;
@property (nonatomic,strong) StarView *starView;
@property (nonatomic,strong) UILabel *numLabel;

@end

@implementation HomeTableCellTopView

- (instancetype)init{
    if (self = [super init]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setupUI{
    self.iconImageView = [UIImageView new];
    self.iconImageView.layer.cornerRadius = 30;
    self.iconImageView.image = IMAGECACHE(@"icon_0000");
    [self addSubview:self.iconImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.text = @"沃尔玛-花园路店";
    self.nameLabel.textColor = TEXTBlack_COLOR;
    self.nameLabel.font = LPFFONT(15);
    self.nameLabel.numberOfLines = 2;
    [self addSubview:self.nameLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"商家配送-30分钟";
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.font = LPFFONT(10);
    self.timeLabel.textColor = TEXTGray_COLOR;
    [self addSubview:self.timeLabel];
    
    self.aaView = [UIView new];
    self.aaView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.aaView];
    
    self.starView = [[StarView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [self.aaView addSubview:self.starView];
    
    self.numLabel = [UILabel new];
    self.numLabel.textColor = TEXTGray_COLOR;
    self.numLabel.font = LPFFONT(13);
    [self addSubview:self.numLabel];
    
}

- (void)setupLayout{
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset = 0;
        make.left.offset = 15;
        make.width.equalTo(self.iconImageView.mas_height);
    }];
    
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -5;
        make.centerY.equalTo(self.nameLabel);
//        make.width.offset = self.timeLabel.intrinsicContentSize.width + 10;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.right.offset = -10 - self.timeLabel.intrinsicContentSize.width - 10;
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
    }];

    
    [self.aaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.top.equalTo(self.nameLabel.mas_bottom).offset = 5;
        make.height.offset = 20;
        make.width.offset = 80;
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.aaView.mas_right).offset = 10;
        make.top.equalTo(self.nameLabel.mas_bottom).offset = 5;
    }];
    
}

- (void)setModel:(MyAttentionModel *)model{
    _model = model;
    
    [self.iconImageView sd_setImageWithURL:URLWithImageName(model.shopImg) placeholderImage:IMAGECACHE(@"icon_0000")];
    
    self.nameLabel.text = model.shopName;
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@分钟",[model.deliveryType integerValue] ? @"平台配送":@"商家配送",model.deliveryCostTime];
    self.starView.avgScore = [model.star integerValue];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"| 月售  %@  单",model.sale]];
    [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,titleString.length - 1 - 4 )];
    [self.numLabel setAttributedText:titleString];

}

- (void)setHomeModel:(HomeViewModel *)homeModel{
    _homeModel = homeModel;
    
    [self.iconImageView sd_setImageWithURL:URLWithImageName(homeModel.logo) placeholderImage:IMAGECACHE(@"icon_0000")];
    
    self.nameLabel.text = homeModel.shopname;

    self.starView.avgScore = [homeModel.star integerValue];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"| 月售 %@ 单",homeModel.sale]];
    [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,titleString.length - 1 - 4 )];
    [self.numLabel setAttributedText:titleString];
    
    if (homeModel.juli.length) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@ | %@",homeModel.remark,homeModel.juli];
    }else{
        self.timeLabel.text = homeModel.remark;
    }
    
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10 - self.timeLabel.intrinsicContentSize.width;
    }];
}

@end
