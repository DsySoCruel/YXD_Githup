//
//  IdeaBackModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdeaBackModel : NSObject

//"feedbackId": "7",
//"feedbackType": "2",
//"content": "\u6cd5\u5e08\u6253\u53d1\u70b9\u6cd5\u5e08\u6253\u53d1\u65af\u8482\u82ac",
//"userId": "49",
//"userName": null,
//"userPhone": "13012241154",
//"createTime": "2017-12-14 10:47:02",
//"adminId": "1",
//"adminReply": "\u53d1\u6253\u53d1\u6253\u53d1",
//"replyTime": "2017-12-14 15:04:39"

@property (nonatomic,strong) NSString *feedbackId;
@property (nonatomic,strong) NSString *feedbackType;//2:其他异常 
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *adminId;
@property (nonatomic,strong) NSString *adminReply;
@property (nonatomic,strong) NSString *replyTime;

@end
