//
//  OrderDetailController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailController : BaseViewController

@property (nonatomic,strong) NSString *orderId;//订单列表

@property (nonatomic, copy) void(^updateOrderBlock)(void);//取消订单 确认 进行刷新

@end
