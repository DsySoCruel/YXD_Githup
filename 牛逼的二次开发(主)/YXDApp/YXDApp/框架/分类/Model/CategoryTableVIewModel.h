//
//  CategoryTableVIewModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/21.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryTableVIewModel : NSObject

@property (nonatomic,assign) BOOL isSelect;//是否选中状态
@property (nonatomic,strong) NSString *parentId;
@property (nonatomic,strong) NSString *catId;
@property (nonatomic,strong) NSString *isShow;
@property (nonatomic,strong) NSString *catName;//标题名字
@property (nonatomic,strong) NSString *priceSection;
@property (nonatomic,strong) NSString *catSort;
@property (nonatomic,strong) NSString *catFlag;
@property (nonatomic,strong) NSString *isFloor;
@property (nonatomic,strong) NSString *catPath;


@end
