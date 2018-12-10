//
//  LoginViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "RegisterView.h"
#import "FindPasswordController.h"

@interface LoginViewController ()<UINavigationControllerDelegate>

@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) LoginView *loginView;
@property (nonatomic,strong) RegisterView *registerView;

@end

@implementation LoginViewController

+ (YXDNavigationController *)shareLoginVC{
    LoginViewController *login = [[LoginViewController alloc] init];
    YXDNavigationController *nav = [[YXDNavigationController alloc] initWithRootViewController:login];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    [self setupUI];
    [self setupLayout];
}

- (void)setupUI{
    
    self.backImageView = [UIImageView new];
    self.backImageView.image = IMAGECACHE(@"login_back");
    self.backImageView.userInteractionEnabled = YES;
    [self.view addSubview:self.backImageView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:IMAGECACHE(@"icon_44") forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.iconImageView = [UIImageView new];
    self.iconImageView.image = IMAGECACHE(@"login_icon");
    [self.view addSubview:self.iconImageView];
    
    //设置登录界面
    self.loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 500)];
    [self.view addSubview:self.loginView];
    WeakObj(self)
    self.loginView.registerBlock = ^{
        Weakself.loginView.hidden = YES;
        Weakself.registerView.hidden = NO;
    };
    [self.loginView setClickBlock:^(NSString *textField1Text, NSString *textField2Text) {        
        //进行登录操作吧
        [MBHUDHelper showLoadingHUDView:[BaseViewController topViewController].view withText:@"登录中"];
        
        //拼接参数
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"loginName"] = textField1Text;
        parames[@"loginPwd"] = textField2Text;
        
        StrongObj(Weakself);
        [[NetWorkManager shareManager] POST:USER_login parameters:parames successed:^(id json) {
            if (json) {
                [MBHUDHelper showSuccess:@"登录成功！"];
                NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:json];
                YXDUserInfoModel *account = [YXDUserInfoModel mj_objectWithKeyValues:mutableDic];
                NSString *jsonstr = [account toJSONString];
                [[NSUserDefaults standardUserDefaults]setValue:jsonstr forKey:@"userInfoKey"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMyUI" object:nil];
                [strongWeakself dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
    self.loginView.forgetBlock =^{
        FindPasswordController *vc = [FindPasswordController new];
        [Weakself.navigationController pushViewController:vc animated:YES];
    };
    
    //设置登录界面
    self.registerView = [[RegisterView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 500)];
    [self.view addSubview:self.registerView];
    self.registerView.loginBlock = ^{
        Weakself.registerView.hidden = YES;
        Weakself.loginView.hidden = NO;
    };
    self.registerView.hidden = YES;
}

- (void)setupLayout{
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 15;
        make.top.offset = 30 + SafeTopSpace;
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.offset(100 + SafeTopSpace);
    }];
    
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.iconImageView.mas_bottom).offset = 0;
        make.width.offset = YXDScreenW;
    }];
    
    [self.registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset = 0;
        make.top.equalTo(self.iconImageView.mas_bottom).offset = 0;
        make.width.offset = YXDScreenW;
    }];
    
}

- (void)backButtonAction:(UIButton *)sender{
    if (self.isNeedSelectIndexOne) {//拒绝登录定位到首页
        UITabBarController *tab = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        tab.selectedIndex = 0;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
