//
//  MyAttentionControllerCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyAttentionModel;

@interface MyAttentionControllerCell : UITableViewCell

@property (nonatomic,strong) MyAttentionModel *model;

@property (nonatomic, copy) void(^deleteMyAttenBlock)(NSString *favoriteId);//删除我的关注


@end
