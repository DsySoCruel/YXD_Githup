//
//  ShopCarViewModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/24.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopCarViewModel.h"

@implementation ResModel

@end

@implementation GoodModel

@end

@implementation ShopModel

@end

@implementation ShopCarViewModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cartList" : [GoodModel class]};
}

@end
