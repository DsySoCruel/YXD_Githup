//
//  FunctionCollectCellModel.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionCollectCellModel : NSObject
/** 图标 */
@property (nonatomic, strong) NSString *icon;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 子标题 */
/** 需要跳转的控制器类名 */
@property (nonatomic, assign) Class destVcClass;
/** 点击这个cell想做的操作 */
@property (nonatomic, copy) void (^operation)(void);

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithTitle:(NSString *)title;

@end
