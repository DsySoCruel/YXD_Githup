//
//  ShopResultsTableViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/6/20.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopResultsTableViewModel : NSObject
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsSn;
@property (nonatomic,strong) NSString *goodsImg;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *shopPrice;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *marketPrice;
@property (nonatomic,strong) NSString *totalSale;
@property (nonatomic,strong) NSString *goodsStock;
@property (nonatomic,strong) NSString *totalStock;
@property (nonatomic,strong) NSString *panicId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *intro;
@end
