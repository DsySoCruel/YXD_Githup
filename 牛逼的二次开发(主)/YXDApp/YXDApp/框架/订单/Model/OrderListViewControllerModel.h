//
//  OrderListViewControllerModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/22.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

//完成的功能类型
typedef NS_ENUM(NSInteger,OrderListType) {
    OrderListTypeAll = 0,//全部
    OrderListTypeOne,//待接单
    OrderListTypeTwo,//配送中
    OrderListTypeThree,//待评论
    OrderListTypeFour,//退款
};

@interface OrderListGoodsModel : NSObject
@property (nonatomic,strong) NSString *goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodsThums;
@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *goodsNums;
@property (nonatomic,strong) NSString *goodsPrice;
@property (nonatomic,strong) NSString *goodsAttrName;
@end

@interface OrderListViewControllerModel : NSObject
//自定义
@property (nonatomic,assign) OrderListType orderType;

@property (nonatomic,strong) NSString *orderId;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *shopId;
//    orderStatus = 0或1或2表示待接单
//    orderStatus = 3   表示配送中
//    orderStatus = 4   表示已完成
//    orderStatus < 0   表示退款
@property (nonatomic,strong) NSString *orderStatus;
@property (nonatomic,strong) NSString *ruturnStatus;//默认0,1的话表示申请退款被拒绝
@property (nonatomic,strong) NSString *reminder;//是否催单，默认0 未催单   1已催单
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *totalMoney;//商品总价
@property (nonatomic,strong) NSString *realTotalMoney;//订单实际总金额  ==  totalMoney + deliverMoney - 优惠金额
@property (nonatomic,strong) NSString *deliverMoney;//派送费用
@property (nonatomic,strong) NSString *qqNo;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *payType;//付款方式？？？
@property (nonatomic,strong) NSString *isPay;//是否付款
@property (nonatomic,strong) NSString *isRefund;//是否退款
@property (nonatomic,strong) NSString *isAppraises;//是0就是待评论 1就是已评论（已完成）
@property (nonatomic,strong) NSString *shopName;
@property (nonatomic,strong) NSString *orderFrom;
@property (nonatomic,strong) NSString *orderFromId;
@property (nonatomic,strong) NSString *goodsNum;//表示订单总件数
@property (nonatomic,strong) NSString *statusName;//状态提示文字
@property (nonatomic,strong) NSArray  *goodslist;

@end
