//
//  HomeCateCollectionViewCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionCollectCellModel.h"
#import "HomeIndustryModel.h"
#import "ShopCarViewModel.h"
#import "OrderListViewControllerModel.h"

@interface HomeCateCollectionViewCell : UICollectionViewCell

@property (nonatomic,assign) BOOL *isNeedRexiao;//是否需要热销标签
@property (nonatomic,strong) FunctionCollectCellModel *model;
@property (nonatomic,strong) HomeIndustryModel *industryModel;
@property (nonatomic,strong) GoodModel *goodModel;
@property (nonatomic,strong) OrderListGoodsModel *listGoodsModel;//我的订单过来的
@end
