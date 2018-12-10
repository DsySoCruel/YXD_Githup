//
//  ShopCarDetailModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/27.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCarDetailGoodsModel : NSObject

@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *cnt;

//自定义有没有被选中 默认没有
@property (nonatomic,assign) BOOL isSelect;//有没有选中
 
@end


@interface ShopCarDetailCarsGoodModel : NSObject

@property (nonatomic,strong) NSString *ischk;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *qqNo;
@property (nonatomic,strong) NSString *shopAtive;
@property (nonatomic,strong) NSString *deliveryFreeMoney;
@property (nonatomic,strong) NSString *deliveryMoney;
@property (nonatomic,strong) NSString *deliveryStartMoney;
@property (nonatomic,strong) NSString *totalCnt;
@property (nonatomic,strong) NSString *totalMoney;
@property (nonatomic,strong) NSString *hasConpon;
@property (nonatomic,strong) NSArray  *shopgoods;

@end

@interface ShopCarDetailModel : NSObject

@property (nonatomic,strong) NSString *gtotalMoney;
@property (nonatomic,strong) NSString *totalMoney;
@property (nonatomic,strong) ShopCarDetailCarsGoodModel *cartgoods;

@end
