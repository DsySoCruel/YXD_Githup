//
//  AppDelegate.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "AppDelegate.h"
#import "YXDTabBarController.h"
#import "LoginViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import <UMCommon/UMCommon.h>
#import <UShareUI/UShareUI.h>
#import "JPUSHService.h"
#import "NotificationMessageController.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif



@interface AppDelegate ()<WXApiDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate,UIApplicationDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 2.显示窗口
    [self.window makeKeyAndVisible];
    
    YXDTabBarController *tabBar = [[YXDTabBarController alloc] init];
    self.window.rootViewController = tabBar;

    /**
      *  由登录状态信息设置根视图控制器
      */
    //从沙盒中获取上次存储的版本号
    NSString *versionKey = @"CFBundleShortVersionString";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    if ([currentVersion isEqualToString:lastVersion]) {
        /*
         *设置根视图控制器
         */
//        YXDTabBarController *tabBar = [[YXDTabBarController alloc] init];
//        self.window.rootViewController = tabBar;
        /*
         *判断是否需要检查
         */
        //        [self checkUpdateWithAppID];
    }else{
        /*
         *设置欢迎界面为根视图控制器
         */
//        WelcomeController *welcome = [[WelcomeController alloc] init];
//        self.window.rootViewController = welcome;
    }
    //1.微信支付
    [WXApi registerApp:@"wxf836036544ba5073"];
    //2.友盟三方登录
    [UMConfigure initWithAppkey:@"5b3c689ba40fa34c120000ac" channel:@"App Store"];
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [self configUSharePlatforms];
    [self confitUShareSettings];
    //3.设置极光推送
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:@"d7919b38e21363bb215f928e"
                          channel:@"App Store"
                 apsForProduction:NO
            advertisingIdentifier:nil];
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        return [self openURL:url];
    }
    return result;
}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        return [self openURL:url];
    }
    return result;
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        return [self openURL:url];
    }
    return result;
}

#pragma mark - 支付判断
- (BOOL)openURL:(NSURL *)url{
    if ([[url scheme] isEqualToString:@"wxf836036544ba5073"]) {//微信的跳转
        return [self weixinPay:url];
    }
    if ([[url scheme] isEqualToString:@"xxyxdApp"]) {//支付宝操作
        return [self Alipay:url];
    }
    return YES;
}
#pragma mark - 支付宝回调
-(BOOL)Alipay:(NSURL *)url{
    /*
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错
     */
    if ([url.host isEqualToString:@"safepay"]) {
        //这个是进程KILL掉之后也会调用，这个只是第一次授权回调，同时也会返回支付信息
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
        //跳转支付宝钱包进行支付，处理支付结果，这个只是辅佐订单支付结果回调
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
    }else if ([url.host isEqualToString:@"platformapi"]){
        //授权返回码
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self AlipayWithResutl:resultDic];
        }];
    }
    return YES;
}

-(void)AlipayWithResutl:(NSDictionary *)resultDic{
    NSString  *str = [resultDic objectForKey:@"resultStatus"];
    if (str.intValue == 9000)
    {
        // 支付成功
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"ali_success" userInfo:nil];
    }
    else
    {
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"fail" userInfo:nil];
    }
}

#pragma mark - 微信支付代理
- (BOOL)weixinPay:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}
//回调中errCode值列表：
//名称    描述    解决方案
//0    成功    展示成功页面
//-1    错误    可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。
//-2    用户取消    无需处理。发生场景：用户不支付了，点击取消，返回APP。
-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp * response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"ali_success" userInfo:nil];
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PayResult" object:@"fail" userInfo:nil];
                break;
        }
    }
}


//友盟设置
- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf836036544ba5073" appSecret:@"cb5154f0a3abf979d1d0faa278718bc4" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
}

#pragma mark --通知相关
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"_____%@",token);
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support  收到通知执行
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support  点击通知执行
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler  API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)) API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
                if ([rootVC isKindOfClass:[UITabBarController class]]) {
                    if([userInfo[@"m_type"] integerValue] == 1){//跳转到通知消息页
                        UITabBarController *tab = (UITabBarController *)rootVC;
                        tab.selectedIndex = 0;
                        UINavigationController *vc = tab.childViewControllers[0];
                        NotificationMessageController *notificationC  = [NotificationMessageController new];
                        notificationC.isNeedSelect = YES;
                        [vc pushViewController:notificationC animated:YES];
                    }
                }
            });
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
}
/**
 推送：iOS9 1.前台收到通知执行 2.后台点击通知执行
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
