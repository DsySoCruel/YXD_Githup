//
//  SelectWeizhiControllerCell.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/19.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SelectWeizhiControllerModel;
@class SelectWeizhiHistoryModel;

@interface SelectWeizhiControllerCell : UITableViewCell

@property (nonatomic,strong) SelectWeizhiControllerModel *model;

@property (nonatomic,strong) SelectWeizhiHistoryModel *historyModel;

@end
