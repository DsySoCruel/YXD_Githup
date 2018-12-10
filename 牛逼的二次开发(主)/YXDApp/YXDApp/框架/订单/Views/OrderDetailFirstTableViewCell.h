//
//  OrderDetailFirstTableViewCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/5.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsListDetailGoodModel;
@class OrderProducOrderDetailModel;

@interface OrderDetailFirstTableViewCell : UITableViewCell

@property (nonatomic,strong) GoodsListDetailGoodModel *model;

@property (nonatomic,strong) OrderProducOrderDetailModel *makeOrderModel;//购物车下订单

@end
