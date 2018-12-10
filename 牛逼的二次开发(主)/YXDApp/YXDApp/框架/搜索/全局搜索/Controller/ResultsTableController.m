//
//  ResultsTableController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/23.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ResultsTableController.h"
#import "HomeTableViewCell.h"
#import "HomeViewModel.h"
#import "ShopController.h"

static NSString * kResultsTableController = @"ResultsTableController";


@interface ResultsTableController ()

@end

@implementation ResultsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 150;
    [self.tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:kResultsTableController];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kResultsTableController];
    cell.model = self.dataSourceArray[indexPath.row];
    cell.baseViewController = self.navigationController;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeViewModel *model = self.dataSourceArray[indexPath.row];
    ShopController *shopView = [ShopController new];
    shopView.shopId = model.shopId;
    [self.nav pushViewController:shopView animated:YES];
}

@end
