//
//  HomeAlertViewModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeAlertViewModel.h"

@implementation HomeAlertViewModel

+ (instancetype)itemWithTitle:(NSString *)name nid:(NSString *)nid isSelect:(BOOL)isSelect{
    
    HomeAlertViewModel *model = [[HomeAlertViewModel alloc] init];
    model.name = name;
    model.nid = nid;
    model.isSelect = isSelect;
    return model;
    
}

@end
