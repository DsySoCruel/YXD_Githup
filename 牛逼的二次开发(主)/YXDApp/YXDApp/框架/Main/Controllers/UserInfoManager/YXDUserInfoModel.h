//
//  YXDUserInfoModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/8.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <JSONModel.h>

@interface YXDUserInfoModel : JSONModel

//"": "57",
//"": "13233822520",
//"": "9229",
//"": "2762cc9dbafcba02048df34ee1b02925",
//"": "0",
//"": "0",
//"": "",
//"": "",
//"": "",
//"": "",
//"": "0",
//"": null,
//"": "0",
//"": "1",
//"": "1",
//"": "2017-12-10 15:06:10",
//"": "218.60.71.49",
//"": "2017-12-10 15:06:10",
//"": "0",
//"": null,
//"": null,
//"": "0.00",
//"": "0.00",
//"": "0.00",
//"": "0",
//"": null,
//"": "",
//"": ""


@property (nonatomic, copy) NSString *userId;//用户id
@property (nonatomic, copy) NSString *loginName;//用户名字
@property (nonatomic, copy) NSString *loginSecret;//
@property (nonatomic, copy) NSString *loginPwd;//用户密码
@property (nonatomic, copy) NSString *userSex;//用户性别
@property (nonatomic, copy) NSString *userType;//用户类型
@property (nonatomic, copy) NSString *userName;//
//@property (nonatomic, copy) NSString *userQQ;//
//@property (nonatomic, copy) NSString *userPhone;//
//@property (nonatomic, copy) NSString *userEmail;//
@property (nonatomic, copy) NSString *userScore;//0
@property (nonatomic, copy) NSString *userPhoto;//用户图像
@property (nonatomic, copy) NSString *userTotalScore;//0
@property (nonatomic, copy) NSString *userStatus;//0
@property (nonatomic, copy) NSString *userFlag;//0
@property (nonatomic, copy) NSString *createTime;//2017-12-10 15:06:10
//@property (nonatomic, copy) NSString *lastIP;//"218.60.71.49"
//@property (nonatomic, copy) NSString *lastTime;//"2017-12-10 15:06:10"
@property (nonatomic, copy) NSString *userFrom;//"0",
//@property (nonatomic, copy) NSString *openId;//
//@property (nonatomic, copy) NSString *wxOpenId;//
@property (nonatomic, copy) NSString *userMoney;//
@property (nonatomic, copy) NSString *lockMoney;//
@property (nonatomic, copy) NSString *distributMoney;//
@property (nonatomic, copy) NSString *isBuyer;//是否是消费者
//@property (nonatomic, copy) NSString *payPwd;//
@property (nonatomic, copy) NSString *cardId;//
@property (nonatomic, copy) NSString *linkMan;//
@property (nonatomic, copy) NSString *myCoupons;//

@end
