//
//  HomeAlertView.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/20.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeAlertView.h"
#import "HomeAlertViewCell.h"

static NSString *kHomeAlertViewCellhaha = @"HomeAlertViewCellhaha";

/**
 *  主屏的宽
 */
#define DEF_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  主屏的高
 */
#define DEF_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface HomeAlertView ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *arr;
@property(nonatomic,assign)CGFloat rowHeight;   // 行高
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *arrow;
@property(nonatomic,assign)NSInteger index;    //记录选中行

@end

@implementation HomeAlertView

-(id)initWithListDataSource:(NSMutableArray *)array
                  rowHeight:(CGFloat)rowHeight
{
    self = [super initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
    if (self)
    {
        self.arr = array;
        self.rowHeight = rowHeight;
    }
    return self;
}
-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, DEF_SCREEN_HEIGHT)];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
        [_bgView addGestureRecognizer:tap1];
    }
    return _bgView;
}
-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEF_SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        [_tableView registerClass:[HomeAlertViewCell class] forCellReuseIdentifier:kHomeAlertViewCellhaha];
        _tableView.estimatedRowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
-(NSMutableArray *)arr
{
    if (!_arr)
    {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
//-(UIImageView *)arrow
//{
//    if (!_arrow)
//    {
//        _arrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 35, 10, 20, 20)];
//        _arrow.image = [UIImage imageNamed:@"ico_make"];
//    }
//    return _arrow;
//}
/**
 *   显示下拉列表
 */
-(void)showList
{
    [self addSubview:self.bgView];
    [self addSubview:self.tableView];
    [self.tableView reloadData];
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 1;
        self.tableView.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, self.rowHeight * self.arr.count);
    }];
}
/**
 *  隐藏
 */
-(void)hiddenList
{
    [UIView animateWithDuration:0.25f animations:^{
        self.bgView.alpha = 0;
        self.tableView.frame = CGRectMake(0, 64, DEF_SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [_bgView removeFromSuperview];
        [_tableView removeFromSuperview];
        _tableView = nil;
        [self removeFromSuperview];
    }];
}

- (void)adView1Action{
    [self hiddenList];
}

#pragma mark - UITableViewDelegateAndUITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeAlertViewCellhaha];
    cell.model = self.arr[indexPath.row];
    return cell;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
#pragma mark ----------------UITableView  表的选中方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hiddenList];
//    self.index = indexPath.row;
    if ([self.delegate respondsToSelector:@selector(dropDownListParame:)])
    {
        [self.delegate dropDownListParame:self.arr[indexPath.row]];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.rowHeight;
}

@end
