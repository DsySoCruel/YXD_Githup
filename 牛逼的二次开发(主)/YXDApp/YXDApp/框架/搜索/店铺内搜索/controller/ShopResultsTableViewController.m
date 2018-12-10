//
//  ShopResultsTableViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/6/20.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopResultsTableViewController.h"
#import "HomeSeckillControllerCell.h"
#import "ShopResultsTableViewModel.h"
#import "GoodController.h"

static NSString * kResultsTableController = @"ResultsTableController";

@interface ShopResultsTableViewController ()

@end

@implementation ShopResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 150;
    [self.tableView registerClass:[HomeSeckillControllerCell class] forCellReuseIdentifier:kResultsTableController];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeSeckillControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultsTableController];
    cell.shopResultsTableViewModel = self.dataSourceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopResultsTableViewModel *model = self.dataSourceArray[indexPath.row];    
    GoodController *goodController = [GoodController new];
    goodController.goodsId = model.goodsId;
    goodController.shopId = model.shopId;
    [self.nav pushViewController:goodController animated:YES];
}


@end
