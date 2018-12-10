//
//  RegisterView.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView

//登录
@property (nonatomic, copy) void(^loginBlock)(void);//登录主界面切换登录和注册

@end
