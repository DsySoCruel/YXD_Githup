//
//  MyCommentModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCommentModel : NSObject

@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *goodsScore;
@property (nonatomic,strong) NSString *serviceScore;
@property (nonatomic,strong) NSString *timeScore;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *isShow;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *goodsids;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopImg;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *orderFrom;
@property (nonatomic,strong) NSString *orderFromId;
@property (nonatomic,strong) NSString *userLogin;
@property (nonatomic,strong) NSString *userPhoto;

@end
