//
//  HelpCenterDetailController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "HelpCenterDetailController.h"

@interface HelpCenterDetailController ()

@property (nonatomic,strong) UILabel *mainLabel;

@end

@implementation HelpCenterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"articleId"] = self.articleId;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_showHelp parameters:parames successed:^(id json) {
        if (json) {
            Weakself.mainLabel = [UILabel new];
            Weakself.mainLabel.numberOfLines = 0;
            Weakself.mainLabel.textColor = TEXTGray_COLOR;
            Weakself.mainLabel.font = LPFFONT(15);
            NSString *str = json[@"articleContent"];
            str = [str stringByReplacingOccurrencesOfString:@"&nbsp;"withString:@" "];
            str = [str stringByReplacingOccurrencesOfString:@"&emsp;"withString:@" "];
            str = [str stringByReplacingOccurrencesOfString:@"<br>"withString:@"\r\n"];
            str = [str stringByReplacingOccurrencesOfString:@"<br />"withString:@"\r\n"];
            str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
            str = [str stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"<u>" withString:@""];
            str = [str stringByReplacingOccurrencesOfString:@"</u>" withString:@""];

            Weakself.mainLabel.text = str;
            [Weakself.view addSubview:Weakself.mainLabel];
            [Weakself.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset = 10;
                make.right.offset = -10;
                make.top.offset = 84;
            }];
        }
    } failure:^(NSError *error) {
        
    }];
}

@end
