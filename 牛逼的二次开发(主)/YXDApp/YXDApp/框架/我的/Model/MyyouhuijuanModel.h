//
//  MyyouhuijuanModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/12.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyyouhuijuanModel : NSObject

//"shopId": "37",
//"shopName": "\u6c83\u5c14\u739b-\u82b1\u56ed\u8def\u5e97",
//"shopImg": "Upload\/shops\/2017-11\/5a0be33b8214c.png",
//"id": "30",
//"couponId": "12",
//"couponName": "\u672c\u5e97\u6298\u6263\u4f18\u60e0\u6d3b\u52a8\u540d\u79f0",
//"couponType": "2",
//"discountRate": "0.80",
//"couponMoney": "29",
//"spendMoney": "120",
//"validStartTime": "2017-12-12",
//"validEndTime": "2018-01-30",
//"receiveTime": "2017-12-12 18:02:35",
//"couponStatus": "1"

@property(nonatomic,strong) NSString *shopId;
@property(nonatomic,strong) NSString *shopName;
@property(nonatomic,strong) NSString *shopImg;
@property(nonatomic,strong) NSString *youhuanId;//替换
@property(nonatomic,strong) NSString *couponId;//折扣卷id
@property(nonatomic,strong) NSString *couponName;//折扣名字
@property(nonatomic,strong) NSString *couponType;//优惠卷类型：1 满减优惠 2 折扣优惠
@property(nonatomic,strong) NSString *discountRate;//折扣百分比
@property(nonatomic,strong) NSString *couponMoney;//折扣开始价位
@property(nonatomic,strong) NSString *spendMoney;//折扣结束价位
@property(nonatomic,strong) NSString *validStartTime;//活动开始时间
@property(nonatomic,strong) NSString *validEndTime;//活动结束时间
@property(nonatomic,strong) NSString *receiveTime;
@property(nonatomic,strong) NSString *couponStatus;

@end
