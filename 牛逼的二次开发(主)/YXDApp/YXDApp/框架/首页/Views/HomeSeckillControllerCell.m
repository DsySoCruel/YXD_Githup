//
//  HomeSeckillControllerCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeSeckillControllerCell.h"
#import "HomeSeckillModel.h"
#import "HomeGroupModel.h"
#import "ShopResultsTableViewModel.h"

@interface HomeSeckillControllerCell()

@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *fromLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *oldPriceLabel;
@property (nonatomic,strong) UIButton *qingButton;

@property (nonatomic, strong) UILabel *active;//活动


@end


@implementation HomeSeckillControllerCell

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
    

    
    self.iconImageView = [UIImageView new];
//    self.iconImageView.backgroundColor = [UIColor blueColor];
    [self.backView addSubview:self.iconImageView];
    
    self.active = [UILabel new];
    self.active.backgroundColor = [UIColor redColor];
    self.active.textColor = [UIColor whiteColor];
    self.active.font = LPFFONT(11);
    self.active.textAlignment = NSTextAlignmentCenter;
    [self.iconImageView addSubview:self.active];
    
    self.nameLabel = [UILabel new];
//    self.nameLabel.text = @"A级蜜柚小（个）不少于950G/个【如需剥皮请备注】";
    self.nameLabel.numberOfLines = 2;
    self.nameLabel.textColor = TEXTBlack_COLOR;
    self.nameLabel.font = LPFFONT(14);
    [self.backView addSubview:self.nameLabel];
    
    self.fromLabel = [UILabel new];
//    self.fromLabel.text = @"来自沃尔玛-花园路店";
    self.fromLabel.textColor = TEXTGray_COLOR;
    self.fromLabel.font = LPFFONT(11);
    [self.backView addSubview:self.fromLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.font = LPFFONT(16);
    [self.backView addSubview:self.priceLabel];

    self.oldPriceLabel = [UILabel new];
    self.oldPriceLabel.textColor = TEXTGray_COLOR;
    self.oldPriceLabel.font = LPFFONT(12);
    [self.backView addSubview:self.oldPriceLabel];

    
    self.qingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.qingButton setTitle:@"马上抢" forState:UIControlStateNormal];
    [self.qingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.qingButton.titleLabel.font = LPFFONT(14);
    self.qingButton.backgroundColor = [UIColor redColor];
    self.qingButton.userInteractionEnabled = NO;
    [self.backView addSubview:self.qingButton];
    
}

- (void)setupLayout{
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.offset = 0;
        make.top.offset = 10;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 15;
        make.width.height.offset = 80;
    }];
    
    [self.active mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 0;
        make.left.offset = 0;
        make.width.offset = 0;
        make.height.offset = 15;
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.right.offset = -10;
        make.top.equalTo(self.iconImageView.mas_top);
    }];
    
    [self.fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.right.offset = -10;
        make.top.equalTo(self.nameLabel.mas_bottom).offset = 5;
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset = 10;
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset = 5;
    }];
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset = 10;
        make.bottom.equalTo(self.iconImageView.mas_bottom).offset = 5;
    }];
    
    [self.qingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.height.offset = 25;
        make.width.offset = 70 ;
        make.centerY.equalTo(self.oldPriceLabel.mas_centerY);
        make.bottom.equalTo(self.backView.mas_bottom).offset = -15;
    }];
}

- (void)setMdoel:(HomeSeckillModel *)mdoel{
    _mdoel = mdoel;
    self.active.hidden = YES;
    [self.iconImageView sd_setImageWithURL:URLWithImageName(mdoel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.nameLabel.text = mdoel.goodsName;;
    self.fromLabel.text = [NSString stringWithFormat:@"来自%@",mdoel.shopName];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",mdoel.panicMoney]];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(11) range:NSMakeRange(0,1)];
    [self.priceLabel setAttributedText:titleString];
    
    
    NSMutableAttributedString * mutableStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",mdoel.shopPrice]];
    [mutableStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, mutableStr.length)];
    [mutableStr addAttribute:NSStrikethroughColorAttributeName value:TEXTGray_COLOR range:NSMakeRange(0, mutableStr.length)];
    self.oldPriceLabel.attributedText = mutableStr;

}


- (void)setGroupModel:(HomeGroupModel *)groupModel{
    _groupModel = groupModel;
    self.active.hidden = YES;
    [self.iconImageView sd_setImageWithURL:URLWithImageName(groupModel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.nameLabel.text = groupModel.goodsName;;
    self.fromLabel.text = [NSString stringWithFormat:@"来自%@",groupModel.shopName];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",groupModel.groupMoney]];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(11) range:NSMakeRange(0,1)];
    [self.priceLabel setAttributedText:titleString];
    
    NSMutableAttributedString * mutableStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",groupModel.shopPrice]];
    [mutableStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, mutableStr.length)];
    [mutableStr addAttribute:NSStrikethroughColorAttributeName value:TEXTGray_COLOR range:NSMakeRange(0, mutableStr.length)];
    self.oldPriceLabel.attributedText = mutableStr;
}

- (void)setShopResultsTableViewModel:(ShopResultsTableViewModel *)shopResultsTableViewModel{
    _shopResultsTableViewModel = shopResultsTableViewModel;
    [self.iconImageView sd_setImageWithURL:URLWithImageName(shopResultsTableViewModel.goodsThums) placeholderImage:IMAGECACHE(@"icon_0000")];
    self.nameLabel.text = shopResultsTableViewModel.goodsName;;
    self.fromLabel.text = [NSString stringWithFormat:@"来自%@",shopResultsTableViewModel.shopName];
    
    
    self.active.hidden = shopResultsTableViewModel.intro.length ? NO : YES;
    self.active.text = shopResultsTableViewModel.intro;
    [self.active mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset = self.active.intrinsicContentSize.width + 10;
    }];
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",shopResultsTableViewModel.price]];
    [titleString addAttribute:NSFontAttributeName value:LPFFONT(11) range:NSMakeRange(0,1)];
    [self.priceLabel setAttributedText:titleString];
    
    if (shopResultsTableViewModel.intro.length) {
        NSMutableAttributedString * mutableStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",shopResultsTableViewModel.marketPrice]];
        [mutableStr addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, mutableStr.length)];
        [mutableStr addAttribute:NSStrikethroughColorAttributeName value:TEXTGray_COLOR range:NSMakeRange(0, mutableStr.length)];
        self.oldPriceLabel.attributedText = mutableStr;
        self.oldPriceLabel.hidden = NO;
    }else{
        self.oldPriceLabel.hidden = YES;
    }
}


@end
