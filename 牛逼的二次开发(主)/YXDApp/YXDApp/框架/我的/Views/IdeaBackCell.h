//
//  IdeaBackCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class IdeaBackModel;

@interface IdeaBackCell : UITableViewCell

@property (nonatomic,strong) IdeaBackModel *model;

@property (nonatomic, copy) void(^deleCellBlock)(NSString *feedbackId);

@end
