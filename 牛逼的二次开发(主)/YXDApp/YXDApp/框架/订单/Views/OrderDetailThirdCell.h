//
//  OrderDetailThirdCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailControllerModel;

@interface OrderDetailThirdCell : UITableViewCell
//区别退单的情况
@property (nonatomic,strong) OrderDetailControllerModel *model;


@end
