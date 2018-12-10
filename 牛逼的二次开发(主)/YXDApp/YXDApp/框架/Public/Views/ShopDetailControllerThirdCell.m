//
//  ShopDetailControllerThirdCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailControllerThirdCell.h"
#import "ShopMessageModel.h"

@interface ShopDetailControllerThirdCell()
@property (nonatomic,strong) UIImageView *backImageView;

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UILabel *label5;

@end


@implementation ShopDetailControllerThirdCell

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
    
    self.label1 = [UILabel new];
    self.label1.font = LPFFONT(13);
    self.label1.textColor = BACK_COLOR;
    [self.label1 setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.backImageView addSubview:self.label1];
    
    self.label2 = [UILabel new];
    self.label2.font = LPFFONT(13);
    self.label2.textColor = BACK_COLOR;
    [self.label2 setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.backImageView addSubview:self.label2];

    
    self.label3 = [UILabel new];
    self.label3.font = LPFFONT(13);
    self.label3.textColor = BACK_COLOR;
    [self.label3 setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.backImageView addSubview:self.label3];

    
    self.label4 = [UILabel new];
    self.label4.font = LPFFONT(13);
    self.label4.textColor = BACK_COLOR;
    [self.label4 setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.backImageView addSubview:self.label4];

    
    self.label5 = [UILabel new];
    self.label5.font = LPFFONT(13);
    self.label5.textColor = BACK_COLOR;
    [self.label5 setContentHuggingPriority
     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
    [self.backImageView addSubview:self.label5];

}

- (void)setupLayout{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.bottom.offset = -5;
        make.top.offset = 5;
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.offset = 15;
        make.bottom.equalTo(self.label2.mas_top).offset = -15;
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.equalTo(self.label1.mas_bottom).offset = 10;;
    }];
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.equalTo(self.label2.mas_bottom).offset = 10;;
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.equalTo(self.label3.mas_bottom).offset = 10;;
    }];

    [self.label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.equalTo(self.label4.mas_bottom).offset = 10;
        make.bottom.offset = -15;
    }];
}

- (void)setModel:(ShopMessageModel *)model{
    _model = model;
    self.label1.text = [NSString stringWithFormat:@"月销单量:%@件",model.monthSales];
    self.label2.text = [NSString stringWithFormat:@"关注人数:%@人",model.FavoritesNum];
    self.label3.text = [NSString stringWithFormat:@"营业时间:%@:00--%@:00",model.serviceStartTime,model.serviceEndTime];
    self.label4.text = [NSString stringWithFormat:@"门店地址:%@",model.shopAddress];
    self.label5.text = [NSString stringWithFormat:@"门店电话:%@",model.shopTel];
}


@end
