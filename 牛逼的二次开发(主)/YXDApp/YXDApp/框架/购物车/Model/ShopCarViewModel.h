//
//  ShopCarViewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/24.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResModel : NSObject
@property (nonatomic,strong) NSString *goodsImg;
@property (nonatomic,strong) NSString *shopPrice;

@end

@interface GoodModel : NSObject

@property (nonatomic,strong) NSString *cartId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *isCheck;
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsAttrId;
@property (nonatomic,strong) NSString *goodsCnt;
@property (nonatomic,strong) NSString *packageId;
@property (nonatomic,strong) NSString *batchNo;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *isSelect;
@property (nonatomic,strong) NSString *goodsCate;
@property (nonatomic,strong) ResModel *res;

@end

@interface ShopModel : NSObject

@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopId;

@end

@interface ShopCarViewModel : NSObject

@property (nonatomic,strong) NSArray *cartList;
@property (nonatomic,strong) ShopModel *shopName;
@property (nonatomic,assign) NSInteger count;

@end
