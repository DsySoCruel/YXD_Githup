//
//  HomeTableCellTopView.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyAttentionModel,HomeViewModel;
@interface HomeTableCellTopView : UIView

@property (nonatomic,strong) MyAttentionModel *model; //我的收藏列表

@property (nonatomic,strong) HomeViewModel *homeModel; //首页列表

@end
