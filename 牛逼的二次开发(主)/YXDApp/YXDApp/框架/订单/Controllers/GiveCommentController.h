//
//  GiveCommentController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/26.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface GiveCommentController : BaseViewController

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *shopIconUrl;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic, copy) void(^updateOrderBlock)(void);//已评价 进行刷新
@end
