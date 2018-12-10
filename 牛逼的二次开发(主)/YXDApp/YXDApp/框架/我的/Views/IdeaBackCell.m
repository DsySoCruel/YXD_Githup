//
//  IdeaBackCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "IdeaBackCell.h"
#import "IdeaBackModel.h"

@interface IdeaBackCell()

@property (nonatomic,strong) UILabel *typeLabel;//反馈意见类型label
@property (nonatomic,strong) UILabel *personLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UILabel *morenButton;
@property (nonatomic,strong) UIButton *deleButton;
@property (nonatomic,strong) UIView *lineView;

@end


@implementation IdeaBackCell

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
    
    self.typeLabel = [UILabel new];
    self.typeLabel.textColor = TEXT_COLOR;
    self.typeLabel.font = LPFFONT(16);
    [self.contentView addSubview:self.typeLabel];
    
    self.personLabel = [UILabel new];
    self.personLabel.textColor  = TEXT_COLOR;
    self.personLabel.font = LPFFONT(12);
    [self.contentView addSubview:self.personLabel];
    
    self.addressLabel = [UILabel new];
    self.addressLabel.font = MFFONT(13);
    self.addressLabel.numberOfLines = 2;
    [self.contentView addSubview:self.addressLabel];
    
    self.morenButton = [UILabel new];
    self.morenButton.font = LPFFONT(17);
    self.morenButton.textColor = THEME_COLOR;
    [self.contentView addSubview:self.morenButton];
    
    self.deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleButton setImage:IMAGECACHE(@"icon_51") forState:UIControlStateNormal];
    [self.deleButton addTarget:self action:@selector(deleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.deleButton];
    [self.deleButton setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.deleButton setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    self.lineView = [UILabel new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.lineView];
    
}

- (void)setupLayout{
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 15;
        make.left.offset = 10;
    }];
    
    [self.personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset = 10;
        make.bottom.equalTo(self.typeLabel);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.personLabel.mas_bottom).offset = 10;
        make.left.offset = 10;
        make.right.equalTo(self.deleButton.mas_left).offset = -10;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -15;
    }];
    
    [self.morenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.personLabel);
        make.right.offset = -13;
    }];
    
    [self.deleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 10;
        make.right.offset = -15;
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.height.offset = 0.5;
    }];
}


   

- (void)setModel:(IdeaBackModel *)model{
    _model = model;
    if ([model.feedbackType integerValue] == 2) {
        self.typeLabel.text = @"其它异常";
    }else{
        self.typeLabel.text = @"功能异常";
    }
    self.personLabel.text = model.createTime;
    self.addressLabel.text = model.content;
    
    if ([model.adminId integerValue] == 0) {
        self.morenButton.text = @"待处理";
        self.morenButton.textColor = TEXTBlack_COLOR;
    }else{
        self.morenButton.text = @"已处理";
        self.morenButton.textColor = TEXT_COLOR;
    }
}

- (void)deleButtonAction:(UIButton *)sender{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"id"] = _model.feedbackId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_delfeed parameters:parames successed:^(id json) {
        if (json) {
            if (Weakself.deleCellBlock) {
                Weakself.deleCellBlock(_model.feedbackId);
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
