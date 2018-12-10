//
//  OrderMessageControllerCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/6.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderMessageModel;
@class SystemorderMessageModel;

@interface OrderMessageControllerCell : UITableViewCell

@property (nonatomic,strong) OrderMessageModel *model;

@property (nonatomic,strong) SystemorderMessageModel *sysModel;

@property (nonatomic, copy) void(^deldeMessageBlock)(void);//删除消息进行刷新列表

@end
