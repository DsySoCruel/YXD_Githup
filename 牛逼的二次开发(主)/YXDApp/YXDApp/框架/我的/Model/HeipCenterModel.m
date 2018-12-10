//
//  HeipCenterModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/13.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HeipCenterModel.h"
@implementation HeipCenterModelTwoModel

@end

//@implementation HeipCenterModelFirstModel
//
//+ (NSDictionary *)mj_objectClassInArray{
//    return @{@"articlecats" : [HeipCenterModelTwoModel class]};
//}
//
//@end

@implementation HeipCenterModel

//+ (NSDictionary *)replacedKeyFromPropertyName
//{
//    return @{@"b" : @"2",@"c" : @"3",@"d" : @"4",@"e" : @"5",@"f" : @"6"};
//}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"articlecats" : [HeipCenterModelTwoModel class]};
}



@end

