//
//  YXDSearchViewBar.h
//  YXDApp
//
//  Created by daishaoyang on 2018/5/7.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXDSearchViewBar : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIImage *searchImage;
- (void)searchShouldChangeText:(void(^)(UITextField *obj,NSRange range,NSString *string))block;
- (void)resignFirstResponder;
- (void)cleanText;


@end
