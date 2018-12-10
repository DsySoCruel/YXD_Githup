//
//  SearchHistoryCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/23.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "SearchHistoryCell.h"
#import "HotSearchModel.h"

#define screenW [UIScreen mainScreen].bounds.size.width

@interface SearchHistoryCell ()
@property (nonatomic, strong) UILabel *parameterName;

@end

@implementation SearchHistoryCell


- (UILabel *)parameterName{
    if (!_parameterName) {
        self.parameterName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, screenW, 20)];
        self.parameterName.textColor = [UIColor grayColor];
        self.parameterName.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.parameterName];
    }
    return _parameterName;
}



- (void)configureCellWithArray:(NSMutableArray *)array{
    
    self.parameterName.text = @"热门搜索";
    
    for (int i = 0; i < array.count; i++) {
        HotSearchModel *model = array[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.titleLabel.numberOfLines = 1;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [button setTitle:model.searchText forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        //设置tag
        button.tag = 10000 + i;
        [self.contentView addSubview:button];
    }
    
    CGFloat padding = 10;
    CGFloat buttonX = 0;
    CGFloat buttonY = 20;
    
    
    //设置frame
    for (int j = 0; j < array.count; j++) {
        HotSearchModel *model = array[j];

        //获取button
        UIButton *button = (UIButton *)[self.contentView viewWithTag:10000 + j];
        //由内容计算button宽度
        CGSize contentSize = [self contentSizeForPromiseWith:model.searchText];
        
        //如果剩余的距离不够的话 从新设置Y
        if ((screenW - buttonX) < (contentSize.width + 40)||(contentSize.width + 40) > screenW) {
            //如果是数组中的第一个对象的话Y值依然为0;
            if (j == 0) {
                buttonY = 20;
            }else{
//                PGYLog(@"+++++");
                
                buttonY += 40;
            }
            buttonX = 0;
        }
        
        if ((contentSize.width + 40) > screenW) {
            
            CGFloat moreH = [self contentHeightWith:model.searchText width:(screenW - 40)] + 20;
            
            button.frame = CGRectMake(padding + buttonX, padding + buttonY, screenW - 20,moreH );
            button.layer.cornerRadius = moreH*0.2;
            buttonY += (moreH + 5);
        }else{
            button.frame = CGRectMake(padding + buttonX, padding + buttonY, contentSize.width + 20, contentSize.height + 20);
            button.layer.cornerRadius = (contentSize.height + 20)*0.2;
            //对X重新赋值
            buttonX = CGRectGetMaxX(button.frame);
        }
    }
}


/**
 *  点击执行代理方法
 */
- (void)buttonAction:(UIButton *)sender{
    
//    PGYLog(@"搜索%@",sender.titleLabel.text);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchHotKeywordAction: withKeyword:)]) {
        [self.delegate searchHotKeywordAction:self withKeyword:sender.titleLabel.text];
    }
    
}

+ (CGFloat)configureCellWithArry:(NSArray *)dataArray{
    
    //计算总高度
    
    CGFloat padding = 10;
    CGFloat buttonX = 0;
    CGFloat buttonY = 20;
    
    
    //设置frame
    for (int z = 0; z < dataArray.count; z++) {
        HotSearchModel *model = dataArray[z];
        //由内容计算button宽度
        CGSize contentSize = [model.searchText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        
        //如果剩余的距离不够的话 从新设置Y
        
//        PGYLog(@"%f %f",screenW - buttonX ,contentSize.width + 40 );
        
        if ((screenW - buttonX) < (contentSize.width + 40)) {
            //如果是数组中的第一个对象的话Y值依然为0;
            
            if (z == 0) {
                
                buttonY = 20;
            }else{
                buttonY += 40;
            }
            buttonX = 0;
            
            
        }else{
            
            buttonX += (padding + contentSize.width + 20);
            
        }
        
    }
    
    //    CGFloat lastObjectW = [dataArray.lastObject sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
    
    //判断多行情况是否是数组的最后一个
    
    
    return buttonY + 60;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    
    static NSString *hotSearchCell = @"hotSearchCell";
    SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:hotSearchCell];
    if (cell == nil) {
        cell = [[SearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotSearchCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

//单行计算宽度(传入字符串)
- (CGSize)contentSizeForPromiseWith:(NSString *)string{
    return [string sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
}

//自适应高度
- (CGFloat)contentHeightWith:(NSString *)str width:(CGFloat)width{
    CGFloat height = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
    return height;
}
@end
