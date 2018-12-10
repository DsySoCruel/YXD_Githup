//
//  ZhaopinController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "ZhaopinController.h"

@interface ZhaopinController ()
@property (nonatomic,strong) UIImageView *backImageView;
@end

@implementation ZhaopinController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"配送员招募";
    self.backImageView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"mine_zhaopin_backImage")];
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.offset = 0;
        make.top.offset = 64;
    }];
}

@end
