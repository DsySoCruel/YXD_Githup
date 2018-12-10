//
//  SearchHistoryCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/12/23.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchHistoryCell;
@protocol SearchHistoryCellDelegate <NSObject>

- (void)searchHotKeywordAction:(SearchHistoryCell *)cell
                   withKeyword:(NSString *)keyWord;

@end

@interface SearchHistoryCell : UITableViewCell

@property (nonatomic, assign) id<SearchHistoryCellDelegate> delegate;

- (void)configureCellWithArray:(NSMutableArray *)array;

+ (CGFloat)configureCellWithArry:(NSArray *)dataArray;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
