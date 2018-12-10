//
//  ShopMessageModel.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/3.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopMessageModel.h"

@implementation ShopMessageCommentModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"commentId" : @"id"};
}
@end

@implementation ShopMessageCouponsModel

@end


@implementation ShopMessageModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"firstComment" : @"newComment"};
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"coupons" : [ShopMessageCouponsModel class]};
}

@end
