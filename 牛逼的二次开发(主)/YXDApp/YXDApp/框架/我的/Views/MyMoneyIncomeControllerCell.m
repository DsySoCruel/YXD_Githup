//
//  MyMoneyIncomeControllerCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/7.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyMoneyIncomeControllerCell.h"
#import "MyMoneyIncomeModel.h"

@interface MyMoneyIncomeControllerCell()

@property (nonatomic,strong) UILabel *orderNumLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyNumLabel;
@property (nonatomic,strong) UIView *lineView;

@end


@implementation MyMoneyIncomeControllerCell

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
    
    self.orderNumLabel = [UILabel new];
    self.orderNumLabel.text = @"订单号:123455";
    self.orderNumLabel.textColor  = TEXT_COLOR;
    self.orderNumLabel.font = LPFFONT(14);
    [self.contentView addSubview:self.orderNumLabel];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = MFFONT(11);
    self.timeLabel.textColor = TEXTGray_COLOR;
    [self.contentView addSubview:self.timeLabel];
    
    self.moneyNumLabel = [UILabel new];
    self.moneyNumLabel.text = @"+400";
    self.moneyNumLabel.font = PFFONT(16);
    self.moneyNumLabel.textColor = THEME_COLOR;
    [self.contentView addSubview:self.moneyNumLabel];
    
    self.lineView = [UILabel new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.lineView];
    
}

- (void)setupLayout{
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 15;
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.equalTo(self.orderNumLabel.mas_bottom).offset = 5;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -15;
    }];
    
    [self.moneyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.centerY.offset = 0;
    }];

    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}

- (void)setModel:(MyMoneyIncomeModel *)model{
    _model = model;
    self.orderNumLabel.text = [NSString stringWithFormat:@"订单号:%@",model.orderNo];
    self.timeLabel.text = model.createTime;
    if ([model.type integerValue]) {//+
        self.moneyNumLabel.text = [NSString stringWithFormat:@"+%@",model.money];
        self.moneyNumLabel.textColor = THEME_COLOR;
    }else{
        self.moneyNumLabel.text = [NSString stringWithFormat:@"-%@",model.money];
        self.moneyNumLabel.textColor = TEXTGray_COLOR;
    }
}

@end
