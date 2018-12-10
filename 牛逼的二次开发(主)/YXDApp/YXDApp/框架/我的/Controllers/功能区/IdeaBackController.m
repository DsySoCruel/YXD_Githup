//
//  IdeaBackController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "IdeaBackController.h"
#import "IdeaBackCell.h"
#import "AddIdeaBackController.h"
#import "IdeaBackModel.h"
#import "GiveCommentController.h"

static NSString * kIdeaBackCell = @"IdeaBackCell";


@interface IdeaBackController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *addAdressButton;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）




@end

@implementation IdeaBackController


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setupUI];
    [self setupLayout];
}
-(void)setupUI{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[IdeaBackCell class] forCellReuseIdentifier:kIdeaBackCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self loadNewsData];
    }];
    self.tableView.mj_footer = [RefreshFooterView footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    
    [self.view addSubview:self.tableView];
    [self loadNewsData];
    
    self.addAdressButton = [UIButton  buttonWithType:UIButtonTypeCustom];
    [self.addAdressButton setTitle:@"添加反馈意见" forState:UIControlStateNormal];
    [self.addAdressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.addAdressButton.backgroundColor = THEME_COLOR;
    self.addAdressButton.titleLabel.font = MFFONT(14);
    [self.addAdressButton addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addAdressButton];
}

- (void)setupLayout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset = 0;
        make.bottom.offset = -40;
    }];
    [self.addAdressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset = 0;
        make.top.equalTo(self.tableView.mas_bottom);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IdeaBackCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdeaBackCell];
    IdeaBackModel *model =  self.dataArray[indexPath.row];
    cell.model = model;
    WeakObj(self);
    cell.deleCellBlock = ^(NSString *addressId) {
        for (IdeaBackModel *addressModel in Weakself.dataArray) {
            if ([addressModel.feedbackId isEqualToString:addressId]) {
                [Weakself.dataArray removeObject:addressModel];
                break;
            }
        }
        [Weakself.tableView reloadData];
        if (Weakself.dataArray.count == 0) {
            [Weakself showEmptyMessage:@"暂无反馈信息"];
        }
    };
    return cell;
}


#pragma mark - 新建收货地址
- (void)addAddressAction:(UIButton *)sender{
//    AddIdeaBackController *controller = [AddIdeaBackController new];
//    WeakObj(self);
//    controller.addSuccessBlock = ^{
//        [Weakself.dataArray removeAllObjects];
//        [Weakself loadNewsData];
//    };
//    [self.navigationController pushViewController:controller animated:YES];
    GiveCommentController *aa = [GiveCommentController new];
    [self.navigationController pushViewController:aa animated:YES];
}


- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_feedList parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [IdeaBackModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无反馈信息"];
            }else{
                [self hideEmptyView];
            }
        }
        [Weakself.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    self.cape++;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_feedList parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [IdeaBackModel mj_objectArrayWithKeyValuesArray:json[@"root"]];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
        
    }];
}

@end
