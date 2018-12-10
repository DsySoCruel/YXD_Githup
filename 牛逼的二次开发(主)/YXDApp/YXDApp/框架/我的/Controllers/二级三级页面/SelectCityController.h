//
//  SelectCityController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/11.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectCityController : BaseViewController

@property (nonatomic, copy) void(^selectCityBlock)(NSString *cityName,NSString *cityId);//选中的城市

@end
