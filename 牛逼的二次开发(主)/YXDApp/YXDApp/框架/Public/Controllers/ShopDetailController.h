//
//  ShopDetailController.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@class ShopMessageModel,ShopHeadViewModel;

@interface ShopDetailController : BaseViewController

@property (nonatomic,strong) ShopMessageModel *model;
@property (nonatomic,strong) ShopHeadViewModel *headModel;

@end
