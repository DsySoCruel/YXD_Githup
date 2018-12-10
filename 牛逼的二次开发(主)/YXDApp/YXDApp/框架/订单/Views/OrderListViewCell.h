//
//  OrderListViewCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/22.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  OrderListViewControllerModel;

@interface OrderListViewCell : UITableViewCell

@property (nonatomic,strong) OrderListViewControllerModel *model;

@property (nonatomic, copy) void(^commentActionBlock)(NSString *orderId);//进行评价

@property (nonatomic, copy) void(^cancleOrderBlock)(void);//取消订单 进行刷新

@end
