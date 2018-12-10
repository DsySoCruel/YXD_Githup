//
//  PeisongAlertView.m
//  YXDApp
//
//  Created by daishaoyang on 2018/2/7.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "PeisongAlertView.h"

#define kAlertWidth  (YXDScreenW - 37.5*2)
#define kAlertHeight 190.0f

#define kDefaultTitleFont BPFFONT(18)
#define kDefaultSubtitleFont LPFFONT(17)
#define kDefaultHeightContentView 17
#define kDefaultSizeButton 17

#define kXOffset 10
#define kTitleMinHeight 18.0f
#define kTitleYOffset 25.0f

#define kButtonXOffset 25
#define kButtonMargin 24.0f
#define kButtonHeight 50.0f
#define kImageYOffset 14.0f

#define TAG_CONTENT_VIEW 0x665
#define TAG_CONTENT_LABEL 0x999


@interface PeisongAlertView ()
{
    UIWindow *_keywindow;
    UIControl *_shandow;
}

@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *otherBtn;
@property (nonatomic, strong) UIView *alertContentView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *chahao;

@end


@implementation PeisongAlertView

//- (id)initWithTitle:(NSString *)title
//            message:(NSString *)content
//  cancelButtonTitle:(NSString *)leftTitle
//   otherButtonTitle:(NSString *)rigthTitle
//{
//    return [self initWithTitle:title message:content topImage:@"tixing1_w" cancelButtonTitle:leftTitle otherButtonTitle:rigthTitle];
//}





//- (UIButton *)cancelBtn{
//    if (!_cancelBtn ) {
//        _cancelBtn = [[UIButton alloc]init];
//        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        _cancelBtn.titleLabel.font = LPFFONT(kDefaultSizeButton);
//        _cancelBtn.backgroundColor = [UIColor whiteColor];
//        [_cancelBtn setTitleColor: RGB(0x8E8CA7) forState:UIControlStateNormal];
//    }
//    return _cancelBtn;
//}

//- (UIButton *)otherBtn{
//    if (!_otherBtn ) {
//        _otherBtn = [[UIButton alloc]init];
//        [_otherBtn addTarget:self action:@selector(otherBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//        _otherBtn.titleLabel.font = BPFFONT(kDefaultSizeButton);
//        _otherBtn.backgroundColor = RGB(0xFFC000);
//        [_otherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    }
//    return _otherBtn;
//}


//- (UIImageView *)topImageView{
//    if (!_topImageView) {
//        _topImageView = [[UIImageView alloc]init];
//    }
//    return _topImageView;
//}

#pragma mark --Click

//- (void)cancelBtnClicked:(id)sender{
//    [self hidden];
//    if (self.cancelBlock) {
//        self.cancelBlock();
//    }
//}
//
//- (void)otherBtnClicked:(id)sender{
//    if (self.otherBlock) {
//        [self hidden];
//        self.otherBlock();
//    }
//}






//=====================================================================================================
- (void)show{
    _shandow.alpha = 0.0;
    self.transform = CGAffineTransformMakeScale(0,0);
    WeakObj(self);
    [UIView animateWithDuration:0.35 animations:^{
        _shandow.alpha = 0.5;
        Weakself.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void)hidden{
    if (_shandow) {
        WeakObj(self);
        [self.chahao removeFromSuperview];
        self.chahao = nil;
        [UIView animateWithDuration:0.35 animations:^{
            _shandow.alpha = 0.0;
            Weakself.transform = CGAffineTransformMakeScale(0.001,0.001);
        } completion:^(BOOL finished) {
            [_shandow removeFromSuperview];
            _shandow = nil;
            [Weakself removeFromSuperview];
        }];
    }
}

- (void)initView{
    self.layer.cornerRadius = 8;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    
    _keywindow = [UIApplication sharedApplication].keyWindow;
    _shandow = [[UIControl alloc] initWithFrame:_keywindow.bounds];
    [_shandow addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    _shandow.backgroundColor = [UIColor blackColor];
    _shandow.alpha = 0.0;
    [_keywindow addSubview:_shandow];
    [_keywindow addSubview:self];
}

- (UILabel *)alertTitleLabel{
    if (!_alertTitleLabel) {
        _alertTitleLabel = [[UILabel alloc]init];
        _alertTitleLabel.font = MFFONT(18);
        _alertTitleLabel.textColor = TEXTGray_COLOR;
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitleLabel.numberOfLines = 1;
    }
    return _alertTitleLabel;
}






/**创建运费提醒弹框**/
- (id)initGetuiWithTitle:(NSString *)title
        orderProducModel:(OrderProducModel *) model{
    if (self = [super init]) {
        [self initView];
        CGFloat titleY = 22;
        //设置标题
        self.alertTitleLabel.text = title;
        self.alertTitleLabel.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, 0);
        [self.alertTitleLabel sizeToFit];
        [self addSubview:self.alertTitleLabel];
        self.alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.alertTitleLabel.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, self.alertTitleLabel.mj_h);
        titleY += self.alertTitleLabel.mj_h;
        
        //1.总计标题 和 总计运费 label  line
        UILabel *a = [UILabel new];
        a.text = @"总计";
        a.textColor = TEXTGray_COLOR;
        a.font = BPFFONT(15);
        a.frame = CGRectMake(10, titleY +10, 50, 20);
        UILabel *b = [UILabel new];
        b.text = [NSString stringWithFormat:@"￥%@",model.carriage];
        b.textColor = TEXTGray_COLOR;
        b.font = BPFFONT(15);
        b.textAlignment = NSTextAlignmentRight;
        b.frame = CGRectMake(YXDScreenW - 75 - 110, titleY +10, 100, 20);
        titleY += 10 + 20 + 5;
        UILabel *c = [UILabel new];
        c.backgroundColor = BACK_COLOR;
        c.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, 1);
        
        [self addSubview:a];
        [self addSubview:b];
        [self addSubview:c];
        titleY += 10;

        //2.运费说明
        UILabel *d = [UILabel new];
        d.text = [NSString stringWithFormat:@"%@公里[范围内]运费%@元",model.transRadius,model.transInRange];
        d.textColor = TEXTGray_COLOR;
        d.font = LPFFONT(13);
        d.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, 20);
        titleY += 20;
        UILabel *e = [UILabel new];
        e.textColor = TEXTGray_COLOR;
        e.font = LPFFONT(13);
        e.text = [NSString stringWithFormat:@"[超出部分]每公里增加%@元",model.transOutRange];
        e.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, 20);
        titleY += 20 + 10;

        [self addSubview:d];
        [self addSubview:e];

        
        //3.包装费 包装费金额 line
        UILabel *f = [UILabel new];
        f.text = @"包装费";
        f.textColor = TEXTGray_COLOR;
        f.font = BPFFONT(15);
        f.frame = CGRectMake(10, titleY+10 , 50, 20);
        UILabel *g = [UILabel new];
        g.text = [NSString stringWithFormat:@"￥%@",model.packingMoney];
        g.textColor = TEXTGray_COLOR;
        g.font = BPFFONT(15);
        g.textAlignment = NSTextAlignmentRight;
        g.frame = CGRectMake(YXDScreenW - 75 - 110, titleY +10, 100, 20);
        titleY += 10 + 20 + 5;

        UILabel *h = [UILabel new];
        h.backgroundColor = BACK_COLOR;
        h.frame = CGRectMake(20.5, titleY, YXDScreenW - 75 - 2*20.5, 1);
        
        [self addSubview:f];
        [self addSubview:g];
        [self addSubview:h];
        titleY += 10;

        //4.说明 内容
        UILabel *i = [UILabel new];
        i.text = @"说明";
        i.textColor = TEXTGray_COLOR;
        i.font = LPFFONT(13);
        i.frame = CGRectMake(20.5, titleY , 50, 15);
        titleY += 15;
        UILabel *j = [UILabel new];
        j.text = [NSString stringWithFormat:@"当前订单的配送距离为%@公里",model.transDistance];
        j.textColor = TEXTGray_COLOR;
        j.font = LPFFONT(12);
        j.frame = CGRectMake(20.5, titleY , YXDScreenW - 75 - 2*20.5, 15);
        titleY += 15;
        UILabel *k = [UILabel new];
        k.text = @"包装费:本订单收取包装袋费用0.5元";
        k.textColor = TEXTGray_COLOR;
        k.font = LPFFONT(12);
        k.frame = CGRectMake(20.5, titleY , YXDScreenW - 75 - 2*20.5, 15);
        
        [self addSubview:i];
        [self addSubview:j];
        [self addSubview:k];
        titleY += 15 + 20;

        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
//        CGFloat height = CGRectGetMaxY(self.cancelBtn.frame);
        
        self.bounds = CGRectMake(0, 0, (YXDScreenW - 75), titleY);
        CGFloat x = _keywindow.center.x;
        CGFloat y = _keywindow.center.y;
        self.center = CGPointMake(x, y - 50);
        
        self.chahao = [UIImageView new];
        self.chahao.image = IMAGECACHE(@"icon_44");
        [_keywindow addSubview:self.chahao];
        [self.chahao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset = 0;
            make.top.equalTo(self.mas_bottom).offset = 20;
        }];

    }
    return self;

    
}

@end
