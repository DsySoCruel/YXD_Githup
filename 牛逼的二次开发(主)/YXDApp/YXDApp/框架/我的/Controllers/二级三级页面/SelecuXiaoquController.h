//
//  SelecuXiaoquController.h
//  YXDApp
//
//  Created by daishaoyang on 2018/2/6.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface SelecuXiaoquController : BaseViewController

@property (nonatomic,strong) NSString *city;//保存的city

@property (nonatomic,strong) NSString *areaId2;

@property (nonatomic, copy) void(^selectXiaoquBlock)(NSString *cityName,NSString *cityId,NSString *la,NSString *lo);//选中的城市


@end
