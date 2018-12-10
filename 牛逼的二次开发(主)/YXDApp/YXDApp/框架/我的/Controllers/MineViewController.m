//
//  MineViewController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/11/14.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "MineViewController.h"
#import "MineCollectionCell.h"
#import "FunctionCollectCellModel.h"
#import "MyMoneyController.h"
#import "MyYouhujuanController.h"
#import "NotificationMessageController.h"
#import "ChangePhoneController.h"


static NSString *identify = @"customCell";

@interface MineViewController ()<UINavigationControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate>
//1.头部视图
@property (nonatomic,strong) UIImageView *headerView;
//@property (nonatomic,strong) UIButton *erweimaButton;
@property (nonatomic,strong) UIButton *lingButton;
@property (nonatomic,strong) UIButton *userImage;//用户图像
@property (nonatomic,strong) UILabel *nameLabel;//用户名字
@property (nonatomic,strong) UIButton *editImage;//编辑图像
@property (nonatomic,strong) UIButton *quiButton;//退出按钮

@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *bottomViewL;
@property (nonatomic,strong) UIView *bottomViewR;

@property (nonatomic,strong) UILabel *balanceNumLabel;//余额数
@property (nonatomic,strong) UILabel *balanceLabel;//余额
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *discountsNumLabel;//优惠卷数
@property (nonatomic,strong) UILabel *discountsLabel;//优惠卷

//2.功能区
@property (nonatomic,weak) UICollectionView *collectionView;

//3.数据区
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation MineViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

//界面每次出现就要请求下数据有 ： 余额
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
    //请求余额
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        parames[@"accessToken"] = UserAccessToken;
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_mybalance parameters:parames successed:^(id json) {
            if (json) {
                NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",json[@"balance"]]];
                [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleString.length)];
                [titleString addAttribute:NSFontAttributeName value:LPFFONT(20) range:NSMakeRange(1, titleString.length-1)];
                [Weakself.balanceNumLabel setAttributedText:titleString];
                Weakself.discountsNumLabel.text = json[@"mycoupon"];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BACK_COLOR;
    /*
     接收通知 来自修改密码的通知 当修改完成密码后需要在次界面重新用新密码登录
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMyUIaction) name:@"updateMyUI" object:nil];
    
    // 初始化模型数据
//    [self setupGroups];
    
    [self setupUI];
    [self setupLayout];
        
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)setupHeader{
    self.headerView = [[UIImageView alloc] initWithImage:IMAGECACHE(@"mine_back")];
    
//    self.erweimaButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.erweimaButton setImage:IMAGECACHE(@"mine_erweima") forState:UIControlStateNormal];
//    [self.erweimaButton addTarget:self action:@selector(erweimaButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.headerView addSubview:self.erweimaButton];
    
    self.lingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lingButton setImage:IMAGECACHE(@"mine_ling") forState:UIControlStateNormal];
    [self.lingButton addTarget:self action:@selector(lingButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.lingButton];

    self.userImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.userImage setImage:IMAGECACHE(@"icon_00") forState:UIControlStateNormal];
    self.userImage.backgroundColor = [UIColor whiteColor];
    self.userImage.layer.cornerRadius = 30;
    self.userImage.layer.masksToBounds = YES;
    [self.userImage addTarget:self action:@selector(iconChange) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.userImage];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.font = LPFFONT(14);
    [self.headerView addSubview:self.nameLabel];
    
    self.editImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.editImage setImage:IMAGECACHE(@"mine_edit") forState:UIControlStateNormal];
    [self.editImage addTarget:self action:@selector(editImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.editImage];
    
    self.quiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quiButton.backgroundColor = RGB(0x70B22A);
    self.quiButton.titleLabel.font = LPFFONT(14);
    self.quiButton.layer.cornerRadius = 16;
    [self.quiButton addTarget:self action:@selector(quiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.quiButton];
    
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    self.bottomViewL = [UIView new];
    self.bottomViewL.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.bottomViewL];
    
    self.balanceNumLabel = [UILabel new];
    [self.bottomViewL addSubview:self.balanceNumLabel];
    
    self.balanceLabel = [UILabel new];
    self.balanceLabel.text = @"余额";
    [self.bottomViewL addSubview:self.balanceLabel];
    
    self.bottomViewR = [UIView new];
    self.bottomViewR.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.bottomViewR];
    
    self.discountsNumLabel = [UILabel new];
    [self.bottomViewR addSubview:self.discountsNumLabel];
    
    self.discountsLabel  =[UILabel new];
    self.discountsLabel.text = @"优惠卷";
    [self.bottomViewR addSubview:self.discountsLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = BACK_COLOR;
    [self.bottomView addSubview:self.lineView];

    
//    UIImageView *heardBackImageView = [UIImageView new];
//    heardBackImageView.backgroundColor = [UIColor lightGrayColor];
//    heardBackImageView.frame = CGRectMake(0, 0, YXDScreenW, YXDScreenW * 0.5);
//    [self.headerView  addSubview:heardBackImageView];
    
    //设置头像
//    UIImageView *iconImage = [[UIImageView alloc] init];
//    iconImage.rcm_width = heardView.rcm_height * 0.4;
//    iconImage.layer.cornerRadius = iconImage.rcm_width * .5;
//    iconImage.layer.masksToBounds = YES;
//    iconImage.contentMode = UIViewContentModeScaleAspectFill;
//    iconImage.rcm_height = iconImage.rcm_width;
//    iconImage.rcm_centerY = heardView.rcm_centerY;
//    iconImage.rcm_x = 30;
//
//    [heardView addSubview:iconImage];
//    _iconImage = iconImage;
    
    
    //设置箭头
//    UIImageView *meArrows = [[UIImageView alloc] initWithImage:imageNamed(@"to_right_white")];
//    meArrows.rcm_width = 15;
//    meArrows.rcm_height = 20;
//    meArrows.rcm_centerY = iconImage.rcm_centerY;
//    meArrows.rcm_centerX = YXDScreenW - 23;
//    [heardView addSubview:meArrows];
    
    
    
    //设置信息展示label
//    UILabel *nameLabel = [[UILabel alloc] init];
////    nameLabel.font = fontOfSize(18);
//    nameLabel.rcm_x = iconImage.rcm_right + 10;
//    nameLabel.rcm_centerY = iconImage.rcm_centerY - iconImage.rcm_height * 0.25;
//    [heardView addSubview:nameLabel];
//    _nameLabel = nameLabel;
    

    //设置登录注册label
    
//    UILabel *loginLabel = [[UILabel alloc] init];
//    loginLabel.text = @"登录/注册";
//    [loginLabel sizeToFit];
//    loginLabel.rcm_centerY =  iconImage.rcm_centerY;
//    loginLabel.rcm_x = iconImage.rcm_x + iconImage.rcm_width + 10;
//    [heardView addSubview:loginLabel];
//    _loginLabel = loginLabel;
    
    //判断头部显示内容
//    [self panduanpresent];
    
#pragma mark -添加手势
    //1.头部
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap1:)];
    self.headerView.userInteractionEnabled = YES;
    [self.headerView addGestureRecognizer:tap1];
    //2.余额
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap2:)];
    self.headerView.userInteractionEnabled = YES;
    [self.bottomViewL addGestureRecognizer:tap2];
    //3.优惠卷
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap3:)];
    self.headerView.userInteractionEnabled = YES;
    [self.bottomViewR addGestureRecognizer:tap3];
    [self.view addSubview:self.headerView];
}



//- (void)panduanpresent{
//
//
//    //判断有没有登录
//    //1.没有登录
//
//    if ([RCMUserInfoStore account]) {
//
//
//        self.nameLabel.hidden = NO;
//        self.messageLabel.hidden = NO;
//        self.loginLabel.hidden = YES;
//
//        //头像设置图片
//
//        [self.iconImage setRcm_circleImage:[RCMUserInfoStore account].userImage];
//
//
//        NSLog(@"%@",[RCMUserInfoStore account].userImageUrl);
//
//        self.nameLabel.text = [RCMUserInfoStore account].realName;
//        [self.nameLabel sizeToFit];
//
//        self.messageLabel.text = [NSString stringWithFormat:@"邀请码:%@",[RCMUserInfoStore account].userCode];
//        [self.messageLabel sizeToFit];
//
//
//    }else{
//
//        self.nameLabel.hidden = YES;
//        self.messageLabel.hidden = YES;
//        self.loginLabel.hidden = NO;
//
//        //头像设置图片
//
//        self.iconImage.image = [UIImage imageWithBorderWidth:2 borderColor:UNAble_color image:@"morentouxiang"];
//
//
//    }
//
//}


/*
 *1.登录跳转到修改信息
 *2.未登录进行登录
 */
//- (void)doTap:(NSString *)str{
//
//    RCMUserInfoModel *account = [RCMUserInfoStore account];
//
//
//    if (account){
//        UpdataMessageController *upVC = [[UpdataMessageController alloc] init] ;
//        [self.navigationController pushViewController:upVC animated:YES];
//    }else{
//
//        [self presentViewController:[RCMLoginViewController shareLoginVC] animated:YES completion:nil];
//    }
//
//}

//登录成功后刷新我的界面
- (void)updateMyUIaction{
//    [self panduanpresent];
    
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        //已经登录
        YXDUserInfoModel *userModel = [YXDUserInfoStore sharedInstance].userModel;
        self.nameLabel.text = userModel.userName.length ? userModel.userName:userModel.loginName;
        [self.quiButton setTitle:@"退出登录" forState:UIControlStateNormal];
        self.discountsNumLabel.text = userModel.myCoupons;
        self.editImage.hidden = NO;
        [self.userImage sd_setImageWithURL:([userModel.userPhoto hasPrefix:@"http"] ?[NSURL URLWithString:userModel.userPhoto]:URLWithImageName(userModel.userPhoto)) forState:UIControlStateNormal placeholderImage:IMAGECACHE(@"icon_00")];

    }else{
        self.nameLabel.text = @"未登录";
        [self.quiButton setTitle:@"点击登录" forState:UIControlStateNormal];
        
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥0.00"]];
        [titleString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, titleString.length)];
        [titleString addAttribute:NSFontAttributeName value:LPFFONT(20) range:NSMakeRange(1, titleString.length-1)];
        [self.balanceNumLabel setAttributedText:titleString];

        self.discountsNumLabel.text = @"0";
        self.editImage.hidden = YES;
        
        [self.userImage setImage:IMAGECACHE(@"icon_00") forState:UIControlStateNormal];

    }

}


#pragma mark- UI
- (void)setupUI{
    
    //1.设置头部
    [self setupHeader];
    
    //2.设置功能区
    //设置数据
    self.dataArray = [NSMutableArray array];
     
     FunctionCollectCellModel *mode1 = [FunctionCollectCellModel itemWithTitle:@"我的关注" icon:@"mine_guanzhu"];
     mode1.destVcClass = NSClassFromString(@"MyAttentionController");
     [self.dataArray addObject:mode1];
    
     FunctionCollectCellModel *mode2 = [FunctionCollectCellModel itemWithTitle:@"我的评价" icon:@"mine_pingjia"];
    mode2.destVcClass = NSClassFromString(@"MyCommentController");
     [self.dataArray addObject:mode2];
    
     FunctionCollectCellModel *mode3 = [FunctionCollectCellModel itemWithTitle:@"我的地址" icon:@"mine_dizhi"];
    mode3.destVcClass = NSClassFromString(@"MyAddressController");
     [self.dataArray addObject:mode3];
    
     FunctionCollectCellModel *mode4 = [FunctionCollectCellModel itemWithTitle:@"帮助中心" icon:@"mine_help"];
    mode4.destVcClass = NSClassFromString(@"HeipCenterController");
     [self.dataArray addObject:mode4];
    
     FunctionCollectCellModel *mode5 = [FunctionCollectCellModel itemWithTitle:@"配送员招募" icon:@"mine_zhaopin"];
    mode5.destVcClass = NSClassFromString(@"ZhaopinController");
     [self.dataArray addObject:mode5];
    
     FunctionCollectCellModel *mode6 = [FunctionCollectCellModel itemWithTitle:@"意见反馈" icon:@"mine_yijian"];
    mode6.destVcClass = NSClassFromString(@"IdeaBackController");
     [self.dataArray addObject:mode6];
    
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake((self.view.rcm_width - 4)/3, (self.view.rcm_width - 4)/3);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[MineCollectionCell class] forCellWithReuseIdentifier:identify];
    collectionView.backgroundColor = BACK_COLOR;
    collectionView.dataSource = self;
    collectionView.delegate = self;
//    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc ]initWithTarget:self action:@selector(longpAction:)];
//    [collectionView addGestureRecognizer:longP];
    self.collectionView = collectionView;
    
    
//    [self.view addSubview:self.topImageView];
//    [self.topImageView addSubview:self.backButton];
//    [self.topImageView addSubview:self.titleLabel];
//    [self.view addSubview:self.subtitleLabel];
//    [self.view addSubview:self.lineOne];
//    [self.view addSubview:self.lineTwo];
    [self.view addSubview:self.collectionView];
//    [self AnimateUp];
    
    
    //设置选中的id
//
//    HomeTitleTypeRequestData *model = self.menuArray[self.currentPage];
//
//    self.currentId = [model.categoryID integerValue];
//
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0f) {
//        [self showToast:@"系统版本太低,不支持拖动"];
//        NSLog(@"系统版本:%@",[[UIDevice currentDevice] systemVersion]);
//    }
    
    
    [self updateMyUIaction];
}

- (void)setupLayout{
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset = 0;
        make.height.offset = YXDScreenW * .5 + SafeTopSpace;
    }];
    
    [self.lingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset = -15;
        make.top.offset = 30 + SafeTopSpace;
    }];
    
//    [self.erweimaButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.lingButton.mas_left).offset = -15;
//        make.top.offset = 30;
//    }];
    
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 20;
        make.top.offset = YXDScreenW * .25 - 10 + SafeTopSpace;
        make.width.height.offset = 60;
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage);
        make.left.equalTo(self.userImage.mas_right).offset = 10;
    }];
    [self.editImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage);
        make.left.equalTo(self.nameLabel.mas_right).offset = 5;
    }];
    
    [self.quiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage);
        make.right.offset = 16;
        make.width.offset = 100;
        make.height.offset = 32;
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset = 0;
        make.height.offset = 100;
        make.top.equalTo(self.headerView.mas_bottom).offset = -20;
    }];
    
    [self.bottomViewL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.offset = 0;
        make.top.offset = 20;
        make.right.equalTo(self.bottomViewR.mas_left).offset = 0;
        make.width.equalTo(self.bottomViewR);
    }];
    
    [self.bottomViewR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.offset = 0;
        make.top.offset = 20;
        make.left.equalTo(self.bottomViewR.mas_right).offset = 0;
        make.width.equalTo(self.bottomViewL);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset = 1;
        make.height.offset = 50;
        make.bottom.offset = -15;
        make.centerX.equalTo(self.bottomView.mas_centerX);
    }];
    
    [self.balanceNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 15;
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -15;
    }];
    [self.discountsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.top.offset = 15;

    }];
    [self.discountsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset = 0;
        make.bottom.offset = -15;
    }];

    
    
//    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.offset = 0;
//        make.height.mas_equalTo(NAVI_H);
//    }];
//    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset = 4;
//        make.top.offset = 27 + SafeTopSpace;
//        make.width.height.equalTo(@30);
//
//    }];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.backButton.mas_top);
//        make.width.equalTo(@100);
//        make.height.equalTo(@30);
//        make.centerX.mas_equalTo(self.topImageView.mas_centerX);
//


    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView.mas_bottom).offset = 10;
        make.left.right.bottom.offset = 0;
    }];
}




#pragma mark - dat/del

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
//    if (indexPath.item == 0) {//推荐标签不可可动
//        cell.contentView.backgroundColor = RGB(0xF0F5FF);
//    }else{
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//    }
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 3 || indexPath.item == 4) {
        FunctionCollectCellModel *model = self.dataArray[indexPath.row];
        id vc = nil;
        vc = [model.destVcClass new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //判断进行登录
        if ([YXDUserInfoStore sharedInstance].loginStatus) {
            FunctionCollectCellModel *model = self.dataArray[indexPath.row];
            id vc = nil;
            vc = [model.destVcClass new];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
        }
    }
}



////加载向上动画
//-(void)AnimateUp{
//    self.collectionView.hidden = YES;
//    self.backButton.userInteractionEnabled = NO;
//    //上提动画
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0; i < self.menuArray.count; i++) {
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            UICollectionViewCell *currentCell = [self.collectionView cellForItemAtIndexPath:indexPath];
//            currentCell.transform = CGAffineTransformMakeTranslation(0, 200);
//            currentCell.alpha = 0;
//        }
//        self.collectionView.hidden =  NO;
//        self.btnIndex = 0;
//        self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateUP) userInfo:nil repeats:YES];
//    });
//}
//
////向上动画执行
//-(void)updateUP{
//    //如果当前的角标等于当前按钮的个数
//    //让定时器停止
//    if (self.btnIndex == self.menuArray.count) {
//        [self.timer invalidate];
//        self.timer = nil;
//        self.backButton.userInteractionEnabled = YES;
//        return;
//    }
//    //每次取出一个按钮
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.btnIndex inSection:0];
//    UICollectionViewCell *currentCell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    //取消所有形变
//    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        currentCell.transform = CGAffineTransformIdentity;
//        currentCell.alpha = 1;
//    } completion:nil];
//    self.btnIndex++;
//}
//
////加载向下动画
//-(void)AnimateDown{
//    self.btnIndex = self.menuArray.count;
//    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateDown) userInfo:nil repeats:YES];
//
//    [UIView animateWithDuration:0.5 animations:^{
//        self.backButton.transform = CGAffineTransformIdentity;
//        self.view.backgroundColor = [UIColor clearColor];
//        self.topImageView.alpha = 0;
//        self.collectionView.backgroundColor = [UIColor clearColor];
//        self.subtitleLabel.alpha = 0;
//        self.lineOne.alpha = 0;
//        self.lineTwo.alpha = 0;
//    } completion:^(BOOL finished) {
//    }];
//}
//
////向下动画执行
//- (void)updateDown{
//    //如果当前的角标等于当前按钮的个数
//    //让定时器停止
//    if (self.btnIndex < 0) {
//        [self.timer invalidate];
//        [self dismissViewControllerAnimated:YES completion:nil];
//        return;
//    }
//    //每次取出一个按钮
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.btnIndex inSection:0];
//    UICollectionViewCell *currentCell = [self.collectionView cellForItemAtIndexPath:indexPath];
//    //取消所有形变
//    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        currentCell.transform = CGAffineTransformMakeTranslation(0, 200);
//        currentCell.alpha = 0;
//
//    } completion:^(BOOL finished) {
//
//    }];
//    self.btnIndex--;
//}
//
//
//

#pragma mark - 业务逻辑处理层
//退出或者登录
- (void)quiButtonAction:(UIButton *)sender{
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确定要退出吗" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userInfoKey"];
            [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"accessToken"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            [self updateMyUIaction];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }
}

- (void)erweimaButtonAction{
    //判断进行登录
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        NotificationMessageController *notificationC  = [NotificationMessageController new];
        [self.navigationController pushViewController:notificationC animated:YES];
    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }
}

//消息处理
- (void)lingButtonAction:(UIButton *)sender{
    //判断进行登录
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        NotificationMessageController *notificationC  = [NotificationMessageController new];
        [self.navigationController pushViewController:notificationC animated:YES];
    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }
}
//编辑个人信息
- (void)editImageAction{
    ChangePhoneController *vc = [ChangePhoneController new];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -手势执行方法
- (void)doTap1:(UITapGestureRecognizer *)sender{
    //编辑个人信息
    //判断进行登录
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        
    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }

}
- (void)doTap2:(UITapGestureRecognizer *)sender{
    //判断进行登录
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        MyMoneyController *myMoney = [MyMoneyController new];
        [self.navigationController pushViewController:myMoney animated:YES];
    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }
}
- (void)doTap3:(UITapGestureRecognizer *)sender{
    //判断进行登录
    if ([YXDUserInfoStore sharedInstance].loginStatus) {
        MyYouhujuanController *myYouhuijuan = [MyYouhujuanController new];
        [self.navigationController pushViewController:myYouhuijuan animated:YES];
    }else{
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
    }

}

#pragma mark -更新图像信息

//修改图片操作
- (void)iconChange{
    
    if (![YXDUserInfoStore sharedInstance].loginStatus) {
        [self presentViewController:[LoginViewController shareLoginVC] animated:YES completion:nil];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从本地相册上传图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openLocalPhoto];
    }]];
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)openCamera{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    //判断相机是否存在
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;//如果有相机，则设置图片选取器的类型为相机
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)openLocalPhoto{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//设置为图片库
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *editedImage = info[@"UIImagePickerControllerOriginalImage"];
    [MBHUDHelper showLoadingHUDView:self.view withText:@"上传中"];
    //上传图片
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"img"] = [self imageChangeBase64:editedImage];
    NSLog(@"%@",parames[@"img"] );
    [[NetWorkManager shareManager] POST:USER_updataIcon parameters:parames successed:^(id json) {
        if (json) {
            [self.userImage setImage:editedImage forState:UIControlStateNormal];
            [MBHUDHelper showSuccess:@"图片修改成功"];
            //如果返回地址 修改本地存储的地址哦
        }
    } failure:^(NSError *error) {
        
    }];
    //将imagePicker撤销
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(NSString *)imageChangeBase64: (UIImage *)image{
    
    NSData   *imageData = nil;
    //NSString *mimeType  = nil;
    if ([self imageHasAlpha:image]) {
        
        imageData = UIImagePNGRepresentation(image);
        //mimeType = @"image/png";
    }else{
        
        imageData = UIImageJPEGRepresentation(image, 0.3f);
        //mimeType = @"image/jpeg";
    }
    return [NSString stringWithFormat:@"%@",[imageData base64EncodedStringWithOptions: 0]];
}

-(BOOL)imageHasAlpha:(UIImage *)image{
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}


@end
