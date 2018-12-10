//
//  WeiZhiManager.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiZhiModel.h"

@interface WeiZhiManager : NSObject

+ (WeiZhiManager *)sharedInstance;

@property (nonatomic, strong) WeiZhiModel *weizhiModel;

@end
