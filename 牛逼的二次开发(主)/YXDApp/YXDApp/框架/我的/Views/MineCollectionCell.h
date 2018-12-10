//
//  MineCollectionCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FunctionCollectCellModel.h"

@interface MineCollectionCell : UICollectionViewCell

@property (nonatomic,strong) FunctionCollectCellModel *model;

-(instancetype)initWithFrame:(CGRect)frame;

@end
