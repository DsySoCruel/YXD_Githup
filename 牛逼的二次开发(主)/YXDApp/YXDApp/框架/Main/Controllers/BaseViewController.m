//
//  BaseViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/15.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong) UIView *emptyView;
@property (nonatomic,strong) UILabel *messageLabel;

@end

@implementation BaseViewController

- (UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [UIView new];
    }
    return _emptyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"------------------------------>>>>> %@ <<<<<------------------------------", self.class);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (BaseViewController*)topViewController {
    return (BaseViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

-(void)showEmptyMessage:(NSString *)message{
    [self.view addSubview:self.emptyView];
    self.messageLabel = [UILabel new];
    self.messageLabel.textColor = TEXTGray_COLOR;
    self.messageLabel.text = message;
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = LPFFONT(13);
    [self.emptyView addSubview:self.messageLabel];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 200;
        make.centerY.offset = 0;
    }];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset = 0;
    }];
}
-(void)hideEmptyView{
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
}

@end
