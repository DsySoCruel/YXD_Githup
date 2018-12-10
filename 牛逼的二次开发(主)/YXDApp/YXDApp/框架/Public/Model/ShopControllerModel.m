//
//  ShopControllerModel.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/3.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopControllerModel.h"

@implementation ShopControllerCartModel

@end

@implementation ShopControllerGoodsListModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"selectNum" : @"goodsCnt"};
}


@end
//@implementation ShopControllerCatListChildrenModel
//
//@end
//@implementation ShopControllerCatListModel
//+ (NSDictionary *)mj_objectClassInArray{
//    return @{@"children" : [ShopControllerCatListChildrenModel class]};
//}
//@end

//二次修改
@implementation ShopControllerSecondModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goods" : [ShopControllerGoodsListModel class]};
    
}
@end

@implementation ShopControllerModel

+ (NSDictionary *)mj_objectClassInArray{
//    return @{@"catList" : [ShopControllerCatListModel class],@"goodsList" : [ShopControllerGoodsListModel class]};
    return @{@"children" : [ShopControllerSecondModel class]};

}

@end
