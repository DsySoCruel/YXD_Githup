//
//  SystemorderMessageModel.m
//  YXDApp
//
//  Created by daishaoyang on 2018/7/12.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "SystemorderMessageModel.h"

@implementation SystemorderMessageModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"messageId" : @"id",@"title" : @"new_title",@"content" : @"new_content",@"type" : @"new_type",@"createTime" : @"create_time",@"deleteTime" : @"delete_time"};
}

@end
