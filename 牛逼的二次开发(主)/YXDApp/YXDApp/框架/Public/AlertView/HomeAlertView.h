//
//  HomeAlertView.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeAlertViewModel.h"


@protocol AndyDropDownDelegate <NSObject>

/**
 *  代理
 */
-(void)dropDownListParame:(HomeAlertViewModel *)model;

@end

@interface HomeAlertView : UIView

/**
 *  下拉列表
 *  @param array       数据源
 *  @param rowHeight   行高
 */
-(id)initWithListDataSource:(NSMutableArray *)array
                  rowHeight:(CGFloat)rowHeight;

/**
 *  设置代理
 */
@property(nonatomic,assign)id<AndyDropDownDelegate>delegate;

/**
 *   显示下拉列表
 */
-(void)showList;
/**
 *   隐藏
 */
-(void)hiddenList;

@end
