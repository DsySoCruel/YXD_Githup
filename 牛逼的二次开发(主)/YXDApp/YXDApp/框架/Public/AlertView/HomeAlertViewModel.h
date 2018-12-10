//
//  HomeAlertViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeAlertViewModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *nid;
@property (nonatomic,assign) BOOL isSelect;//是否被选中


+ (instancetype)itemWithTitle:(NSString *)name nid:(NSString *)nid isSelect:(BOOL)isSelect;


@end
