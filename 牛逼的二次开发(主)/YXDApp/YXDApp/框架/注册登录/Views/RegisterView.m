//
//  RegisterView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "RegisterView.h"
#import "LoginTextField.h"
#import "YXDButton.h"


@interface RegisterView()

@property(nonatomic,weak)LoginTextField *phoneNumTF;

@property(nonatomic,weak)LoginTextField *codeTF;

@property(nonatomic,weak)YXDButton *codeButton;

@property(nonatomic,weak)LoginTextField *passwordTF;

@property(nonatomic,weak)YXDButton *registerButton;

@end


@implementation RegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
//        //注册通知 接受注册成功后的回掉
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptAccoutandPassword:) name:@"acceptAccoutandPassword" object:nil];
    }
    return self;
}

- (void)creatSubViews{
    //上半部
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, YXDScreenW, 500)];
    [self addSubview:firstView];
    
    CGFloat textFileX = 50;
    CGFloat textFildW = self.rcm_width - textFileX * 2;
    CGFloat textFildH = 40;
    CGFloat padding = 20;
    
    LoginTextField *phoneNumTF = [LoginTextField createLineTextFieldWithHolderStr:@"手机号" image:IMAGECACHE(@"icon_5")
                                                                         andFrame:CGRectMake(textFileX, 0, textFildW, textFildH)];
    phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [firstView addSubview:phoneNumTF];
    self.phoneNumTF = phoneNumTF;
    //添加改变通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:phoneNumTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, textFildH - 10, textFildW - 20, 0.5)];
    line1.backgroundColor = BACK_COLOR;
    [firstView addSubview:line1];
    
    
    LoginTextField *codeTF = [LoginTextField createLineTextFieldWithHolderStr:@"短信验证码" image:IMAGECACHE(@"icon_6")  andFrame:CGRectMake(textFileX, phoneNumTF.rcm_bottom + 10, textFildW - 110, textFildH)];
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [firstView addSubview:codeTF];
    self.codeTF = codeTF;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:codeTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, phoneNumTF.rcm_bottom + 10 + textFildH - 10, textFildW - 20, 0.5)];
    line2.backgroundColor = BACK_COLOR;
    [firstView addSubview:line2];
    
    //获取验证码
    YXDButton *codeButton = [YXDButton shareButton];
    self.codeButton = codeButton;
    [codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    codeButton.titleLabel.font = LPFFONT(12);
    [codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeButton.backgroundColor = THEME_COLOR;
    //    forgetPassBT.rcm_y = line2.rcm_bottom + 10;
    codeButton.frame = CGRectMake(0, 0, 90, 26);
    codeButton.layer.cornerRadius = 13;
    codeButton.rcm_centerY = codeTF.rcm_centerY - 10;
    codeButton.rcm_x = line2.rcm_right - codeButton.rcm_width;
//    [codeButton addTarget:self action:@selector(codeButton:) forControlEvents:UIControlEventTouchUpInside];
    WeakObj(self);
    codeButton.block = ^(YXDButton *sender){
        [Weakself getCode:sender];
//        [Weakself clickButton:getCode];
    };
    [firstView addSubview:codeButton];
    
    LoginTextField *passwordTF = [LoginTextField createLineTextFieldWithHolderStr:@"设置密码" image:IMAGECACHE(@"login_mima")  andFrame:CGRectMake(textFileX, codeTF.rcm_bottom + 10, textFildW, textFildH)];
    passwordTF.secureTextEntry = YES;
    [firstView addSubview:passwordTF];
    self.passwordTF = passwordTF;
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:passwordTF];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, codeTF.rcm_bottom + 10 + textFildH - 10, textFildW - 20, 0.5)];
    line3.backgroundColor = BACK_COLOR;
    [firstView addSubview:line3];
    
    //注册
    YXDButton *loginButton = [YXDButton shareButton];
    loginButton.frame = CGRectMake(textFileX + 10, passwordTF.rcm_bottom + padding , textFildW - 20, 35);
    loginButton.backgroundColor = THEME_COLOR;
    [loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [loginButton setTintColor:[UIColor whiteColor]];
    [loginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:loginButton];
//    _loginButton = loginButton;
    
    
    //协议
    UILabel *bb = [[UILabel alloc] initWithFrame:CGRectMake(textFileX, loginButton.rcm_bottom + 5, textFildW, 15)];
    bb.text = @"点击注册，即表示您同意《买点儿服务协议》";
    bb.textAlignment = NSTextAlignmentCenter;
    bb.textColor = TEXTGray_COLOR;
    bb.font = LPFFONT(10);
    [firstView addSubview:bb];
    
    //还没有账号，立即注册
    UILabel *aa = [UILabel new];
    aa.text = @"已有账号，";
    aa.textAlignment = NSTextAlignmentRight;
    aa.font = LPFFONT(12);
    aa.frame = CGRectMake(textFileX + 20, bb.rcm_bottom + padding, (textFildW - 20) * 0.5, 15);
    [firstView addSubview:aa];
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(aa.rcm_right, bb.rcm_bottom + padding, 50, 15)];
    [firstView addSubview:registerButton];
    //    [registerButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //button 折行显示设置
    /*
     NSLineBreakByWordWrapping = 0,         // Wrap at word boundaries, default
     NSLineBreakByCharWrapping,     // Wrap at character boundaries
     NSLineBreakByClipping,     // Simply clip 裁剪从前面到后面显示多余的直接裁剪掉
     
     文字过长 button宽度不够时: 省略号显示位置...
     NSLineBreakByTruncatingHead,   // Truncate at head of line: "...wxyz" 前面显示
     NSLineBreakByTruncatingTail,   // Truncate at tail of line: "abcd..." 后面显示
     NSLineBreakByTruncatingMiddle  // Truncate middle of line:  "ab...yz" 中间显示省略号
     */
    registerButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    // you probably want to center it
    registerButton.titleLabel.textAlignment = NSTextAlignmentRight; // if you want to
    registerButton.titleLabel.font = LPFFONT(12);
    
    // underline Terms and condidtions
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"直接登录"];
    
    //设置下划线...
    /*
     NSUnderlineStyleNone                                    = 0x00, 无下划线
     NSUnderlineStyleSingle                                  = 0x01, 单行下划线
     NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
     NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
     */
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:THEME_COLOR  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:THEME_COLOR range:(NSRange){0,[tncString length]}];
    [registerButton setAttributedTitle:tncString forState:UIControlStateNormal];
    
    firstView.rcm_height = registerButton.rcm_bottom;
    
}

- (void)registerButtonAction:(UIButton *)sender{
    if (self.loginBlock) {
        self.loginBlock();
    }
}

//- (void)setClickBlock:(ClicksAlertBlock)clickBlock{
//    _clickBlock = clickBlock;
//}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.phoneNumTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.window resignFirstResponder];
}


//- (void)textDidChange{
//    if (self.phoneNumTF.text.length && self.passwordTF.text.length) {
//
//        _loginButton.userInteractionEnabled = YES;
//        _loginButton.backgroundColor = THEME_COLOR;
//
//    }else{
//        _loginButton.userInteractionEnabled = NO;
//        _loginButton.backgroundColor = UNAble_color;
//    }
//}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark - 逻辑业务处理层

//获取验证码
- (void)getCode:(UIButton *)sender{
    
    if (![NSString isMobileNumber:self.phoneNumTF.text]) {
        [MBHUDHelper showWarningWithText:@"手机号码格式不对"];
        return;
    }
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userPhone"] = self.phoneNumTF.text;;
    parames[@"type"] = @"1";
    
    [[NetWorkManager shareManager] POST:USER_SendCodeURL parameters:parames successed:^(id json) {
        if (json) {
            sender.userInteractionEnabled = NO;
            sender.backgroundColor = UNAble_color;
            
            __block int timeout=60; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //倒计时结束后,重新设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
                        sender.userInteractionEnabled = YES;
                        sender.backgroundColor = THEME_COLOR;
                    });
                }else{
                    //                int minutes = timeout / 60;
                    //                int seconds = timeout % 60;
                    NSString * strTime = [NSString stringWithFormat:@"%.2ds后重发",timeout];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [sender setTitle:strTime forState:UIControlStateNormal];
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);

        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

//注册按钮执行方法
- (void)LoginAction:(UIButton *)sender{
    [self.phoneNumTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    //检验输入的格式
    if (![NSString isMobileNumber:self.phoneNumTF.text]) {
        [MBHUDHelper showWarningWithText:@"手机号码格式不对"];
        return;
    }
    
    if (self.codeTF.text.length < 6) {
        [MBHUDHelper showError:@"请输入正确验证码"];
        return;
    }
    
    if (![NSString checkPassword:self.passwordTF.text]) {
        [MBHUDHelper showError:@"密码格式不符合"];
        return;
    }
    
    //拼接参数
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"loginName"] = self.phoneNumTF.text;
    parames[@"loginPwd"] = self.passwordTF.text;
    parames[@"mobileCode"] = self.codeTF.text;
    
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_RegisterURL parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"注册成功,请登录"];
            //模拟注册成功
            if (Weakself.loginBlock) {
                Weakself.loginBlock();
            }
        }
    } failure:^(NSError *error) {

    }];

}


@end
