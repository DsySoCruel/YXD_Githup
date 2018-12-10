//
//  ShopDetailCommentController.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@class ShopMessageModel;

@interface ShopDetailCommentController : BaseViewController

@property (nonatomic,strong) NSString *shopId;

@property (nonatomic,strong) ShopMessageModel *model;

@end
