//
//  OrderDetailControllerModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/18.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsListDetailGoodModel : NSObject
@property (nonatomic,strong) NSString *goodId;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsNums;
@property (nonatomic,strong) NSString *goodsPrice;
@property (nonatomic,strong) NSString *goodsAttrId;
@property (nonatomic,strong) NSString *goodsAttrName;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *commission;
@property (nonatomic,strong) NSString *marketPrice;
@end

@interface RunerModel : NSObject
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *userPhoto;
@end

@interface OrderDetailControllerOrderModel : NSObject
@property (nonatomic,strong) NSString *goodsNum;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopTel;
@property (nonatomic,strong) NSString *status_name;
@property (nonatomic,strong) NSString *totalMoney;
@property (nonatomic,strong) NSString *deliverMoney;
@property (nonatomic,strong) NSString *couponMoney;
@property (nonatomic,strong) NSString *realTotalMoney;
@property (nonatomic,strong) NSString *transCondition;
@property (nonatomic,strong) NSString *transRadius;
@property (nonatomic,strong) NSString *transInRange;
@property (nonatomic,strong) NSString *transOutRange;
@property (nonatomic,strong) NSString *transDistance;
@property (nonatomic,strong) NSString *requireTime;
@property (nonatomic,strong) NSString *userAddress;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *transType;
@property (nonatomic,strong) RunerModel *runner;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *orderStatus;//订单类别 重要
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *payWay;
@property (nonatomic,strong) NSString *reminder;//是否催单，默认0 未催单   1已催单
@property (nonatomic,strong) NSString *isAppraises;///是0就是待评论 1就是已评论（已完成）

@end

@interface OrderDetailControllerModel : NSObject
@property (nonatomic,strong) NSArray *goodsList;
@property (nonatomic,strong) OrderDetailControllerOrderModel *order;
@end
