//
//  HomeSeckillController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//  秒杀特惠 团购也是这样

#import <UIKit/UIKit.h>

//完成的功能类型
typedef NS_ENUM(NSInteger,SeckillType) {
    SeckillTypeOne,//秒杀
    SeckillTypeTwo,//团购
};

@interface HomeSeckillController : BaseViewController

@property (nonatomic, assign) SeckillType seckillType;

@end
