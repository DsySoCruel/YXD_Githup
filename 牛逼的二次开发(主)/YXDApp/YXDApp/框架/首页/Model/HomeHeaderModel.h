//
//  HomeHeaderModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/7/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeIndustryModel.h"
#import "HomBannerModel.h"

@interface HomeHeaderModel : NSObject

@property (nonatomic,strong) NSArray *banners;
@property (nonatomic,strong) NSArray *cenads;
@property (nonatomic,strong) HomBannerModel *seckillads;
@property (nonatomic,strong) HomBannerModel *groupads;
@property (nonatomic,strong) NSArray *cats;

@end
