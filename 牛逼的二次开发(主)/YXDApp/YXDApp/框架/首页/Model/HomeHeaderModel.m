//
//  HomeHeaderModel.m
//  YXDApp
//
//  Created by daishaoyang on 2018/7/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "HomeHeaderModel.h"

@implementation HomeHeaderModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"banners" : [HomBannerModel class],@"cenads" : [HomBannerModel class],@"cats" : [HomeIndustryModel class]};
}
@end
