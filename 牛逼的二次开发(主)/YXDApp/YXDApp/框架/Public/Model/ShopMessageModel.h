//
//  ShopMessageModel.h
//  YXDApp
//
//  Created by daishaoyang on 2018/1/3.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopMessageCommentModel : NSObject
@property (nonatomic,strong) NSString *commentId;//
@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *orderId;
//@property (nonatomic,strong) NSString *goodsId;
//@property (nonatomic,strong) NSString *goodsAttrId;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *goodsScore;
@property (nonatomic,strong) NSString *serviceScore;
@property (nonatomic,strong) NSString *timeScore;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *appraisesAnnex;
@property (nonatomic,strong) NSString *isShow;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *goodsids;
//@property (nonatomic,strong) NSString *hfcontent;
@property (nonatomic,strong) NSString *userPhoto;
@property (nonatomic,strong) NSString *loginName;

@end


@interface ShopMessageCouponsModel : NSObject
@property (nonatomic,strong) NSString *couponId;
@property (nonatomic,strong) NSString *couponName;
@property (nonatomic,strong) NSString *couponType;
@property (nonatomic,strong) NSString *discountRate;
@property (nonatomic,strong) NSString *couponMoney;
@property (nonatomic,strong) NSString *spendMoney;
@property (nonatomic,strong) NSString *validStartTime;
@property (nonatomic,strong) NSString *validEndTime;
@property (nonatomic,strong) NSString *isRecieve;//是否得到过

@end

@interface ShopMessageModel : NSObject

@property (nonatomic,strong) NSString *shopId;
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *shopImg;
@property (nonatomic,strong) NSString *shopTel;
@property (nonatomic,strong) NSString *shopAddress;
@property (nonatomic,strong) NSString *serviceStartTime;
@property (nonatomic,strong) NSString *serviceEndTime;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *baseDeliveryMoney;
@property (nonatomic,strong) NSString *isFavorite;
@property (nonatomic,strong) NSString *appraises;
@property (nonatomic,strong) NSString *commentNum;
@property (nonatomic,strong) NSString *monthSales;
@property (nonatomic,strong) NSString *FavoritesNum;
@property (nonatomic,strong) ShopMessageCommentModel *firstComment;//最新评论
@property (nonatomic,strong) NSArray *coupons;//


@end
