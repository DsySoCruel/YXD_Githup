//
//  FindPasswordController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/11.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "FindPasswordController.h"
#import "LoginTextField.h"
#import "YXDButton.h"


@interface FindPasswordController ()

@property(nonatomic,strong)UIView *oneView;

@property(nonatomic,weak)LoginTextField *phoneNumTF;

@property(nonatomic,weak)LoginTextField *codeTF;

@property(nonatomic,weak)YXDButton *codeButton;

@property(nonatomic,weak)LoginTextField *passwordTF;

@property(nonatomic,weak)YXDButton *commitButton;


@end

@implementation FindPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    [self setUpUI];
    [self setUpLayout];
}

- (void)setUpUI{
    self.oneView = [UIView new];
    self.oneView.backgroundColor = BACK_COLOR;
    [self.view addSubview:self.oneView];
    [self.oneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 10;
        make.top.offset = 64;
    }];
    
    CGFloat textFileX = 20;
    CGFloat textFildW = YXDScreenW - textFileX * 2;
    CGFloat textFildH = 40;
    CGFloat padding = 20;
    
    LoginTextField *phoneNumTF = [LoginTextField createLineTextFieldWithHolderStr:@"手机号" image:IMAGECACHE(@"icon_5")
                                                                         andFrame:CGRectMake(textFileX, 90, textFildW, textFildH)];
    phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:phoneNumTF];
    self.phoneNumTF = phoneNumTF;
    //添加改变通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:phoneNumTF];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, phoneNumTF.rcm_bottom - 10, textFildW - 20, 0.5)];
    line1.backgroundColor = BACK_COLOR;
    [self.view addSubview:line1];
    
    
    LoginTextField *codeTF = [LoginTextField createLineTextFieldWithHolderStr:@"短信验证码" image:IMAGECACHE(@"icon_6")  andFrame:CGRectMake(textFileX, phoneNumTF.rcm_bottom + 15, textFildW - 110, textFildH)];
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:codeTF];
    self.codeTF = codeTF;
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:codeTF];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, codeTF.rcm_bottom - 10, textFildW - 20, 0.5)];
    line2.backgroundColor = BACK_COLOR;
    [self.view addSubview:line2];
    
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
    [self.view addSubview:codeButton];
    
    LoginTextField *passwordTF = [LoginTextField createLineTextFieldWithHolderStr:@"设置新密码" image:IMAGECACHE(@"login_mima")  andFrame:CGRectMake(textFileX, codeTF.rcm_bottom + 15, textFildW, textFildH)];
    passwordTF.secureTextEntry = YES;
    [self.view addSubview:passwordTF];
    self.passwordTF = passwordTF;
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:passwordTF];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(textFileX + 10, passwordTF.rcm_bottom - 10, textFildW - 20, 0.5)];
    line3.backgroundColor = BACK_COLOR;
    [self.view addSubview:line3];
    
    //注册
    YXDButton *loginButton = [YXDButton shareButton];
    loginButton.frame = CGRectMake(textFileX + 10, passwordTF.rcm_bottom + padding + 10 , textFildW - 20, 40);
    loginButton.backgroundColor = THEME_COLOR;
    [loginButton setTitle:@"确定" forState:UIControlStateNormal];
    [loginButton setTintColor:[UIColor whiteColor]];
    [loginButton addTarget:self action:@selector(LoginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
}
- (void)setUpLayout{
    
}

#pragma mark -逻辑处理层
//获取验证码
- (void)getCode:(UIButton *)sender{
    
    if (![NSString isMobileNumber:self.phoneNumTF.text]) {
        [MBHUDHelper showWarningWithText:@"手机号码格式不对"];
        return;
    }
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userPhone"] = self.phoneNumTF.text;;
    parames[@"type"] = @"3";
    
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
    [[NetWorkManager shareManager] POST:USER_UpdatePW parameters:parames successed:^(id json) {
        if (json) {
            [MBHUDHelper showSuccess:@"密码修改成功"];
            [Weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];

}


@end
