//
//  MyMoneyIncomeModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyMoneyIncomeModel : NSObject

@property (nonatomic,strong) NSString *moneyId;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *type; //1: + 0 : -
@property (nonatomic,strong) NSString *createTime;

@end
