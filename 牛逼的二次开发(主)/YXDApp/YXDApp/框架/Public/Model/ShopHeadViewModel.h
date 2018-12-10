//
//  ShopHeadViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/6/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopHeadViewModel : NSObject
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopImg;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *baseDeliveryMoney;
@property (nonatomic,strong) NSString *couponNum;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *isFavorite;
@end
