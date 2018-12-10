//
//  GoodControllerModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/15.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

//商品信息
@interface GoodControllerGoodsInfoModel : NSObject
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *attrCatId;
@property (nonatomic,strong) NSString *shopPrice;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *marketPrice;
@property (nonatomic,strong) NSString *goodsStock;
@property (nonatomic,strong) NSString *totalStock;
@property (nonatomic,strong) NSString *isBook;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *panicId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *qqNo;
@property (nonatomic,strong) NSString *deliveryType;
@property (nonatomic,strong) NSString *shopAtive;
@property (nonatomic,strong) NSString *shopTel;
@property (nonatomic,strong) NSString *shopAddress;
@property (nonatomic,strong) NSString *deliveryTime;
@property (nonatomic,strong) NSString *isInvoice;
@property (nonatomic,strong) NSString *deliveryStartMoney;
@property (nonatomic,strong) NSString *deliveryFreeMoney;
@property (nonatomic,strong) NSString *deliveryMoney;
@property (nonatomic,strong) NSString *goodsSn;
@property (nonatomic,strong) NSString *serviceStartTime;
@property (nonatomic,strong) NSString *serviceEndTime;
@property (nonatomic,strong) NSString *intro;

@end

//评论信息
@interface GoodControllerappraiseModel : NSObject
@property (nonatomic,strong) NSString *count;
@property (nonatomic,strong) NSString *res;

@end

//购物车信息
@interface GoodControllerCartInfoModel : NSObject
@property (nonatomic,strong) NSString *cart_count_num;
@property (nonatomic,strong) NSString *total_money;

@end


@interface GoodControllerModel : NSObject

@property (nonatomic,strong) GoodControllerGoodsInfoModel *goodsInfo;
@property (nonatomic,strong) GoodControllerappraiseModel *appraise;
@property (nonatomic,strong) GoodControllerCartInfoModel *cartInfo;
@property (nonatomic,strong) NSString *goodsInCart;

@end
