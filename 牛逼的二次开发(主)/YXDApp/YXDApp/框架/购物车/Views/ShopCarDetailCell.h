//
//  ShopCarDetailCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/27.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCarDetailModel.h"

@interface ShopCarDetailCell : UITableViewCell

@property (nonatomic,strong) ShopCarDetailGoodsModel *goodModel;

@property (nonatomic,strong) NSString *shopId;

@property (nonatomic, copy) void(^needContTotalPriceBlock)(void);

@property (nonatomic, copy) void(^selectButtonActionBlock)(void);

@property (nonatomic, copy) void(^needUpdataBlock)(void);


@end
