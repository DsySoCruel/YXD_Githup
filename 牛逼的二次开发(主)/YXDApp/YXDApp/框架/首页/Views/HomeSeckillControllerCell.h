//
//  HomeSeckillControllerCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/16.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeSeckillModel;
@class HomeGroupModel;
@class ShopResultsTableViewModel;

@interface HomeSeckillControllerCell : UITableViewCell

@property (nonatomic,strong) HomeSeckillModel *mdoel;
@property (nonatomic,strong) HomeGroupModel *groupModel;
@property (nonatomic,strong) ShopResultsTableViewModel *shopResultsTableViewModel;

@end
