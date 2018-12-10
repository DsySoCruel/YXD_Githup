//
//  OrderMessageModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMessageModel : NSObject
@property (nonatomic,strong) NSString *messageId;
@property (nonatomic,strong) NSString *msgType;
@property (nonatomic,strong) NSString *sendUserId;
@property (nonatomic,strong) NSString *receiveUserId;
@property (nonatomic,strong) NSString *msgContent;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *msgStatus;
@property (nonatomic,strong) NSString *msgFlag;
@end
