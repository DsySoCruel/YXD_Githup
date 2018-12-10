//
//  OrderDetailThirdCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderDetailThirdCell.h"
#import "OrderDetailControllerModel.h"

@interface OrderDetailThirdCell()

@property (nonatomic,strong) UILabel *sectionTitleLabel;

@property (nonatomic,strong) UIView *oneView;
@property (nonatomic,strong) UILabel *oneTitleLabel;
@property (nonatomic,strong) UILabel *oneContentLabel;

@property (nonatomic,strong) UIView *twoView;
@property (nonatomic,strong) UILabel *twoTitleLabel;
@property (nonatomic,strong) UILabel *twoContentLabel;

@property (nonatomic,strong) UIView *threeView;
@property (nonatomic,strong) UILabel *threeTitleLabel;
@property (nonatomic,strong) UILabel *threeContentLabel;


@end


@implementation OrderDetailThirdCell


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
    
    self.sectionTitleLabel = [UILabel new];
    self.sectionTitleLabel.text = @"订单信息";
    self.sectionTitleLabel.font = LPFFONT(15);
    [self.contentView addSubview:self.sectionTitleLabel];
    
    self.oneView = [UIView new];
    self.oneView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.oneView];
    self.oneTitleLabel = [UILabel new];
    self.oneTitleLabel.font = LPFFONT(13);
    self.oneTitleLabel.text = @"订单号码:";
    self.oneTitleLabel.textColor = TEXTGray_COLOR;
    [self.oneTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    [self.oneView addSubview:self.oneTitleLabel];
    self.oneContentLabel = [UILabel new];
    self.oneContentLabel.font = LPFFONT(13);
    self.oneContentLabel.text = @"11111111111111111111111";
    [self.oneView addSubview:self.oneContentLabel];
    
    self.twoView = [UIView new];
    self.twoView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.twoView];
    self.twoTitleLabel = [UILabel new];
    self.twoTitleLabel.text = @"下单时间:";
    self.twoTitleLabel.textColor = TEXTGray_COLOR;
    self.twoTitleLabel.font = LPFFONT(13);
    [self.twoTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.twoView addSubview:self.twoTitleLabel];
    self.twoContentLabel = [UILabel new];
    self.twoContentLabel.text = @"2017-11-04 14:20:50";
    self.twoContentLabel.font = LPFFONT(13);
    [self.twoView addSubview:self.twoContentLabel];

    self.threeView = [UIView new];
    self.threeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.threeView];
    self.threeTitleLabel = [UILabel new];
    self.threeTitleLabel.text = @"支付方式:";
    self.threeTitleLabel.textColor = TEXTGray_COLOR;
    self.threeTitleLabel.font = LPFFONT(13);
    [self.threeTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.threeView addSubview:self.threeTitleLabel];
    self.threeContentLabel = [UILabel new];
    self.threeContentLabel.text = @"微信支付";
    self.threeContentLabel.font = LPFFONT(13);
    [self.threeView addSubview:self.threeContentLabel];
    
    
}

- (void)setupLayout{
    
    [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 15;
    }];
    
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.sectionTitleLabel.mas_bottom).offset = 5;
    }];
    [self.oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.offset = 0;
    }];
    [self.oneContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.bottom.offset = 0;
    }];
    
    [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.oneView.mas_bottom).offset = 1;
    }];
    [self.twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.offset = 0;
    }];
    [self.twoContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.bottom.offset = 0;
    }];

    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.twoView.mas_bottom).offset = 1;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.offset = 0;
    }];
    [self.threeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.bottom.offset = 0;
    }];
}

- (void)setModel:(OrderDetailControllerModel *)model{
    _model = model;
    self.oneContentLabel.text = model.order.orderNo;
    self.twoContentLabel.text = model.order.createTime;
    self.threeContentLabel.text = model.order.payWay;
    
    if ([model.order.orderStatus integerValue] < 0) {
        self.oneTitleLabel.text = @"退款编号:";
        self.twoTitleLabel.text = @"申请时间:";
        self.threeTitleLabel.text = @"退款路径:";
        self.sectionTitleLabel.text = @"退款信息";
    }else{
        self.oneTitleLabel.text = @"订单编号:";
        self.twoTitleLabel.text = @"下单时间:";
        self.threeTitleLabel.text = @"支付方式:";
        self.sectionTitleLabel.text = @"订单信息";

    }
}


@end
