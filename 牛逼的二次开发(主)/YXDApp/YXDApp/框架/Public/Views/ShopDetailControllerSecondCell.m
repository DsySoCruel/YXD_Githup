//
//  ShopDetailControllerSecondCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailControllerSecondCell.h"
#import "ShopMessageModel.h"
#import "StarView.h"
#import "ShopDetailCommentController.h"

@interface ShopDetailControllerSecondCell()

@property (nonatomic,strong) UIImageView *backImageView;

//上部
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *bottomViewL;
@property (nonatomic,strong) UIView *bottomViewR;

@property (nonatomic,strong) UILabel *balanceNumLabel;//余额数
@property (nonatomic,strong) UILabel *balanceLabel;//余额
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *discountsNumLabel;//优惠卷数
@property (nonatomic,strong) UILabel *discountsLabel;//优惠卷

@property (nonatomic,strong) UIView *line2;

//中部

@property (nonatomic,strong) UIView *secondView;
@property (nonatomic,strong) UIImageView *iconUserView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *xingView;
@property (nonatomic,strong) StarView *startView;
@property (nonatomic,strong) UILabel *comtentLabel;

@property (nonatomic,strong) UIView *thirdView;
@property (nonatomic,strong) UIImageView *thirdViewImageView;
@property (nonatomic,strong) UILabel *shopReply;

@property (nonatomic,strong) UIView *line3;


//下部
@property (nonatomic,strong) YXDButton *commentAllButton;

@end


@implementation ShopDetailControllerSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor clearColor];
    
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_188")];
    self.backImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.backImageView];
    
    //上部
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self.backImageView addSubview:self.bottomView];
    
    self.bottomViewL = [UIView new];
    self.bottomViewL.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.bottomViewL];
    
    self.balanceNumLabel = [UILabel new];
    self.balanceNumLabel.textColor = BACK_COLOR;
    self.balanceNumLabel.font = BPFFONT(20);
    [self.bottomViewL addSubview:self.balanceNumLabel];
    
    self.balanceLabel = [UILabel new];
    self.balanceLabel.text = @"综合评分";
    self.balanceLabel.textColor = BACK_COLOR;
    self.balanceLabel.font = LPFFONT(12);
    [self.bottomViewL addSubview:self.balanceLabel];
    
    self.bottomViewR = [UIView new];
    self.bottomViewR.backgroundColor = [UIColor clearColor];
    [self.bottomView addSubview:self.bottomViewR];
    
    self.discountsNumLabel = [UILabel new];
    self.discountsNumLabel.textColor = BACK_COLOR;
    self.discountsNumLabel.font = BPFFONT(20);
    [self.bottomViewR addSubview:self.discountsNumLabel];
    
    self.discountsLabel  =[UILabel new];
    self.discountsLabel.text = @"评论条数";
    self.discountsLabel.textColor = BACK_COLOR;
    self.discountsLabel.font = LPFFONT(12);
    [self.bottomViewR addSubview:self.discountsLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.lineView];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.line2];
    
    //中部
    
    self.secondView = [UIView new];
    self.secondView.backgroundColor = [UIColor clearColor];
    
    [self.backImageView addSubview:self.secondView];
    self.iconUserView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"")];
    self.iconUserView.layer.cornerRadius = 25;
    self.iconUserView.layer.masksToBounds = YES;
    [self.secondView addSubview:self.iconUserView];
    self.userNameLabel = [UILabel new];
    self.userNameLabel.text = @"j***m";
    self.userNameLabel.font = LPFFONT(12);
    self.userNameLabel.textColor = BACK_COLOR;
    [self.secondView addSubview:self.userNameLabel];
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"2017-11-17";
    self.timeLabel.textColor = BACK_COLOR;
    self.timeLabel.font = LPFFONT(12);
    [self.secondView addSubview:self.timeLabel];
    self.xingView = [UIView new];
    self.xingView.backgroundColor = [UIColor clearColor];
    [self.secondView addSubview:self.xingView];
    self.startView = [[StarView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [self.xingView addSubview:self.startView];
    
    self.comtentLabel = [UILabel new];
    self.comtentLabel.numberOfLines = 5;
    self.comtentLabel.text = @"运送很及时，环境还不错，总体<start>来说非常<end>实惠啦错，总体来<start>说非常实<end>惠啦";
    self.comtentLabel.font = LPFFONT(13);
    self.comtentLabel.textColor = BACK_COLOR;
    [self.secondView addSubview:self.comtentLabel];
    
    self.thirdView = [UIView new];
    [self.secondView addSubview:self.thirdView];
    self.thirdViewImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_65")];
    [self.thirdView addSubview:self.thirdViewImageView];
    self.shopReply = [UILabel new];
    self.shopReply.text = @"商家回复：谢谢惠顾";
    self.shopReply.textColor = BACK_COLOR;
    self.shopReply.numberOfLines = 5;
    self.shopReply.font = SFONT(11);
    [self.thirdView addSubview:self.shopReply];
    
    self.line3 = [UIView new];
    self.line3.backgroundColor = BACK_COLOR;
    [self.secondView addSubview:self.line3];
    
    //下部
    self.commentAllButton = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.commentAllButton setTitle:@"查看用户全部评论" forState:UIControlStateNormal];
    [self.commentAllButton setImage:IMAGECACHE(@"icon_54") forState:UIControlStateNormal];
    [self.commentAllButton setTitleColor:BACK_COLOR forState:UIControlStateNormal];
    self.commentAllButton.titleLabel.font = LPFFONT(13);
    self.commentAllButton.status = MoreStyleStatusCenter;
    self.commentAllButton.padding = 5;
    [self.commentAllButton addTarget:self action:@selector(commentAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:self.commentAllButton];
}

- (void)setupLayout{
    
    //上部
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = -5;
        make.top.offset = 5;
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.right.offset = -15;
        make.height.offset = 70;
        make.top.offset = 0;
    }];
    
    [self.bottomViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset = 0;
        make.top.offset = 0;
        make.right.equalTo(self.bottomViewR.mas_left).offset = 0;
        make.width.equalTo(self.bottomViewR);
    }];
    
    [self.bottomViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset = 0;
        make.top.offset = 0;
        make.left.equalTo(self.bottomViewL.mas_right).offset = 0;
        make.width.equalTo(self.bottomViewL);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 0.5;
        make.height.offset = 50;
        make.bottom.offset = -10;
        make.centerX.equalTo(self.bottomView.mas_centerX);
    }];
    
    [self.balanceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 10;
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -10;
    }];
    [self.discountsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 10;
    }];
    [self.discountsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -10;
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
    
    //中部
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).offset = 1;
        make.left.offset = 10;
        make.right.offset = -10;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -50;
    }];
    [self.iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 20;
        make.width.height.offset = 50;
    }];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconUserView);
        make.left.equalTo(self.iconUserView.mas_right).offset = 5;
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconUserView);
        make.right.offset = -10;
    }];
    [self.xingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.top.equalTo(self.userNameLabel.mas_bottom).offset = 5;
        make.width.offset = 80;
        make.height.offset = 20;
    }];
    [self.comtentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.right.offset = -10;
        make.top.equalTo(self.xingView.mas_bottom).offset = 5;
    }];
    [self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userNameLabel);
        make.right.offset = -10;
        make.top.equalTo(self.comtentLabel.mas_bottom).offset = 5;
        make.bottom.equalTo(self.secondView.mas_bottom).offset = -15;
    }];
    [self.thirdViewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.offset = 5;
    }];
    [self.shopReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset = 0;
        make.left.offset = 5;
        make.right.offset = -5;
        make.top.offset = 10;
        make.bottom.equalTo(self.thirdView.mas_bottom).offset = 0;
    }];
    
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 0.5;
        make.bottom.offset = 0;
    }];
    
    
    //下部
    [self.commentAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.right.offset = -15;
        make.bottom.offset = 0;
        make.height.offset = 40;
    }];
}

- (void)setModel:(ShopMessageModel *)model{
    _model = model;
    self.balanceNumLabel.text = model.appraises;
    self.discountsNumLabel.text = model.commentNum;
    
    [self.iconUserView sd_setImageWithURL:URLWithImageName(model.firstComment.userPhoto) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.userNameLabel.text = model.firstComment.loginName;
    self.timeLabel.text = model.firstComment.createTime;
    self.startView.avgScore = [model.firstComment.goodsScore integerValue];
    self.comtentLabel.text = model.firstComment.content;
}

- (void)commentAllButtonAction:(UIButton *)sender{
    ShopDetailCommentController *vc = [ShopDetailCommentController new];
    vc.shopId = self.model.shopId;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
