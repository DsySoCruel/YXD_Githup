//
//  LoginView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "LoginView.h"
#import "LoginTextField.h"
#import "YXDButton.h"
#import <UMShare/UMShare.h>


@interface LoginView()

@property(nonatomic,weak)LoginTextField *phoneNumTF;

@property(nonatomic,weak)LoginTextField *passwordTF;

@property (nonatomic,weak) YXDButton *loginButton;

@property (nonatomic,strong) UIView *line1;
@property (nonatomic,strong) UIView *line2;
@property (nonatomic,strong) UILabel *other;

@property (nonatomic,strong) UIButton *wxButton;

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
        //注册通知 接受注册成功后的回掉
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptAccoutandPassword:) name:@"acceptAccoutandPassword" object:nil];
    }
    return self;
}


- (void)acceptAccoutandPassword:(NSNotification *)sender{
    
    self.phoneNumTF.text = sender.userInfo[@"phoneNum"];
    self.passwordTF.text = sender.userInfo[@"passWord"];
    
}


- (void)creatSubViews{
    //上半部
    UIView *firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, YXDScreenW, 500)];
    [self addSubview:firstView];
    
    CGFloat textFileX = 50;
    CGFloat textFildW = self.rcm_width - textFileX * 2;
    CGFloat textFildH = 40;
    CGFloat padding = 20;
    
    LoginTextField *phoneNumTF = [LoginTextField createLineTextFieldWithHolderStr:@"手机号" image:IMAGECACHE(@"login_ren")
                                                                     andFrame:CGRectMake(textFileX, 0, textFildW, textFildH)];
    phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [firstView addSubview:phoneNumTF];
    self.phoneNumTF = phoneNumTF;
    //添加改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:phoneNumTF];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, textFildH - 10, textFildW - 20, 0.5)];
    line1.backgroundColor = BACK_COLOR;
    [firstView addSubview:line1];
    
    
    LoginTextField *passwordTF = [LoginTextField createLineTextFieldWithHolderStr:@"密码" image:IMAGECACHE(@"login_mima")  andFrame:CGRectMake(textFileX, phoneNumTF.rcm_bottom + 10, textFildW, textFildH)];
    passwordTF.secureTextEntry = YES;
    [firstView addSubview:passwordTF];
    self.passwordTF = passwordTF;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:passwordTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, phoneNumTF.rcm_bottom + 10 + textFildH - 10, textFildW - 20, 0.5)];
    line2.backgroundColor = BACK_COLOR;
    [firstView addSubview:line2];
    
    //忘记密码
    YXDButton *forgetPassBT = [YXDButton shareButton];
    [forgetPassBT setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetPassBT.titleLabel.font = LPFFONT(13);
    [forgetPassBT setTitleColor:THEME_COLOR forState:UIControlStateNormal];
    [forgetPassBT sizeToFit];
    forgetPassBT.rcm_y = line2.rcm_bottom + 10;
    forgetPassBT.rcm_x = line2.rcm_right - forgetPassBT.rcm_width;
    forgetPassBT.block = ^(YXDButton *sender){
        if (self.forgetBlock) {
            self.forgetBlock();
        }
    };
    [firstView addSubview:forgetPassBT];
    
    //登录
    YXDButton *loginButton = [YXDButton shareButton];
    loginButton.frame = CGRectMake(textFileX + 10, passwordTF.rcm_bottom + padding * 2, textFildW - 20, 35);
    loginButton.backgroundColor = THEME_COLOR;
//    loginButton.userInteractionEnabled = NO;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTintColor:[UIColor whiteColor]];
    [loginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:loginButton];
    _loginButton = loginButton;
    
    //还没有账号，立即注册
    UILabel *aa = [UILabel new];
    aa.text = @"还没有账号，";
    aa.textAlignment = NSTextAlignmentRight;
    aa.font = LPFFONT(12);
    aa.frame = CGRectMake(textFileX + 20, loginButton.rcm_bottom + padding, (textFildW - 20) * 0.5, 15);
    [firstView addSubview:aa];
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(aa.rcm_right, loginButton.rcm_bottom + padding, 50, 15)];
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
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"立即注册"];
    
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
    
    
    self.line1 = [UIView new];
    self.line1.backgroundColor = BACK_COLOR;
    [self addSubview:self.line1];
    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self addSubview:self.line2];
    self.other = [UILabel new];
    self.other.text = @"其他登录方式";
    self.other.textColor = TEXTGray_COLOR;
    self.other.font = LPFFONT(10);
    [self addSubview:self.other];
    
    [self.other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.equalTo(firstView.mas_bottom).offset = 35;
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.other.mas_left).offset = -10;
        make.centerY.equalTo(self.other);
        make.width.offset = 50;
        make.height.offset = 0.5;
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.other.mas_right).offset = 10;
        make.centerY.equalTo(self.other);
        make.width.offset = 50;
        make.height.offset = 0.5;
    }];
    
    self.wxButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.wxButton.backgroundColor = [UIColor redColor];
    [self.wxButton setImage:IMAGECACHE(@"speed_login") forState:UIControlStateNormal];
    [self addSubview:self.wxButton];
    [self.wxButton addTarget:self action:@selector(wxButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.wxButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.width.height.offset = 40;
        make.top.equalTo(firstView.mas_bottom).offset = 60;
    }];
}

- (void)registerButtonAction:(UIButton *)sender{
    if (self.registerBlock) {
        self.registerBlock();
    }
}

- (void)LoginAction:(UIButton *)sender{
    [self.phoneNumTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    //检验输入的格式
    if (![NSString isMobileNumber:self.phoneNumTF.text]) {
        [MBHUDHelper showWarningWithText:@"手机号码格式不对"];
        return;
    }
    
    if (![NSString checkPassword:self.passwordTF.text]) {
        [MBHUDHelper showWarningWithText:@"密码格式不对"];
        return;
    }
    
    if (_clickBlock) {
        _clickBlock(self.phoneNumTF.text, self.passwordTF.text);
    }
    
}
- (void)setClickBlock:(ClicksAlertBlock)clickBlock{
    _clickBlock = clickBlock;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.phoneNumTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.window resignFirstResponder];
}


- (void)textDidChange{
    if (self.phoneNumTF.text.length && self.passwordTF.text.length) {
        
        _loginButton.userInteractionEnabled = YES;
        _loginButton.backgroundColor = THEME_COLOR;
        
    }else{
        _loginButton.userInteractionEnabled = NO;
        _loginButton.backgroundColor = UNAble_color;
    }
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



- (void)fastLoginAction:(YXDButton *)sender{
    
    NSUInteger numberOfbutton = sender.tag  - 99;
    
    switch (numberOfbutton) {
        case 0:
//            [self getUserInfoForPlatform:UMSocialPlatformType_QQ];
            
            break;
        case 1:
//            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
            
            
            break;
        case 2:
//            [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
            
            break;
            
        default:
            break;
    }
    
    
}

- (void)wxButtonAction{
    [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
}

- (void)setupAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [[BaseViewController topViewController] presentViewController:alert animated:YES completion:nil];
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"error: %@", error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            
            //进行微信登录
            //进行登录操作吧
            [MBHUDHelper showLoadingHUDView:[BaseViewController topViewController].view withText:@"登录中"];
            
            //拼接参数
            NSMutableDictionary *parames = [NSMutableDictionary dictionary];
            parames[@"openId"] = resp.openid;
            parames[@"userName"] = resp.name;
            parames[@"userPhoto"] = resp.iconurl;
            
            [[NetWorkManager shareManager] POST:USER_wxlogin parameters:parames successed:^(id json) {
                if (json) {
                    [MBHUDHelper showSuccess:@"登录成功！"];
                    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:json];
                    YXDUserInfoModel *account = [YXDUserInfoModel mj_objectWithKeyValues:mutableDic];
                    NSString *jsonstr = [account toJSONString];
                    [[NSUserDefaults standardUserDefaults]setValue:jsonstr forKey:@"userInfoKey"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMyUI" object:nil];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }
            } failure:^(NSError *error) {
                
            }];
        }
    }];
}

//登录
- (void)loginWithImage:(NSString *)imageName
              withCode:(NSString *)codeLogo
          withuserName:(NSString *)userName
{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"codeLogo"] = codeLogo;
    parames[@"loginType"] = @"1"; //微信 1  新浪 2  QQ 3
    parames[@"type"] = @"1";
    parames[@"userImage"] = imageName;
    parames[@"userName"] = userName;
    
//    [[NetWorkManager shareManager] POST:USER_otherLogin parameters:parames successed:^(id json) {
//        
//        NSLog(@"%@",json);
//        
//        if ([json[@"success"] boolValue]) {
//            
//            //保存登录信息
//            
//            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:json];
//            
//            [mutableDic setObject:@"" forKey:@"userImageUrl"];
//            
//            [UserDefaults setObject:mutableDic forKey:@"userInfoKey"];
//            
//            [UserDefaults synchronize];
//            
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMyUI" object:self];
//            
//            [MBHUDHelper hideHUDView];
//            
//            [self.viewController dismissViewControllerAnimated:YES completion:nil];
//            
//            
//        }else{
//            [MBHUDHelper hideHUDView];
//            
////            [MBHUDHelper showWarningWithText:RCMStateDic[json[@"message"]]];
//        }
//        
//        
//        [MBHUDHelper hideHUDView];
//        
//    } failure:^(NSError *error) {
//        
//    }];
    
}



@end
