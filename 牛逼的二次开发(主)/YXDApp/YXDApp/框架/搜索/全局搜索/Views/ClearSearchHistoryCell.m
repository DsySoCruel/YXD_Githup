//
//  ClearSearchHistoryCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/23.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ClearSearchHistoryCell.h"


@interface ClearSearchHistoryCell ()

@property (nonatomic, strong) UILabel *clearSearchHistory;

@end


@implementation ClearSearchHistoryCell

- (UILabel *)clearSearchHistory{
    if (!_clearSearchHistory) {
        self.clearSearchHistory = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 40)];
        self.clearSearchHistory.text = @"清除搜索记录";
        self.clearSearchHistory.textAlignment = NSTextAlignmentCenter;
        self.clearSearchHistory.textColor = [UIColor grayColor];
        self.clearSearchHistory.font = [UIFont systemFontOfSize:13];
    }
    return _clearSearchHistory;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.clearSearchHistory];
    }
    
    return  self;
}


//- (void)layoutSubviews{
//    self.clearSearchHistory.frame = self.contentView.frame;
//}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *clearSearchHistoryCell = @"clearSearchHistoryCell";
    ClearSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:clearSearchHistoryCell];
    if (cell == nil) {
        cell = [[ClearSearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clearSearchHistoryCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
