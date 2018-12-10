//
//  LoginTextField.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (instancetype)init{
    if (self = [super init]) {
        
        self.font = YXDBigFont;
        self.textColor = TEXT_COLOR;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
        
        self.layer.borderColor = BACK_COLOR.CGColor;
        
    }
    return self;
}



//创建一个带左突变的输入框

+ (LoginTextField *)createTextFieldWithHolderStr:(NSString *)holderStr image:(UIImage *)image  andFrame:(CGRect)frame{
    
    LoginTextField *textField = [[LoginTextField alloc] init];
    textField.frame = frame;
    textField.placeholder = holderStr;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.height, frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height * .3 , frame.size.height * .3 , frame.size.height - frame.size.height * .6, frame.size.height - frame.size.height * .6)];
    imgUser.image = image;
    [textField.leftView addSubview:imgUser];
    return textField;
}

+ (LoginTextField *)createLineTextFieldWithHolderStr:(NSString *)holderStr image:(UIImage *)image andFrame:(CGRect)frame{
    LoginTextField *textField = [[LoginTextField alloc] init];
    textField.frame = frame;
    textField.placeholder = holderStr;
    textField.layer.cornerRadius = 0;
    textField.layer.borderWidth = 0;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.height, frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.height * .3 , frame.size.height * .3 , frame.size.height - frame.size.height * .6, frame.size.height - frame.size.height * .6)];
    imgUser.image = image;
    [textField.leftView addSubview:imgUser];
    return textField;
}


+ (LoginTextField *)createTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame{
    
    LoginTextField *textField = [[LoginTextField alloc] init];
    textField.frame = frame;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = holderStr;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,frame.size.height + 5, frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    UILabel *conLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.height * .1, frame.size.height * .1, frame.size.height, frame.size.height - frame.size.height * .2)];
    conLabel.text = @"+86";
    [textField.leftView addSubview:conLabel];
    return textField;
    
}

+ (LoginTextField *)createNormalTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame{
    LoginTextField *textField = [[LoginTextField alloc] init];
    textField.frame = frame;
    textField.placeholder = holderStr;
    
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 , frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}


+ (LoginTextField *)createNOboderTextFieldWithHolderStr:(NSString *)holderStr  andFrame:(CGRect)frame{
    
    LoginTextField *textField = [[LoginTextField alloc] init];
    textField.frame = frame;
    textField.placeholder = holderStr;
    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15 , frame.size.height)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    //    textField.layer.borderWidth = 0;
    textField.layer.cornerRadius = 0;
    textField.backgroundColor = [UIColor whiteColor];
    
    return textField;
    
}



@end
