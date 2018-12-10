//
//  OrderDetailControllerModel.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/18.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "OrderDetailControllerModel.h"

@implementation GoodsListDetailGoodModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    
    return @{@"goodId" : @"id"};
    
}

@end

@implementation RunerModel

@end

@implementation OrderDetailControllerOrderModel

@end

@implementation OrderDetailControllerModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goodsList" : [GoodsListDetailGoodModel class]};
}

@end
