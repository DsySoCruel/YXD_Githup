//
//  MyAttentionControllerCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MyAttentionControllerCell.h"
#import "HomeTableCellTopView.h"
#import "MyAttentionModel.h"

@interface MyAttentionControllerCell()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) HomeTableCellTopView *topView;
@property (nonatomic,strong) UIButton *deleteButton;

@end

@implementation MyAttentionControllerCell


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
    [self.contentView addSubview:self.backView];
    
    self.topView = [HomeTableCellTopView new];
    [self.backView addSubview:self.topView];
    
    self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteButton setTitleColor:TEXT_COLOR forState:UIControlStateNormal];
    self.deleteButton.titleLabel.font = LPFFONT(14);
    [self.deleteButton setImage:IMAGECACHE(@"icon_51") forState:UIControlStateNormal];
//    self.deleteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    self.deleteButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self.backView addSubview:self.deleteButton];
    [self.deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupLayout{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.offset = 0;
        make.top.offset = 10;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset = 0;
        make.top.offset = 15;
        make.height.offset = 60;
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -10;
        make.top.equalTo(self.topView.mas_bottom).offset = 5;
        make.height.offset = 20;
        make.width.offset = 60 ;
        make.bottom.equalTo(self.backView.mas_bottom).offset = -5;
    }];
}

- (void)setModel:(MyAttentionModel *)model{
    _model = model;
    self.topView.model = model;
}

- (void)deleteButtonAction{
    if (self.deleteMyAttenBlock) {
        self.deleteMyAttenBlock(_model.shopId);
    }
}


@end
