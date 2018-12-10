//
//  GoodControllerHeadView.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodControllerModel;

@interface GoodControllerHeadView : UIView

@property (nonatomic, strong) GoodControllerModel *goodsModel;

@property (nonatomic, copy) void(^selectGoodBlock)(void);//添加到购物车里

@end
