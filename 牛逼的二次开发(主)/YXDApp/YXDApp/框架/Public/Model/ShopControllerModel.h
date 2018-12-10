//
//  ShopControllerModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/3.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopControllerCartModel : NSObject

@property (nonatomic,strong) NSString *cart_count_num;
@property (nonatomic,strong) NSString *total_money;

@end

@interface ShopControllerGoodsListModel : NSObject

@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsSn;
@property (nonatomic,strong) NSString *goodsImg;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *shopPrice;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *marketPrice;
@property (nonatomic,strong) NSString *totalSale;
@property (nonatomic,strong) NSString *goodsStock;
@property (nonatomic,strong) NSString *totalStock;
@property (nonatomic,strong) NSString *panicId;
@property (nonatomic,strong) NSString *groupId;
@property (nonatomic,strong) NSString *goodsSum;
@property (nonatomic,strong) NSString *intro;

//自己添加
@property (nonatomic,assign) NSInteger  selectNum;//添加了几个

@end

//@interface ShopControllerCatListChildrenModel : NSObject
//@property (nonatomic,strong) NSString *catId;
//@property (nonatomic,strong) NSString *parentId;
//@property (nonatomic,strong) NSString *catName;
//@property (nonatomic,strong) NSString *shopId;
//@property (nonatomic,assign) BOOL isSelect;
//
//@end
//@interface ShopControllerCatListModel : NSObject
//@property (nonatomic,strong) NSString *catId;
//@property (nonatomic,strong) NSString *parentId;
//@property (nonatomic,strong) NSString *catName;
//@property (nonatomic,strong) NSString *shopId;
//@property (nonatomic,strong) NSMutableArray *children;
//@property (nonatomic,assign) BOOL isSelect;
//@end



//商品二级信息数组（包含二级分类信息以及商品数组）
@interface ShopControllerSecondModel : NSObject
@property (nonatomic,strong) NSString *catId;
@property (nonatomic,strong) NSString *parentId;
@property (nonatomic,strong) NSString *catName;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSMutableArray *goods;//
@property (nonatomic,assign) BOOL isSelect;


@end

//商品一级信息数组（包含一级分类信息以及二级数组）

@interface ShopControllerModel : NSObject

//@property (nonatomic,strong) NSString *ct1;
//@property (nonatomic,strong) NSString *ct2;
//@property (nonatomic,strong) NSString *shopId;
//@property (nonatomic,strong) NSString *shopName;
//@property (nonatomic,strong) NSString *shopImg;
//@property (nonatomic,strong) NSString *remark;
//@property (nonatomic,strong) NSString *baseDeliveryMoney;
//@property (nonatomic,strong) NSString *couponName;
//@property (nonatomic,strong) NSString *isFavorite;
//@property (nonatomic,strong) NSMutableArray *catList;//
//@property (nonatomic,strong) NSMutableArray *goodsList;
//@property (nonatomic,strong) ShopControllerCartModel *cart;

@property (nonatomic,strong) NSString *catId;
@property (nonatomic,strong) NSString *parentId;
@property (nonatomic,strong) NSString *catName;
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSMutableArray *children;//
@property (nonatomic,assign) BOOL isSelect;

@end
