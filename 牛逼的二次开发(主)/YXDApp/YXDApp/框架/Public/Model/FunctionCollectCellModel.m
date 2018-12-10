//
//  FunctionCollectCellModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "FunctionCollectCellModel.h"

@implementation FunctionCollectCellModel

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    FunctionCollectCellModel *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithTitle:title icon:nil];
}


@end
