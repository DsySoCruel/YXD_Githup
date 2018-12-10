//
//  OrderProducFirstCollectionCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/28.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderProducFirstCollectionCell.h"
#import "OrderProducModel.h"

@interface OrderProducFirstCollectionCell()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UIImageView *selectImageView;
@end


@implementation OrderProducFirstCollectionCell

#pragma mark- UI
- (void)setupUI{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_78")];
    self.backImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.backImageView];
    
    self.label1  = [UILabel new];
    self.label1.textColor = [UIColor redColor];
    self.label1.font = MFFONT(25);
    self.label1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label1];
    [self.label1 setContentHuggingPriority
         :UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];

    
    self.label2  = [UILabel new];
    self.label2.font = MFFONT(13);
    self.label2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label2];
    
    self.label3  = [UILabel new];
    self.label3.font = LPFFONT(11);
    self.label3.textColor = [UIColor redColor];
    [self.contentView addSubview:self.label3];
    
    self.label4  = [UILabel new];
    self.label4.font = LPFFONT(11);
    self.label4.textColor = TEXT_COLOR;
    self.label4.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.label4];
    
    self.selectImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_58")];
    [self.contentView addSubview:self.selectImageView];
    
//    self.label5  = [UILabel new];
//    self.label5.textColor = TEXT_COLOR;
//    self.label5.font = LPFFONT(12);

}

- (void)setupLayout{
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 10;
        make.right.bottom.offset = -10;
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.centerY.offset = -5;
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).offset = 5;
        make.right.offset = -20;
        make.centerY.offset = 0;
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1.mas_right).offset = 5;
        make.right.offset = -20;
        make.bottom.equalTo(self.label3.mas_top).offset = -5;
    }];
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.right.offset = -20;
        make.top.equalTo(self.label3.mas_bottom).offset = 10;
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 5;
    }];
}

#pragma mark-

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

- (void)setModel:(OrderProducCouponModel *)model{
    _model = model;
    self.selectImageView.hidden = !model.isSelect;
    
    if ([model.couponType integerValue] == 1) {//满减优惠
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",model.couponMoney]];
        [titleString addAttribute:NSFontAttributeName value:LPFFONT(13) range:NSMakeRange(titleString.length - 1, 1)];
        [self.label1 setAttributedText:titleString];
        self.label2.text = @"满减卷";
        self.label3.text = [NSString stringWithFormat:@"满%@元使用",model.spendMoney];
        
    }else{//折扣优惠
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f折",[model.discountRate floatValue] * 10]];
        [titleString addAttribute:NSFontAttributeName value:LPFFONT(13) range:NSMakeRange(titleString.length - 1, 1)];
        [self.label1 setAttributedText:titleString];
        //        self.label3.text = @"折扣卷 满22~99享折扣";
        self.label2.text = @"折扣卷";
        self.label3.text = [NSString stringWithFormat:@"%@~%@元享折扣",model.couponMoney,model.spendMoney];
    }
//    self.label2.text = [NSString stringWithFormat:@"%@",model.couponDes];
//    self.label2.backgroundColor = [UIColor redColor];
//    self.label2.text = @"123456";

    self.label4.text = [NSString stringWithFormat:@"%@ ~ %@",model.validStartTime,model.validEndTime];
 
}

@end
