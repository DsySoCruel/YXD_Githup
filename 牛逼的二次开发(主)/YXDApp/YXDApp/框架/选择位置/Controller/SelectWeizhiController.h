//
//  SelectWeizhiController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/24.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectWeizhiController : BaseViewController

@property (nonatomic, copy) void(^selectCityBlock)(void);//选中的城市

@end
