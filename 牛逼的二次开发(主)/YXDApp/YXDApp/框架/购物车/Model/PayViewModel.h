//
//  PayViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/2.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoModel : NSObject
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopImg;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *realTotalMoney;

@end

@interface PayViewModel : NSObject

@property (nonatomic,strong) OrderInfoModel *orderInfo;
@property (nonatomic,strong) NSString *userMoney;
@property (nonatomic,strong) NSString *coupontId;

@end
