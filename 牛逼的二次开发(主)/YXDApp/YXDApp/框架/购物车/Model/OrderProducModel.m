//
//  OrderProducModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/27.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderProducModel.h"


@implementation OrderProducCouponModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"CId" : @"id"};
}

@end

@implementation OrderProducShopModel

@end

@implementation OrderProducOrderDetailModel


@end

@implementation OrderProducOrderModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data" : [OrderProducOrderDetailModel class]};
}

@end

@implementation OrderProducAddressModel

@end

@implementation OrderProducModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"coupon" : [OrderProducCouponModel class]};
}


@end
