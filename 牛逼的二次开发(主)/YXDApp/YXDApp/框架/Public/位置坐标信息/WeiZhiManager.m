//
//  WeiZhiManager.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "WeiZhiManager.h"

@implementation WeiZhiManager

+ (WeiZhiManager *)sharedInstance {
    static dispatch_once_t once;
    static WeiZhiManager *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[WeiZhiManager alloc] init];
    });
    return sharedInstance;
}


@end
