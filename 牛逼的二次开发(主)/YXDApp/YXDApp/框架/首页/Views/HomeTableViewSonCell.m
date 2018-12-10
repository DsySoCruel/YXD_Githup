//
//  HomeTableViewSonCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeTableViewSonCell.h"

@interface HomeTableViewSonCell()

@property (nonatomic,strong) UILabel *lingjuan;
@property (nonatomic,strong) UILabel *lingjuan1;


@end


@implementation HomeTableViewSonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
        self.lingjuan = [UILabel new];
        self.lingjuan.textColor = [UIColor whiteColor];
        self.lingjuan.font = MFFONT(13);
//        self.lingjuan.text = @"满减";
        self.lingjuan.layer.cornerRadius = 3;
        self.lingjuan.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.lingjuan];
    
        self.lingjuan1 = [UILabel new];
        self.lingjuan1.text = @"9.0折券";
        self.lingjuan1.textColor = TEXTGray_COLOR;
        self.lingjuan1.font = LPFFONT(13);
        [self.contentView addSubview:self.lingjuan1];
    
}

- (void)setupLayout{
    
        [self.lingjuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset = 0;
            make.top.offset = 5;
            make.width.offset = self.lingjuan.intrinsicContentSize.width + 8;
            make.height.offset = 20;
            make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
        }];
        [self.lingjuan1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lingjuan.mas_right).offset = 5;
            make.centerY.equalTo(self.lingjuan.mas_centerY);
        }];
    
}


- (void)setModel:(HomeViewModelTicket *)model{
    _model = model;
    
    if ([model.couponType isEqualToString:@"1"]) {//满减优惠
        self.lingjuan.backgroundColor = THEME_COLOR;
        self.lingjuan.text = @"满减";

    }else{//折扣优惠
        self.lingjuan.backgroundColor = [UIColor redColor];
        self.lingjuan.text = @"领卷";

    }
    self.lingjuan1.text = model.couponName;
    [self.lingjuan mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = self.lingjuan.intrinsicContentSize.width + 8;
    }];
}

@end
