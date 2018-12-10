//
//  HomeViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeViewModelTicket : NSObject

@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *couponType;
@property (nonatomic,strong) NSString *couponMoney;
@property (nonatomic,strong) NSString *spendMoney;
@property (nonatomic,strong) NSString *validStartTime;
@property (nonatomic,strong) NSString *validEndTime;

@end


@interface HomeViewModelGoodList : NSObject

@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *goodsId;

@end


@interface HomeViewModel : NSObject

@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *logo;
@property (nonatomic,strong) NSString *shopname;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *speed;
@property (nonatomic,strong) NSString *star;
@property (nonatomic,strong) NSString *sale;
@property (nonatomic,strong) NSString *juli;
@property (nonatomic,strong) NSMutableArray *ticket;//
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSMutableArray *goodList;//


@end
