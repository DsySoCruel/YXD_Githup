//
//  OrderProducFirstCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/28.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderProducModel.h"

@interface OrderProducFirstCell : UITableViewCell

@property (nonatomic,strong) OrderProducModel *model;

//时间 地址  优惠金额 变化保存

@property (nonatomic, copy) void(^selectAddressBlock)(NSString *addressName);//地址的选择

@property (nonatomic, copy) void(^selectTimeBlock)(NSString *cityName);//时间的选择

@property (nonatomic, copy) void(^updataTotalMoneyBlock)(NSString *totalMoney,NSString *couponMoney,NSString *couponId);//优惠后的价格，优惠价格

@end
