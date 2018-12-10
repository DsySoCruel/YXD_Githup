//
//  StarView.h
//  Pugongying
//
//  Created by app on 15/11/9.
//  Copyright (c) 2015年 新乡市蒲公英网络技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarView : UIView

+ (instancetype)starWithFrame:(CGRect)frame;

@property (nonatomic, assign) CGFloat avgScore;//分值

@end
