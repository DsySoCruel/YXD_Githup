//
//  OrderProducModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/27.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  OrderProducCouponModel: NSObject
@property (nonatomic,strong) NSString *CId;
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *couponStatus;
@property (nonatomic,strong) NSString *dataFlag;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *couponType;
@property (nonatomic,strong) NSString *discountRate;
@property (nonatomic,strong) NSString *couponMoney;
@property (nonatomic,strong) NSString *spendMoney;
@property (nonatomic,strong) NSString *couponDes;
@property (nonatomic,strong) NSString *sendNum;
@property (nonatomic,strong) NSString *receiveNum;
@property (nonatomic,strong) NSString *sendStartTime;
@property (nonatomic,strong) NSString *sendEndTime;
@property (nonatomic,strong) NSString *validStartTime;
@property (nonatomic,strong) NSString *validEndTime;
@property (nonatomic,strong) NSString *createTime;
//自定义优惠卷是否选中
@property (nonatomic,assign) BOOL isSelect;

@end

@interface  OrderProducShopModel: NSObject
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *deliveryType;//配送方式 0.商家配送 1.平台配送
@end


@interface  OrderProducOrderDetailModel: NSObject
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *attrCatId;
@property (nonatomic,strong) NSString *shopPrice;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *deliveryType;
@property (nonatomic,strong) NSString *num_price;
@property (nonatomic,strong) NSString *num;
@end

@interface  OrderProducOrderModel: NSObject
@property (nonatomic,strong) NSString *num_num_price;
@property (nonatomic,strong) NSArray *data;
@end

@interface  OrderProducAddressModel: NSObject
@property (nonatomic,strong) NSString *addressId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userPhone;
@property (nonatomic,strong) NSString *userTel;
@property (nonatomic,strong) NSString *areaId1;
@property (nonatomic,strong) NSString *areaId2;
@property (nonatomic,strong) NSString *areaId3;
@property (nonatomic,strong) NSString *communityId;
@property (nonatomic,strong) NSString *longitude;
@property (nonatomic,strong) NSString *latitude;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *xiaoqu;
@property (nonatomic,strong) NSString *postCode;
@property (nonatomic,strong) NSString *isDefault;
@property (nonatomic,strong) NSString *addressFlag;
@property (nonatomic,strong) NSString *areaId2_name;
@end


@interface OrderProducModel : NSObject

@property (nonatomic,strong) NSString *ids;
@property (nonatomic,strong) OrderProducShopModel *shop;
@property (nonatomic,strong) OrderProducOrderModel *order;
@property (nonatomic,strong) NSArray *coupon;
@property (nonatomic,strong) OrderProducAddressModel *address;
@property (nonatomic,strong) NSString *packingMoney;
@property (nonatomic,strong) NSString *transCondition;
@property (nonatomic,strong) NSString *transRadius;
@property (nonatomic,strong) NSString *transInRange;
@property (nonatomic,strong) NSString *transOutRange;
@property (nonatomic,strong) NSString *transDistance;
@property (nonatomic,strong) NSString *carriage;//配送费
@property (nonatomic,strong) NSString *price;

@end
