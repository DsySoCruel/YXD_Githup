//
//  LoginTextField.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UITextField

//创建一个带左图片的输入框(带边框)
+ (LoginTextField *)createTextFieldWithHolderStr:(NSString *)holderStr image:(UIImage *)image andFrame:(CGRect)frame;

//创建一个带左图片的输入框(带下划线)
+ (LoginTextField *)createLineTextFieldWithHolderStr:(NSString *)holderStr image:(UIImage *)image andFrame:(CGRect)frame;

//创建一个+86的输入框(带边框)
+ (LoginTextField *)createTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame;

//创建一个普通的输入框(带边框)
+ (LoginTextField *)createNormalTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame;

//创建一个普通的输入框(不带输入框)
+ (LoginTextField *)createNOboderTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame;

@end
