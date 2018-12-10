//
//  AddIdeaBackController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "AddIdeaBackController.h"
#import "YXdTextView.h"
#import "YXDButton.h"


@interface AddIdeaBackController ()<UITextViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UIView *firstOneView;
@property (nonatomic,strong) UILabel *oneLabel;
@property (nonatomic,strong) UILabel *one0neLabel;
@property (nonatomic,strong) UIImageView *oneImageView;
@property (nonatomic,strong) UIView *firstTwoView;
@property (nonatomic,strong) UILabel *twoLabel;
@property (nonatomic,strong) UILabel *twotwoLabel;
@property (nonatomic,strong) UIImageView *twoImageView;

@property (nonatomic,strong) UILabel *secondLabel;
//内容区
@property (nonatomic,strong) YXdTextView *textView;

//请输入手机号（选填）
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UITextField *phoneField;
//提交按钮
@property (nonatomic,strong) YXDButton *commintButton;

@end

@implementation AddIdeaBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加意见反馈";
    [self setupUI];
    [self setuoLayout];
}

- (void)setupUI{
    self.mainScrollView = [UIScrollView new];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.contentSize = CGSizeMake(YXDScreenW, YXDScreenH + 1 );
    self.mainScrollView.backgroundColor = BACK_COLOR;
    
    self.firstLabel = [UILabel new];
    self.firstLabel.text = @"请选择反馈问题的类型";
    self.firstLabel.font = LPFFONT(13);
    self.firstLabel.textColor = TEXTBlack_COLOR;
    [self.mainScrollView addSubview:self.firstLabel];
    
    self.firstOneView = [UIView new];
    self.firstOneView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.firstOneView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstOneViewAction)];
    [self.firstOneView addGestureRecognizer:tap1];

    
    self.oneLabel = [UILabel new];
    self.oneLabel.textColor = TEXTBlack_COLOR;
    self.oneLabel.font = LPFFONT(15);
    self.oneLabel.text = @"功能异常";
    [self.firstOneView addSubview:self.oneLabel];
    
    self.one0neLabel = [UILabel new];
    self.one0neLabel.textColor = TEXTGray_COLOR;
    self.one0neLabel.font = LPFFONT(12);
    self.one0neLabel.text = @"不能使用现有功能";
    [self.firstOneView addSubview:self.one0neLabel];
    
    self.oneImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_62")];
    [self.firstOneView addSubview:self.oneImageView];
    
    self.firstTwoView = [UIView new];
    self.firstTwoView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.firstTwoView];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(firstTwoViewAction)];
    [self.firstTwoView addGestureRecognizer:tap2];
    
    self.twoLabel = [UILabel new];
    self.twoLabel.textColor = TEXTBlack_COLOR;
    self.twoLabel.font = LPFFONT(15);
    self.twoLabel.text = @"其他问题";
    [self.firstTwoView addSubview:self.twoLabel];
    
    self.twotwoLabel = [UILabel new];
    self.twotwoLabel.textColor = TEXTGray_COLOR;
    self.twotwoLabel.font = LPFFONT(12);
    self.twotwoLabel.text = @"用的不爽.功能建议都提出来吧";
    [self.firstTwoView addSubview:self.twotwoLabel];
    
    self.twoImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_62")];
    [self.firstTwoView addSubview:self.twoImageView];
    self.twoImageView.hidden = YES;

    
    self.secondLabel = [UILabel new];
    self.secondLabel.text = @"问题及意见";
    self.secondLabel.font = LPFFONT(13);
    self.secondLabel.textColor = TEXTBlack_COLOR;
    [self.mainScrollView addSubview:self.secondLabel];
    
    
    self.textView = [YXdTextView new];
    self.textView.delegate = self;
    self.textView.alwaysBounceVertical = YES; // 垂直方向永远可以滚动(弹簧效果)
    self.textView.placeholder = @"请输入您的反馈建议";
    self.textView.font = [UIFont systemFontOfSize:15];
    self.textView.frame = CGRectMake(0, 0, self.view.rcm_width - 20, 200);
    [self.mainScrollView addSubview:self.textView];

    

//    self.bottomView = [UIView new];
//    self.bottomView.backgroundColor = [UIColor whiteColor];
//    [self.mainScrollView addSubview:self.bottomView];
//    [self.bottomView addSubview:self.phoneField];
    self.phoneField = [UITextField new];
    self.phoneField.backgroundColor = [UIColor whiteColor];
    self.phoneField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneField.font = SFONT(13);
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField.placeholder = @"请输入您的手机号（选填）";
    [self.mainScrollView addSubview:self.phoneField];

    
    
    
    //注册
    self.commintButton = [YXDButton shareButton];
//    loginButton.frame = CGRectMake(textFileX + 10, codeTF.rcm_bottom + padding + 10 , textFildW - 20, 40);
    self.commintButton.backgroundColor = THEME_COLOR;
    [self.commintButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.commintButton setTintColor:[UIColor whiteColor]];
    [self.commintButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.commintButton];
    
    
    // 2.监听textView文字的改变
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self.textView];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)setuoLayout{
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.offset = 0;
    }];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.offset = 15;
    }];
    [self.firstOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.height.offset = 40;
        make.width.offset = YXDScreenW;
        make.top.equalTo(self.firstLabel.mas_bottom).offset = 5;
    }];
    [self.oneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 60;
        make.centerY.offset = 0;
    }];
    [self.one0neLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneLabel.mas_right).offset = 10;
        make.centerY.offset = 0;
    }];
    [self.oneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -15;
    }];
    
    [self.firstTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.height.offset = 40;
        make.width.offset = YXDScreenW;
        make.top.equalTo(self.firstOneView.mas_bottom).offset = 1;
    }];
    [self.twoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = 60;
        make.centerY.offset = 0;
    }];
    [self.twotwoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoLabel.mas_right).offset = 10;
        make.centerY.offset = 0;

    }];
    [self.twoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset = 0;
        make.right.offset = -15;
    }];

    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.top.equalTo(self.firstTwoView.mas_bottom).offset = 15;
    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = YXDScreenW - 20;;
        make.top.equalTo(self.secondLabel.mas_bottom).offset = 5;
        make.height.offset = 200;
    }];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = YXDScreenW - 20;
        make.top.equalTo(self.textView.mas_bottom).offset = 15;
        make.height.offset = 35;
    }];
    [self.commintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = YXDScreenW -20;
        make.top.equalTo(self.phoneField.mas_bottom).offset = 25;
        make.height.offset = 35;
    }];

}



- (void)LoginAction:(UIButton *)sender{
    
    if (!self.textView.text.length) {
        [MBHUDHelper showError:@"请写下您想说的话"];
        return;
    }
    
    if (self.phoneField.text.length) {
        if (![NSString isMobileNumber:self.phoneField.text]) {
            [MBHUDHelper showWarningWithText:@"手机号码格式不对"];
            return;
        }
    }
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"feedbackType"] = self.oneImageView.hidden ? @"2" : @"1";
    parames[@"content"] = self.textView.text;
    if (self.phoneField.text.length) {
        parames[@"userPhone"] = self.phoneField.text;
    }
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_feedback parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"意见反馈成功"];
            //刷新反馈列表
            if (Weakself.addSuccessBlock) {
                Weakself.addSuccessBlock();
            }
            [Weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)firstOneViewAction{
    self.twoImageView.hidden = YES;
    self.oneImageView.hidden = NO;
}
- (void)firstTwoViewAction{
    self.oneImageView.hidden = YES;
    self.twoImageView.hidden = NO;
}

@end
