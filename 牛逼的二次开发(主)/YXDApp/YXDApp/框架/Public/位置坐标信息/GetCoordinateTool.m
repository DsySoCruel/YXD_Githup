//
//  GetCoordinateTool.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "GetCoordinateTool.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


AMapLocationManager* _locationManager;

@interface GetCoordinateTool ()<AMapLocationManagerDelegate>

//@property (nonatomic, strong) BMKGeoCodeSearch *geocodesearch;//地理编码搜索
//@property (nonatomic, copy) NSString *province;
//@property (nonatomic, copy) NSString *city;
//@property (nonatomic, copy) NSString *district;
//@property (nonatomic, assign) CLLocationCoordinate2D coord;
@property (nonatomic, strong) GetCoordinateModel *model;


@end


@implementation GetCoordinateTool

- (GetCoordinateModel *)model{
    if (!_model) {
        _model = [[GetCoordinateModel alloc] init];
    }
    return _model;
}

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}


+ (GetCoordinateTool *)getCoordinateTool{
    static GetCoordinateTool *root = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        root = [[self alloc]init];
    });
    return root;
}

- (void)getCoordinateToolActionWith:(getCoordinateBlock)block{
    [self startLocation];
    self.block = block;
}

- (void)startLocation{
    //高德定位sdk
    [[AMapServices sharedServices] setEnableHTTPS:YES];
    [AMapServices sharedServices].apiKey = @"5b3de31c939d0e03a09992370e201f3b";
    _locationManager = [[AMapLocationManager alloc] init];
    _locationManager.delegate = self;
    //设置定位最小更新距离方法如下，单位米。当两次定位距离满足设置的最小更新距离时，SDK会返回符合要求的定位结果。
    _locationManager.distanceFilter = 200;
    //是否返回逆地理信息
    _locationManager.locatingWithReGeocode = YES;
    //iOS 9（不包含iOS 9） 之前设置允许后台定位参数，保持不会被系统挂起
    [_locationManager setPausesLocationUpdatesAutomatically:NO];
    //iOS 9（包含iOS 9）之后新特性：将允许出现这种场景，同一app中多个locationmanager：一些只能在前台定位，另一些可在后台定位，并可随时禁止其后台定位。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    //开始持续定位
    [_locationManager startUpdatingLocation];
}

/*
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError{
    NSLog(@"%ld",iError);
    //    BMKLocationManager *locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    _locationManager.delegate = self;
    //设置返回位置的坐标系类型
    _locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //设置应用位置类型
    _locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    _locationManager.pausesLocationUpdatesAutomatically = YES;
    //设置是否允许后台定位
    _locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    _locationManager.locationTimeout = 10;
    //设置获取地址信息超时时间
    _locationManager.reGeocodeTimeout = 10;
    
    [_locationManager requestLocationWithReGeocode:YES withNetworkState:YES completionBlock:^(BMKLocation * _Nullable location, BMKLocationNetworkState state, NSError * _Nullable error) {
        
        //        BMKLocationReGeocode *rgcData = location.rgcData;
        
        //        NSLog(@"%@",rgcData.district);
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        if (location) {//得到定位信息，添加annotation
            
            if (location.location) {
                NSLog(@"LOC = %@",location.location);
                self.model.coord2D = location.location.coordinate;
            }
            if (location.rgcData) {
                NSLog(@"rgc = %@",[location.rgcData description]);
                self.model.city = [location.rgcData city];
            }else{
                self.model.city = @"定位失败";
            }
//            self.model.province = self.province;
//            self.model.district = self.district;
            
            if (self.block) {
                self.block(self.model);
            }
        }
        NSLog(@"netstate = %d",state);
    }];
}
*/

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
    
    if (location) {
        NSLog(@"LOC = %@",location);
        //坐标
        self.model.coord2D = location.coordinate;
    }

    if (reGeocode)
    {
        NSLog(@"reGeocode:%@", reGeocode);
        self.model.city = reGeocode.city;
        
        if (reGeocode.AOIName.length) {
            self.model.xiaoqu = reGeocode.AOIName;
        }else{
            self.model.xiaoqu = [NSString stringWithFormat:@"%@%@",reGeocode.street,reGeocode.number];
        }
        
        if (self.block) {
            self.block(self.model);
        }

        //停止定位
        [_locationManager stopUpdatingLocation];
    }else{
        self.model.city = @"定位中";
    }
}

@end
