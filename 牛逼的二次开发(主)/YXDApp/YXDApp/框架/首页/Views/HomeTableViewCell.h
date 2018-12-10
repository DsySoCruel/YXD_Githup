//
//  HomeTableViewCell.h
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeViewModel;
@interface HomeTableViewCell : UITableViewCell

@property (nonatomic,strong) HomeViewModel *model;

@property (nonatomic,strong) UINavigationController *baseViewController;

@end
