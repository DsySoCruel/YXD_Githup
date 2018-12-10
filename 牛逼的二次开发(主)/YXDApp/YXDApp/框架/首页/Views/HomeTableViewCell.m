//
//  HomeTableViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeTableCellTopView.h"
#import "HomeTableViewCollectCell.h"
#import "HomeViewModel.h"
#import "HomeTableViewSonCell.h"
#import "GoodController.h"

static NSString *kHomeTableViewCollectCell = @"HomeTableViewCollectCell";
static NSString *kHomeTableViewSonCell = @"HomeTableViewSonCell";


@interface HomeTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) HomeTableCellTopView *topView;
@property (nonatomic,strong) UIView *line1;
//@property (nonatomic,strong) UILabel *lingjuan;
//@property (nonatomic,strong) UILabel *lingjuan1;
//@property (nonatomic,strong) UILabel *jianman;
//@property (nonatomic,strong) UILabel *jianman1;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YXDButton *hotSellGoods;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *line2;

@property (nonatomic,strong) NSMutableArray *dataSourceArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end


@implementation HomeTableViewCell


- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    self.topView = [HomeTableCellTopView new];
    [self.contentView addSubview:self.topView];
    
    self.line1 = [UIView new];
    self.line1.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.line1];
    
//    self.lingjuan = [UILabel new];
//    self.lingjuan.text = @"领卷";
//    self.lingjuan.textColor = [UIColor whiteColor];
//    self.lingjuan.backgroundColor = [UIColor redColor];
//    self.lingjuan.font = MFFONT(13);
//    self.lingjuan.layer.cornerRadius = 3;
//    self.lingjuan.textAlignment = NSTextAlignmentCenter;
//    [self.contentView addSubview:self.lingjuan];
    
//    self.lingjuan1 = [UILabel new];
//    self.lingjuan1.text = @"9.0折券";
//    self.lingjuan1.textColor = TEXTGray_COLOR;
//    [self.contentView addSubview:self.lingjuan1];

//    self.jianman = [UILabel new];
//    self.jianman.text = @"满减";
//    self.jianman.textColor = [UIColor whiteColor];
//    self.jianman.backgroundColor = THEME_COLOR;
//    self.jianman.layer.cornerRadius = 3;
//    self.jianman.textAlignment = NSTextAlignmentCenter;
//    self.jianman.font = MFFONT(13);
//    [self.contentView addSubview:self.jianman];
    
//    self.jianman1 = [UILabel new];
//    self.jianman1.text = @"部分商品满88减20";
//    self.jianman1.textColor = TEXTGray_COLOR;
//    [self.contentView addSubview:self.jianman1];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[HomeTableViewSonCell class] forCellReuseIdentifier:kHomeTableViewSonCell];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 25;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = BACK_COLOR;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.userInteractionEnabled = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    
    self.hotSellGoods = [YXDButton buttonWithType:UIButtonTypeCustom];
    [self.hotSellGoods setTitle:@"热销商品" forState:UIControlStateNormal];
    [self.hotSellGoods setImage:IMAGECACHE(@"fire") forState:UIControlStateNormal];
    [self.hotSellGoods setTitleColor:TEXTGray_COLOR forState:UIControlStateNormal];
    self.hotSellGoods.titleLabel.font = LPFFONT(12);
    self.hotSellGoods.padding = 5;
    self.hotSellGoods.userInteractionEnabled = NO;
    [self.contentView addSubview:self.hotSellGoods];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 100) / 4, 87);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[HomeTableViewCollectCell class] forCellWithReuseIdentifier:kHomeTableViewCollectCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setContentInset:UIEdgeInsetsMake(0, 85, 0, 0)];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
//    self.collectionView.userInteractionEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.contentView addSubview:self.collectionView];
    
    self.line2 = [UIView new];
    self.line2.backgroundColor = BACK_COLOR;
    [self.contentView addSubview:self.line2];

}

- (void)setupLayout{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset = 0;
        make.top.offset = 15;
        make.height.offset = 60;
//        make.bottom.equalTo(self.contentView.mas_bottom).offset = -20;
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 85;
        make.height.offset = 0.5;
        make.right.offset = 0;
        make.top.equalTo(self.topView.mas_bottom).offset = 5;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1.mas_left);
        make.top.equalTo(self.line1.mas_bottom).offset = 0;
        make.height.offset = 50;
        make.right.offset = -5;
    }];
    
    [self.hotSellGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.line1.mas_left).offset = 2;
        make.top.equalTo(self.tableView.mas_bottom).offset = 3;
        make.height.offset = 20;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.hotSellGoods.mas_bottom).offset = 0;
        make.right.left.offset = 0;
        make.height.offset = 100;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = -10;
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 1;
        make.bottom.offset = 0;
    }];
}

#pragma mark- UICollectionViewDatasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHomeTableViewCollectCell forIndexPath:indexPath];
    HomeViewModelGoodList *model = self.dataSourceArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodController *goodController = [GoodController new];
    HomeViewModelGoodList *model = self.dataSourceArray[indexPath.row];
    goodController.goodsId = model.goodsId;
    goodController.shopId = self.model.shopId;
    [self.baseViewController pushViewController:goodController animated:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewSonCell *cell = [tableView dequeueReusableCellWithIdentifier:kHomeTableViewSonCell];
    HomeViewModelTicket *model =  self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)setModel:(HomeViewModel *)model{
    _model = model;
    self.topView.homeModel = model;
    [self.dataSourceArray removeAllObjects];
    [self.dataSourceArray addObjectsFromArray:model.goodList];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:model.ticket];
    
    //设置减免和领卷以及热销商品不存在的情况
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset = 25 * model.ticket.count;
    }];
    
    if (self.dataSourceArray.count == 0) {
        self.hotSellGoods.hidden = YES;
        [self.hotSellGoods mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom).offset = 0;
            make.height.offset = 0;
        }];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 0;
        }];
    }else{
        self.hotSellGoods.hidden = NO;
        [self.hotSellGoods mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tableView.mas_bottom).offset = 3;
            make.height.offset = 20;
        }];
        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset = 100;
        }];
    }
    [self.collectionView reloadData];
    [self.tableView reloadData];
}


@end
