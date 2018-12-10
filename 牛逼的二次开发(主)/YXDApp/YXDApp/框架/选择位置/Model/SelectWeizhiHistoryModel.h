//
//  SelectWeizhiHistoryModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/2/6.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectWeizhiHistoryModel : NSObject

@property (nonatomic,strong) NSString *weizhiId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *areaId2;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *place;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *searchTime;
@property (nonatomic,strong) NSString *searchFlag;

@end
