//
//  ShopDetailCommentControllerModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailCommentControllerModel : NSObject

@property (nonatomic,strong) NSString *commentId;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *goodsScore;
@property (nonatomic,strong) NSString *serviceScore;
@property (nonatomic,strong) NSString *timeScore;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *appraisesAnnex;
@property (nonatomic,strong) NSString *isShow;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *goodsids;
@property (nonatomic,strong) NSString *userPhoto;
@property (nonatomic,strong) NSString *loginName;

@end
