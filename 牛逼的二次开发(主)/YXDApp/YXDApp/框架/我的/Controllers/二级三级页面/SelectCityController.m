//
//  SelectCityController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/11.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "SelectCityController.h"
#import "SelectCityModel.h"

static NSString * kSelectCityController = @"kSelectCityController";


@interface SelectCityController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation SelectCityController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择城市";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSelectCityController];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    [self.view addSubview:self.tableView];
    
    [self loadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectCityController];
    //    cell.textLabel.text = @"hahahah ";
    SelectCityModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = model.areaName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectCityModel *model = self.dataArray[indexPath.row];
    if (self.selectCityBlock) {
        self.selectCityBlock(model.areaName,model.areaId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getServiceCity parameters:parames successed:^(id json) {
        if (json) {
            NSArray *moreTopics = [SelectCityModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:moreTopics];
            [Weakself.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
