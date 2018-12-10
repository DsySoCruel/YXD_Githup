//
//  LoginView.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClicksAlertBlock)(NSString *textField1Text, NSString *textField2Text);

@interface LoginView : UIView

@property (nonatomic, copy, readonly) ClicksAlertBlock clickBlock;

//忘记密码
@property (nonatomic, copy) void(^forgetBlock)(void);//登录主界面为了忘记密码搞点事情

//注册
@property (nonatomic, copy) void(^registerBlock)(void);//登录主界面切换登录和注册

//点击登录:验证之后的返回
- (void)setClickBlock:(ClicksAlertBlock)clickBlock;

@end
