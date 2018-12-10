//
//  ShopDetailControllerFirstCell.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailControllerFirstCell.h"
#import "ShopMessageModel.h"

@interface ShopDetailControllerFirstCell()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;

@end


@implementation ShopDetailControllerFirstCell

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
    
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_64")];
    [self.contentView addSubview:self.backImageView];
    
    self.label1  = [UILabel new];
    self.label1.textColor = [UIColor redColor];
    self.label1.font = MFFONT(25);
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label1];

    
    self.label2  = [UILabel new];
    self.label2.font = MFFONT(15);
    [self.contentView addSubview:self.label2];
    
    self.label3  = [UILabel new];
    self.label3.font = LPFFONT(12);
    self.label3.textColor = TEXT_COLOR;
    [self.contentView addSubview:self.label3];
    
    self.label4  = [UILabel new];
    self.label4.backgroundColor = [UIColor redColor];
    self.label4.textColor = [UIColor whiteColor];
    self.label4.layer.cornerRadius = 10;
    self.label4.layer.masksToBounds = YES;
    self.label4.font = LPFFONT(12);
    self.label4.text = @"领卷";
    self.label4.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label4];
    
//    self.label5  = [UILabel new];
//    self.label5.textColor = TEXT_COLOR;
//    self.label5.font = LPFFONT(12);
//    [self.label5 setContentHuggingPriority
//     :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
//    [self.contentView addSubview:self.label5];
    
}

- (void)setupLayout{
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = -5;
        make.top.offset = 5;
        make.height.offset = 70;
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.bottom.top.offset = 0;
        make.height.equalTo(self.label1.mas_width);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 100;
        make.right.offset = -100;
        make.top.offset = 20;
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2);
        make.right.offset = -100;
        make.bottom.offset = -20;
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -20;
        make.centerY.equalTo(self.label1);
        make.height.offset = 20;
        make.width.offset = 50;
    }];
}

- (void)setModel:(ShopMessageCouponsModel *)model{
    _model = model;
    
    if ([model.couponType integerValue] == 1) {//满减优惠
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.couponMoney]];
        [titleString addAttribute:NSFontAttributeName value:LPFFONT(13) range:NSMakeRange(titleString.length - 1, 1)];
        [self.label1 setAttributedText:titleString];
        self.label2.text = [NSString stringWithFormat:@"满减卷 满%@元使用",model.couponMoney];
        
        
        
    }else{//折扣优惠
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f折",[model.discountRate floatValue] * 10]];
        [titleString addAttribute:NSFontAttributeName value:LPFFONT(13) range:NSMakeRange(titleString.length - 1, 1)];
        [self.label1 setAttributedText:titleString];
        //        self.label3.text = @"折扣卷 满22~99享折扣";
        self.label2.text = [NSString stringWithFormat:@"折扣卷 %@~%@元享折扣",model.couponMoney,model.spendMoney];
        
    }
    self.label3.text = [NSString stringWithFormat:@"%@ ~ %@",model.validStartTime,model.validEndTime];
    
    if ([model.isRecieve integerValue] == 0) {//没有获取
        self.backImageView.image = IMAGECACHE(@"icon_63");
        self.label4.hidden = NO;
    }else{//已经获取到的
        self.backImageView.image = IMAGECACHE(@"icon_64");
        self.label4.hidden = YES;
    }
}

@end
