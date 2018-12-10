//
//  GoodController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/21.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"
@class ShopControllerGoodsListModel;

@interface GoodController : BaseViewController

@property (nonatomic,strong) NSString *goodsId;

@property (nonatomic,strong) NSString *shopId;//首页直接进入详情使用

@property (nonatomic,strong) NSString *shopID;//店铺进入使用

@property (nonatomic,strong) ShopControllerGoodsListModel *model;

@property (nonatomic, copy) void(^jiaButtonBlock)(ShopControllerGoodsListModel *model);

@property (nonatomic,strong) NSMutableArray *selectGoods;

@end
