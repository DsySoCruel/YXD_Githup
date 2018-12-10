//
//  ShopDetailCommentController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/1/16.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopDetailCommentController.h"
#import "ShopDetailCommentCell.h"
#import "ShopDetailCommentControllerModel.h"
#import "ShopMessageModel.h"

static NSString * kShopDetailCommentCell = @"ShopDetailCommentCell";

@interface ShopDetailCommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *bottomViewL;
@property (nonatomic,strong) UIView *bottomViewR;

@property (nonatomic,strong) UILabel *balanceNumLabel;//余额数
@property (nonatomic,strong) UILabel *balanceLabel;//余额
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *discountsNumLabel;//优惠卷数
@property (nonatomic,strong) UILabel *discountsLabel;//优惠卷


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger cape;//分页筛选（上提加载）

@end

@implementation ShopDetailCommentController

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺评论";
    self.view.backgroundColor = BACK_COLOR;
    
    [self setUpUI];
    [self setUpLayout];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[ShopDetailCommentCell class] forCellReuseIdentifier:kShopDetailCommentCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 190;
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset = 70 + 64 + 1;
        make.left.right.bottom.offset = 0;
    }];
    
    [self loadNewsData];
}

- (void)setUpUI{
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.bottomViewL = [UIView new];
    self.bottomViewL.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.bottomViewL];
    
    self.balanceNumLabel = [UILabel new];
    self.balanceNumLabel.textColor = TEXT_COLOR;
    self.balanceNumLabel.font = BPFFONT(20);
    self.balanceNumLabel.text = self.model.appraises;
    [self.bottomViewL addSubview:self.balanceNumLabel];
    
    self.balanceLabel = [UILabel new];
    self.balanceLabel.text = @"综合评分";
    self.balanceLabel.textColor = TEXT_COLOR;
    self.balanceLabel.font = LPFFONT(12);
    [self.bottomViewL addSubview:self.balanceLabel];
    
    self.bottomViewR = [UIView new];
    self.bottomViewR.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.bottomViewR];
    
    self.discountsNumLabel = [UILabel new];
    self.discountsNumLabel.textColor = TEXT_COLOR;
    self.discountsNumLabel.font = BPFFONT(20);
    self.discountsNumLabel.text = self.model.commentNum;
    [self.bottomViewR addSubview:self.discountsNumLabel];
    
    self.discountsLabel  =[UILabel new];
    self.discountsLabel.text = @"评论条数";
    self.discountsLabel.textColor = TEXT_COLOR;
    self.discountsLabel.font = LPFFONT(12);
    [self.bottomViewR addSubview:self.discountsLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.lineView];
    
}

- (void)setUpLayout{
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = 0;
        make.height.offset = 70;
        make.top.offset = 64;
    }];
    
    [self.bottomViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset = 0;
        make.top.offset = 0;
        make.right.equalTo(self.bottomViewR.mas_left).offset = 0;
        make.width.equalTo(self.bottomViewR);
    }];
    
    [self.bottomViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset = 0;
        make.top.offset = 0;
        make.left.equalTo(self.bottomViewL.mas_right).offset = 0;
        make.width.equalTo(self.bottomViewL);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 0.5;
        make.height.offset = 50;
        make.bottom.offset = -10;
        make.centerX.equalTo(self.bottomView.mas_centerX);
    }];
    
    [self.balanceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 10;
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -10;
    }];
    [self.discountsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 10;
    }];
    [self.discountsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -10;
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopDetailCommentCell];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)loadNewsData{
    self.cape = 1;
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"shopId"] = self.shopId;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_showMoreAppraises parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.dataArray removeAllObjects];
            NSArray *array = [ShopDetailCommentControllerModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
            if (Weakself.dataArray.count == 0) {
                [self showEmptyMessage:@"暂无评论"];
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
    parames[@"shopId"] = self.shopId;
    parames[@"pcurr"] = [NSString stringWithFormat:@"%tu",self.cape];
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_showMoreAppraises parameters:parames successed:^(id json) {
        if (json) {
            NSArray *array = [ShopDetailCommentControllerModel mj_objectArrayWithKeyValuesArray:json[@"list"]];
            [Weakself.dataArray addObjectsFromArray:array];
            [Weakself.tableView reloadData];
        }
        [Weakself.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        [Weakself.tableView.mj_footer endRefreshing];
    }];
}

- (void)setModel:(ShopMessageModel *)model{
    _model = model;
}

@end
