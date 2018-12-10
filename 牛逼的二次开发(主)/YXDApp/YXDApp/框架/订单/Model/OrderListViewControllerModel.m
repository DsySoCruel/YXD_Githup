//
//  OrderListViewControllerModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/22.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderListViewControllerModel.h"

@implementation OrderListGoodsModel

@end


@implementation OrderListViewControllerModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goodslist" : [OrderListGoodsModel class]};
}


@end
