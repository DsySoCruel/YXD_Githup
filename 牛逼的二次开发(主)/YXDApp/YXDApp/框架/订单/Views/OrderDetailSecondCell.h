//
//  OrderDetailSecondCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailControllerModel;

@interface OrderDetailSecondCell : UITableViewCell
@property (nonatomic,strong) OrderDetailControllerModel *model;
//只有配送状态下展示配送员信息
@end
