//
//  CategoryCollecModel.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/21.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "CategoryCollecModel.h"

@implementation CategoryCollecDataModel

@end


@implementation CategoryCollecModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"childs" : [CategoryCollecDataModel class]};
}

@end
