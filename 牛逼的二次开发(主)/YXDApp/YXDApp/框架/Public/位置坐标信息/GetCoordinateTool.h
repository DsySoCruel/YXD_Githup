//
//  GetCoordinateTool.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GetCoordinateModel.h"

typedef void(^getCoordinateBlock)(GetCoordinateModel *model);

@interface GetCoordinateTool : NSObject

@property (nonatomic,copy) getCoordinateBlock block;

- (void)getCoordinateToolActionWith:(getCoordinateBlock)block;

+ (GetCoordinateTool *)getCoordinateTool;

@end
