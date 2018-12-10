//
//  WeiZhiModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiZhiModel : NSObject

//用于本地进行保存的情况
@property (nonatomic, copy) NSString *areaId2;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *xiaoqu;
@property (nonatomic, assign) BOOL isCorrectCity;//是否是合理的城市

@end
