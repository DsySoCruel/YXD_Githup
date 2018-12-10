//
//  OrderMessageModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "OrderMessageModel.h"

@implementation OrderMessageModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"messageId" : @"id"};
}

@end
