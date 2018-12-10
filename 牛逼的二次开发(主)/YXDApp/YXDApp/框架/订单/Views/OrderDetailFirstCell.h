//
//  OrderDetailFirstCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/29.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderDetailControllerModel;

@interface OrderDetailFirstCell : UITableViewCell

@property (nonatomic,strong) OrderDetailControllerModel *model;

@property (nonatomic,assign) BOOL isNeedPresentAll;//默认no

@property (nonatomic, copy) void(^isNeedPresentAllBlock)(BOOL isNeedPresentAll);//

@end

