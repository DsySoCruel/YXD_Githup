//
//  AddIdeaBackController.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface AddIdeaBackController : BaseViewController

@property (nonatomic, copy) void(^addSuccessBlock)(void);//新增成功 就行刷新

@end
