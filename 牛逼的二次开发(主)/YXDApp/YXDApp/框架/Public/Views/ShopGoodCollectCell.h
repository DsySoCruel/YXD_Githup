//
//  ShopGoodCollectCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/4.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShopControllerGoodsListModel;

@interface ShopGoodCollectCell : UICollectionViewCell

@property (nonatomic,strong) ShopControllerGoodsListModel *model;

@property (nonatomic, copy) void(^jiaButtonBlock)(ShopControllerGoodsListModel *model);

@property (nonatomic, copy) void(^jianBUttonBlock)(ShopControllerGoodsListModel *model);

@end
