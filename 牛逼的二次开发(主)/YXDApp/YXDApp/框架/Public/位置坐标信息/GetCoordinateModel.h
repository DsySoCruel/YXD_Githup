//
//  GetCoordinateModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/19.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>



@interface GetCoordinateModel : NSObject

@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;//城市
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *xiaoqu;
@property (nonatomic, copy) NSString *cityId;//没有值说明没有开通（待用）
@property (nonatomic, assign) CLLocationCoordinate2D coord2D;//经纬度信息

@end
