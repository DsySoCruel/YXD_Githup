//
//  HomeViewModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeViewModel.h"

@implementation HomeViewModelTicket

@end

@implementation HomeViewModelGoodList

@end

@implementation HomeViewModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"ticket" : [HomeViewModelTicket class],@"goodList" : [HomeViewModelGoodList class]};
}

@end
