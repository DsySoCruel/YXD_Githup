//
//  ShopDetailCommentCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailCommentCell.h"
#import "ShopDetailCommentControllerModel.h"
#import "StarView.h"


@interface ShopDetailCommentCell()

@property (nonatomic,strong) UIView *secondView;
@property (nonatomic,strong) UIImageView *iconUserView;
@property (nonatomic,strong) UILabel *userNameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *xingView;
@property (nonatomic,strong) StarView *startView;
@property (nonatomic,strong) UILabel *comtentLabel;

@property (nonatomic,strong) UIView *thirdView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *shopReply;

@end


@implementation ShopDetailCommentCell


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
    
    self.secondView = [UIView new];
    self.secondView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.secondView];
    self.iconUserView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"")];
    [self.secondView addSubview:self.iconUserView];
    self.userNameLabel = [UILabel new];
    self.userNameLabel.text = @"j***m";
    self.userNameLabel.font = LPFFONT(12);
    [self.secondView addSubview:self.userNameLabel];
    self.timeLabel = [UILabel new];
    self.timeLabel.text = @"2017-11-17";
    self.timeLabel.textColor = TEXT_COLOR;
    self.timeLabel.font = LPFFONT(12);
    [self.secondView addSubview:self.timeLabel];
    self.xingView = [UIView new];
    self.xingView.backgroundColor = [UIColor whiteColor];
    [self.secondView addSubview:self.xingView];
    self.startView = [[StarView alloc] initWithFrame:CGRectMake(0, 0, 80, 20)];
    [self.xingView addSubview:self.startView];
    
    self.comtentLabel = [UILabel new];
    self.comtentLabel.numberOfLines = 5;
    self.comtentLabel.text = @"运送很及时，环境还不错，总体<start>来说非常<end>实惠啦错，总体来<start>说非常实<end>惠啦";
    self.comtentLabel.font = LPFFONT(13);
    [self.secondView addSubview:self.comtentLabel];
    
    self.thirdView = [UIView new];
    [self.secondView addSubview:self.thirdView];
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_65")];
    [self.thirdView addSubview:self.backImageView];
    self.shopReply = [UILabel new];
    self.shopReply.text = @"商家回复：谢谢惠顾";
    self.shopReply.numberOfLines = 5;
    self.shopReply.font = SFONT(11);
    [self.thirdView addSubview:self.shopReply];
    
}

- (void)setupLayout{

    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.right.offset = 0;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
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
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
}

- (void)setModel:(ShopDetailCommentControllerModel *)model{
    _model = model;
    [self.iconUserView sd_setImageWithURL:URLWithImageName(model.userPhoto) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.userNameLabel.text = model.loginName;
    self.timeLabel.text = model.createTime;
    self.startView.avgScore = [model.goodsScore integerValue];
    self.comtentLabel.text = model.content;
}
@end
