//
//  OrderMessageControllerCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/6.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderMessageControllerCell.h"
#import "OrderMessageModel.h"
#import "SystemorderMessageModel.h"

@interface OrderMessageControllerCell()
@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIButton *qingButton;

@end

@implementation OrderMessageControllerCell

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
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.backView];
    
//    self.iconImageView = [UIImageView new];
//    self.iconImageView.backgroundColor = [UIColor blueColor];
//    self.iconImageView.layer.cornerRadius = 30;
//    self.iconImageView.layer.masksToBounds = YES;
//    [self.backView addSubview:self.iconImageView];
    
    self.nameLabel = [UILabel new];
//    self.nameLabel.text = @"沃尔玛-花园路店";
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textColor = TEXTBlack_COLOR;
    self.nameLabel.font = LPFFONT(15);
    [self.backView addSubview:self.nameLabel];
    
//    self.stateLabel = [UILabel new];
//    self.stateLabel.text = @"配送中";
//    self.stateLabel.textColor = THEME_COLOR;
//    self.stateLabel.font = LPFFONT(15);
//    [self.backView addSubview:self.stateLabel];

    
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"下单时间：2017-10-30 11:20";
    self.timeLabel.font = LPFFONT(16);
    self.timeLabel.textColor = TEXTGray_COLOR;
    [self.backView addSubview:self.timeLabel];
    
//    self.priceLabel = [UILabel new];
//    self.priceLabel.text = @"总价:￥0.9";
//    self.priceLabel.font = LPFFONT(11);
//    self.priceLabel.textColor = TEXTGray_COLOR;
//    [self.backView addSubview:self.priceLabel];
    
    self.qingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.qingButton setTitle:@"再来一单" forState:UIControlStateNormal];
    [self.qingButton setImage:IMAGECACHE(@"icon_51") forState:UIControlStateNormal];
    [self.qingButton addTarget:self action:@selector(qingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.qingButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    self.qingButton.titleLabel.font = LPFFONT(14);
//    self.qingButton.layer.borderWidth = 1;
//    self.qingButton.layer.borderColor = [UIColor redColor].CGColor;
//    self.qingButton.layer.cornerRadius = 3;
    [self.backView addSubview:self.qingButton];
    

}

- (void)setupLayout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = 0;
    }];
    
//    
//    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset = 15;
//        make.top.offset = 30;
//        make.width.height.offset = 60;
//    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
//        make.right.offset = -10;
        make.top.offset = 25;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.right.offset = -10;;
        make.top.equalTo(self.timeLabel.mas_bottom).offset = 10;
        make.bottom.equalTo(self.backView.mas_bottom).offset = -20;

    }];
    
//    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.offset = -15;
//        make.top.equalTo(self.nameLabel.mas_top);
//    }];
    
//
//    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
//        make.bottom.equalTo(self.iconImageView.mas_bottom);
//    }];
    
    
    [self.qingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.height.offset = 23;
        make.width.offset = 80;
        make.top.offset = 25;
    }];
    
}

- (void)setModel:(OrderMessageModel *)model{
    _model = model;
    self.timeLabel.text = model.createTime;
    self.nameLabel.text = model.msgContent;
}

- (void)setSysModel:(SystemorderMessageModel *)sysModel{
    _sysModel = sysModel;
    self.timeLabel.text = sysModel.createTime;
    self.nameLabel.text = sysModel.content;
}

- (void)qingButtonAction:(UIButton *)sender{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"id"] = self.model.messageId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_deleMessage parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"删除成功"];
            if (Weakself.deldeMessageBlock) {
                Weakself.deldeMessageBlock();
            }
        }
    } failure:^(NSError *error) {
        
    }];

    
    
}

@end
