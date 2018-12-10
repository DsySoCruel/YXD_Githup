//
//  OrderDetailSecondCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderDetailSecondCell.h"
#import "OrderDetailControllerModel.h"

@interface OrderDetailSecondCell()

@property (nonatomic,strong) UILabel *sectionTitleLabel;

@property (nonatomic,strong) UIView *oneView;
@property (nonatomic,strong) UILabel *oneTitleLabel;
@property (nonatomic,strong) UILabel *oneContentLabel;

@property (nonatomic,strong) UIView *twoView;
@property (nonatomic,strong) UILabel *twoTitleLabel;
@property (nonatomic,strong) UILabel *twoContentLabel;
@property (nonatomic,strong) UILabel *twoDetailLabel;

@property (nonatomic,strong) UIView *threeView;
@property (nonatomic,strong) UILabel *threeTitleLabel;
@property (nonatomic,strong) UILabel *threeContentLabel;

@property (nonatomic,strong) UIView *fourView;
@property (nonatomic,strong) UIImageView *fourImageView;
@property (nonatomic,strong) UILabel *fourFirstLabel;
@property (nonatomic,strong) UILabel *fourTwoLabel;
@end


@implementation OrderDetailSecondCell


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
    
    self.sectionTitleLabel = [UILabel new];
    self.sectionTitleLabel.text = @"配送信息";
    self.sectionTitleLabel.font = LPFFONT(15);
    [self.contentView addSubview:self.sectionTitleLabel];
    
    self.oneView = [UIView new];
    self.oneView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.oneView];
    self.oneTitleLabel = [UILabel new];
    self.oneTitleLabel.font = LPFFONT(13);
    self.oneTitleLabel.text = @"送达时间:";
    self.oneTitleLabel.textColor = TEXTGray_COLOR;
    [self.oneTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.oneView addSubview:self.oneTitleLabel];
    self.oneContentLabel = [UILabel new];
    self.oneContentLabel.font = LPFFONT(13);
    self.oneContentLabel.text = @"立即送达[预计15:04]";
    [self.oneView addSubview:self.oneContentLabel];
    
    self.twoView = [UIView new];
    self.twoView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.twoView];
    self.twoTitleLabel = [UILabel new];
    self.twoTitleLabel.text = @"收货地址:";
    self.twoTitleLabel.textColor = TEXTGray_COLOR;
    self.twoTitleLabel.font = LPFFONT(13);
    [self.twoTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.twoView addSubview:self.twoTitleLabel];
    self.twoContentLabel = [UILabel new];
    self.twoContentLabel.text = @"刘先生 136********1234";
    self.twoContentLabel.font = LPFFONT(13);
    [self.twoView addSubview:self.twoContentLabel];
    self.twoDetailLabel = [UILabel new];
    self.twoDetailLabel.text = @"北京市西城区白纸饭东街";
    self.twoDetailLabel.font = LPFFONT(13);
    [self.twoView addSubview:self.twoDetailLabel];
    
    self.threeView = [UIView new];
    self.threeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.threeView];
    self.threeTitleLabel = [UILabel new];
    self.threeTitleLabel.text = @"配送方式:";
    self.threeTitleLabel.textColor = TEXTGray_COLOR;
    self.threeTitleLabel.font = LPFFONT(13);
    [self.threeTitleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.threeView addSubview:self.threeTitleLabel];
    self.threeContentLabel = [UILabel new];
    self.threeContentLabel.text = @"商家配送";
    self.threeContentLabel.backgroundColor = THEME_COLOR;
    self.threeContentLabel.textColor = [UIColor whiteColor];
    self.threeContentLabel.font = LPFFONT(11);
    [self.threeView addSubview:self.threeContentLabel];
    
    
    self.fourView = [UIView new];
    self.fourView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
    [self.fourView addGestureRecognizer:tap1];
    [self.contentView addSubview:self.fourView];
    self.fourImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_74")];
    self.fourImageView.userInteractionEnabled = YES;
    [self.fourView addSubview:self.fourImageView];
    self.fourFirstLabel = [UILabel new];
    self.fourFirstLabel.font = LPFFONT(13);
    self.fourFirstLabel.text = @"配送员：张家辉";
    [self.fourView addSubview:self.fourFirstLabel];
    self.fourTwoLabel = [UILabel new];
    self.fourTwoLabel.font = LPFFONT(13);
    
    NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"电话：1589677777"]];
    [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(2, 11)];
    [self.fourTwoLabel setAttributedText:titleString];
    [self.fourView addSubview:self.fourTwoLabel];
    //four整体加手势进行打电话得处理哦
    
    
}

- (void)setupLayout{
    
    [self.sectionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 15;
    }];
    
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.sectionTitleLabel.mas_bottom).offset = 5;
    }];
    [self.oneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.offset = 0;
    }];
    [self.oneContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.bottom.offset = 0;
    }];
    
    [self.twoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 65;
        make.top.equalTo(self.oneView.mas_bottom).offset = 1;
    }];
    [self.twoTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 15;
    }];
    [self.twoContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.offset = 15;
    }];
    [self.twoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoTitleLabel.mas_right).offset = 5;
        make.right.offset = -5;
        make.top.equalTo(self.twoContentLabel.mas_bottom).offset = 5;
    }];
    
    
    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 45;
        make.top.equalTo(self.twoView.mas_bottom).offset = 1;
    }];
    [self.threeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.bottom.offset = 0;
    }];
    [self.threeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeTitleLabel.mas_right).offset = 5;
//        make.right.offset = -5;
//        make.top.bottom.offset = 0;
        make.centerY.offset = 0;
    }];
    
    [self.fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 90;
        make.top.equalTo(self.threeView.mas_bottom).offset = 4;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    
    [self.fourImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.centerX.offset = -60;
    }];
    [self.fourFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fourImageView.mas_right).offset = 20;
        make.top.offset = 25;
    }];
    [self.fourTwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fourImageView.mas_right).offset = 20;
        make.bottom.offset = -25;
    }];
    
}

- (void)setModel:(OrderDetailControllerModel *)model{
    _model = model;
    
    [self.fourView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = [model.order.orderStatus integerValue] == 3 ? 90 :0;
    }];
    self.oneContentLabel.text = [NSString stringWithFormat:@"立即送达[预计%@]",model.order.requireTime];
    self.twoContentLabel.text = [NSString stringWithFormat:@"%@ %@",model.order.userName,model.order.userPhone];
    self.twoDetailLabel.text = model.order.userAddress;
    self.threeContentLabel.text = model.order.transType;
    
    if ([model.order.orderStatus integerValue] == 3 ) {
        self.fourFirstLabel.text = [NSString stringWithFormat:@"配送员：%@",model.order.runner.userName];
//        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"电话：%@",model.order.runner.userPhone]];
//        if (titleString.length > 11) {
//            [titleString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR range:NSMakeRange(2, 11)];
//        }
//        [self.fourTwoLabel setAttributedText:titleString];
        self.fourTwoLabel.text = [NSString stringWithFormat:@"电话:%@",model.order.runner.userPhone];
        [self.fourView addSubview:self.fourTwoLabel];
        self.fourView.hidden = NO;
    }else{
        self.fourView.hidden = YES;
    }
}
- (void)adView1Action{
    if (self.model.order.runner.userPhone.length) {
        NSString *telStr = self.model.order.runner.userPhone;
        UIWebView *callWebView = [[UIWebView alloc] init];
        NSURL *telURL     = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",telStr]];
        [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.contentView addSubview:callWebView];
    }else{
        [MBHUDHelper showError:@"暂无联系方式"];
    }
}

@end
