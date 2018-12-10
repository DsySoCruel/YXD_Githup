//
//  YXDURL.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/8.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#ifndef YXDURL_h
#define YXDURL_h


#define YXDMainPath @"http://buy.soole.com.cn"
//#define YXDMainPath @"http://onezl.jiu12.com"


/*******************************************************登录注册*********************************************************/

//注册
#define USER_RegisterURL [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=doRegist",YXDMainPath]

//发送验证码
#define USER_SendCodeURL [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getMoblieCode",YXDMainPath]

//修改密码
#define USER_UpdatePW [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=resetPwd",YXDMainPath]

//登录
#define USER_login [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=doLogin",YXDMainPath]
//微信登录
#define USER_wxlogin [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=wxLogin",YXDMainPath]


//退出登录
#define USER_logout [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=logout",YXDMainPath]

/********************************************************搜索**********************************************************/
//热门搜索和历史搜索
#define USER_getHotAndHistory [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getHotAndHistory",YXDMainPath]
//搜索附近商品或门店
#define USER_ShopsOrGoods [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=searchNearbyShopsOrGoods",YXDMainPath]
//搜索指定店铺内的商品
#define USER_searchGoodsByShopId [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=searchGoodsByShopId",YXDMainPath]
//清除搜索记录
#define USER_clearSearch [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=clearSearch",YXDMainPath]

/*****************************************************首页**********************************************************/

//检查城市是否已开通
#define USER_checkCity [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=checkCity",YXDMainPath]

//轮播图（四种）
#define USER_banner [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=banner",YXDMainPath]

//行业分类
#define USER_industry [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=industry",YXDMainPath]

//行业分类详情
#define USER_toCatShop [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toCatShop",YXDMainPath]

//描秒杀
#define USER_secKill [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=secKill",YXDMainPath]

//特价
#define USER_purchase [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=purchase",YXDMainPath]

//附近店铺
#define USER_getNearbyShops [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getNearbyShops",YXDMainPath]

//首页头部View综合
#define USER_homeBanner [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=homeBanner",YXDMainPath]

/********************************************************分类**********************************************************/

//分类左侧
#define USER_getLeftCate [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getLeftCate",YXDMainPath]

//分类列表
#define USER_getCategory [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getCategory",YXDMainPath]

//分类下某类商品
#define USER_getGoodsByCat [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getGoodsByCat",YXDMainPath]

/********************************************************店铺相关**********************************************************/

//获取店铺首页信息
#define USER_getShop [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getShop",YXDMainPath]
////获取店铺分类
//#define USER_getShopCats [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getShopCats",YXDMainPath]
////获取店铺所有商品
//#define USER_getShopGoods [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getShopGoods",YXDMainPath]
//获取店铺所有分类和商品
#define USER_getShopCatAndGood [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getShopCatAndGood",YXDMainPath]
//获取店铺详细信息
#define USER_getShopDetail [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=shopIntro",YXDMainPath]

//关注店铺
#define USER_addFav [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=addFav",YXDMainPath]
//取消关注
#define USER_delFav [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=delFav",YXDMainPath]
//领取优惠卷
#define USER_addCoupon [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=addCoupon",YXDMainPath]
//查看全部评论
#define USER_showMoreAppraises [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=showMoreAppraises",YXDMainPath]
//商品详情
#define USER_goodsDetail [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=goodsDetail",YXDMainPath]

//添加购物车已写
/********************************************************购物车**********************************************************/
//我的购物车
#define USER_toCart [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toCart",YXDMainPath]

//添加购物车
#define USER_addToCart [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=addToCart",YXDMainPath]

//点击某个购物车
#define USER_toShopCart [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toShopCart",YXDMainPath]

//清除购物车
#define USER_removeCart [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=removeCart",YXDMainPath]

/********************************************************订单**********************************************************/
//下单
#define USER_toOrderCart [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toOrderCart",YXDMainPath]

//生成订单
#define USER_toMakeOrder [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toMakeOrder",YXDMainPath]

//支付页面（获取支付信息、订单信息、个人信息）
#define USER_toPay [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toPay",YXDMainPath]

//支付成功回调（余额支付）
#define USER_toPayNotify [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toPayNotify",YXDMainPath]

//支付成功回调（支付宝支付）
#define USER_getAliCallInfo [NSString stringWithFormat:@"%@/index.php?m=Home&c=AppPay&a=getAliCallInfo",YXDMainPath]

//支付成功回调（微信支付）
#define USER_getWxCallInfo [NSString stringWithFormat:@"%@/index.php?m=Home&c=AppPay&a=getWxCallInfo",YXDMainPath]

//订单列表
#define USER_toOrderList [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toOrderList",YXDMainPath]

//订单详情
#define USER_toOrderDetail [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toOrderDetail",YXDMainPath]

//更改订单状态
#define USER_changeOrder [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=changeOrder",YXDMainPath]

//催单
#define USER_toReminder [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toReminder",YXDMainPath]

//评价
#define USER_toAppraises [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=toAppraises",YXDMainPath]

//评价多图
#define USER_multiUpload [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=multiUpload",YXDMainPath]
/*******************************************************选择位置*********************************************************/

//历史搜索记录
#define USER_getSearchLocation [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getSearchLocation",YXDMainPath]

//点击搜索位置列表任一项
#define USER_selectLocation [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=selectLocation",YXDMainPath]

//点击历史搜索列表任一项
#define USER_selectHistory [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=selectHistory",YXDMainPath]

//清楚位置搜索记录
#define USER_clearSearchLocation [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=clearSearchLocation",YXDMainPath]

/*******************************************************个人中心*********************************************************/

//更换手机号
#define USER_updataPhone [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=changeMobile",YXDMainPath]

//更换图像
#define USER_updataIcon [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=avatar",YXDMainPath]

//我的余额
#define USER_mybalance [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=balance",YXDMainPath]

//我的优惠卷
#define USER_myconpon [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=coupon",YXDMainPath]

//我的关注
#define USER_myinterest [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=interest",YXDMainPath]

//我的收货地址
#define USER_myaddress [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=address",YXDMainPath]

//设置默认收货地址
#define USER_setDefAddress [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=setDefAddress",YXDMainPath]

//获取已开通城市列表
#define USER_getServiceCity [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getServiceCity",YXDMainPath]

//新增收货地址
#define addAddress [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=addAddress",YXDMainPath]

//帮助中心列表
#define USER_helpCenter [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=helpCenter",YXDMainPath]

//帮助中心详情
#define USER_showHelp [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=showHelp",YXDMainPath]

//添加意见反馈
#define USER_feedback [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=feedback",YXDMainPath]

//删除意见反馈
#define USER_delfeed [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=delFeed",YXDMainPath]

//意见反馈列表
#define USER_feedList [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=feedList",YXDMainPath]

//订单消息
#define USER_message [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=message",YXDMainPath]

//系统消息
#define USER_systemMessage [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=getSysMess",YXDMainPath]

//删除消息
#define USER_deleMessage [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=delMessage",YXDMainPath]

//余额明细
#define USER_balanceDetail [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=balanceDetail",YXDMainPath]

//删除我的关注
#define USER_delFavorite [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=delFavorite",YXDMainPath]

//删除收货地址
#define USER_delAddress [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=delAddress",YXDMainPath]

//我的评论
#define USER_comment [NSString stringWithFormat:@"%@/index.php?m=Home&c=App&a=comment",YXDMainPath]

#endif /* YXDURL_h */
