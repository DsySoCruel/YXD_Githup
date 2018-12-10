//
//  SystemorderMessageModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/7/12.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemorderMessageModel : NSObject

@property (nonatomic,strong) NSString *sysId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *deleteTime;

@end
