//
//  ShopCarViewCell.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/21.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ShopCarViewCell.h"
#import "HomeCateCollectionViewCell.h"
#import "ShopController.h"
#import "ShopCarViewModel.h"

static NSString *homeCateCollectionViewCell = @"homeCateCollectionViewCell";

@interface ShopCarViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIView *firstView;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UIImageView *jiantouImage;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UILabel *numberLabel;
@end

@implementation ShopCarViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupLayout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setupUI{
    self.contentView.backgroundColor = BACK_COLOR;
    
    self.backView = [UIView new];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    [self.contentView addSubview:self.backView];
    
    self.firstView = [UIView new];
    self.firstView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:self.firstView];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(adView1Action)];
    [self.firstView addGestureRecognizer:tap1];

    
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.font = LPFFONT(14);
    self.shopNameLabel.textColor = TEXTGray_COLOR;
    [self.firstView addSubview:self.shopNameLabel];
    
    self.jiantouImage = [[UIImageView alloc] initWithImage:IMAGECACHE(@"icon_55")];
    [self.firstView addSubview:self.jiantouImage];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.firstView addSubview:self.lineView];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((YXDScreenW - 100) / 4, 90);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[HomeCateCollectionViewCell class] forCellWithReuseIdentifier:homeCateCollectionViewCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    self.collectionView.userInteractionEnabled = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.backView addSubview:self.collectionView];
    
    self.numberLabel = [UILabel new];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = LPFFONT(12);
    self.numberLabel.textColor = TEXTBlack_COLOR;
    [self.backView addSubview:self.numberLabel];
}

- (void)setupLayout{
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset = 10;
        make.right.offset = -10;
        make.bottom.offset = 0;
    }];
    
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset = 0;
        make.height.offset = 45;
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.right.offset = -50;
        make.top.offset = 0;
        make.height.offset = 45;
    }];
    [self.jiantouImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopNameLabel).offset = 0;
        make.right.offset = -10;
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset = 0;
        make.height.offset = 1;
        make.top.equalTo(self.shopNameLabel.mas_bottom).offset = 0;
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 0;
        make.right.offset = -60;
        make.top.equalTo(self.lineView.mas_bottom).offset = 0;
        make.height.offset = 90;
        make.bottom.equalTo(self.contentView.mas_bottom).offset = 0;
    }];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = 0;
        make.left.equalTo(self.collectionView.mas_right).offset = 0;
        make.centerY.equalTo(self.collectionView).offset = 0;
    }];

}



#pragma mark- UICollectionViewDatasource
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeCateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCateCollectionViewCell forIndexPath:indexPath];
    //    cell.model = self.dataArray[indexPath.row];
//    FunctionCollectCellModel *mode1 = [FunctionCollectCellModel itemWithTitle:@"￥16" icon:@"icon_23"];
//    cell.model = mode1;
    cell.goodModel = self.model.cartList[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.model.cartList.count;
}

- (void)adView1Action{
    ShopController *shopView = [ShopController new];
    shopView.shopId = self.model.shopName.shopId;
    [self.navigationController pushViewController:shopView animated:YES];
}

- (void)setModel:(ShopCarViewModel *)model{
    _model = model;
    self.shopNameLabel.text = model.shopName.shopName;
    self.numberLabel.text = [NSString stringWithFormat:@"共%tu件",model.count];
    [self.collectionView reloadData];
}


@end
