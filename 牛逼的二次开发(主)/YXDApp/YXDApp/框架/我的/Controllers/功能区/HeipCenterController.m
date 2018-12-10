//
//  HeipCenterController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HeipCenterController.h"
#import "HeipCenterModel.h"
#import "HelpCenterDetailController.h"
#import "HelpCenterCell.h"

static NSString *kHelpCenterCell = @"HelpCenterCell";

@interface HeipCenterController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation HeipCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    
    self.dataArray = [NSMutableArray array];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[HelpCenterCell class] forCellReuseIdentifier:kHelpCenterCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HeipCenterModel *model = self.dataArray[section];
    return model.articlecats.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YXDScreenW, 35)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, YXDScreenW - 20, 20)];
    titleLabel.font = LPFFONT(17);
    titleLabel.textColor = TEXTGray_COLOR;
    HeipCenterModel *model = self.dataArray[section];
    titleLabel.text = model.catName;
    [headView addSubview:titleLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:kHelpCenterCell];
    HeipCenterModel *model = self.dataArray[indexPath.section];
    HeipCenterModelTwoModel *twoModel = model.articlecats[indexPath.row];
    twoModel.articleTitle = [twoModel.articleTitle stringByReplacingOccurrencesOfString:@"&amp;"withString:@"/"];
    cell.model = twoModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HeipCenterModel *model = self.dataArray[indexPath.section];
    HeipCenterModelTwoModel *twoModel = model.articlecats[indexPath.row];
    HelpCenterDetailController *vc = [HelpCenterDetailController new];
    vc.title = twoModel.articleTitle;
    vc.articleId = twoModel.articleId;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)loadData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_helpCenter parameters:parames successed:^(id json) {
        if (json) {
            NSArray *moreArray = [HeipCenterModel mj_objectArrayWithKeyValuesArray:json];
            [Weakself.dataArray addObjectsFromArray:moreArray];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无帮助信息"];
            }else{
                [self hideEmptyView];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
