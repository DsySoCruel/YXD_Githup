//
//  GiveCommentController.m
//  YXDApp
//
//  Created by daishaoyang on 2017/12/26.
//  Copyright © 2017年 beijixing. All rights reserved.
//

#import "GiveCommentController.h"
#import "YXdTextView.h"
#import "RatingBar.h"


#import "TZImagePickerController.h"
//#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import "TZImageManager.h"
#import "SDPhotoBrowser.h"
#import "DSYPhotoModel.h"


@interface GiveCommentController ()<UITextViewDelegate,UIScrollViewDelegate,RatingBarDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,SDPhotoBrowserDelegate>{
    
    NSMutableArray *_selectedPhotos;
    
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _itemWH;
    CGFloat _margin;
    
}

@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,strong) UIImageView *shopImageView;

@property (nonatomic,strong) UILabel *shopNameLabel;

@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;

@property (nullable, strong) RatingBar *bar1;//商家
@property (nullable, strong) RatingBar *bar2;//口味
@property (nullable, strong) RatingBar *bar3;//包装
@property (nullable, strong) RatingBar *bar4;//配送


@property (nonatomic,strong) YXdTextView *textView;
//提交按钮
@property (nonatomic,strong) YXDButton *commintButton;

@property (nonatomic,assign) NSInteger gradeRank1;
@property (nonatomic,assign) NSInteger gradeRank2;
@property (nonatomic,assign) NSInteger gradeRank3;
@property (nonatomic,assign) NSInteger gradeRank4;


//添加照片
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;//调用相机用到
@property (nonatomic, strong) UICollectionView *collectionView;//展示照片
@property (nonatomic, assign) NSInteger maxCountTF;//设置允许选择最多相片
@end

@implementation GiveCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发表评价";
    [self setUpUI];
    [self setLayout];
}

- (void)setUpUI{
    
    self.gradeRank1 = 5;
    self.gradeRank2 = 5;
    self.gradeRank3 = 5;
    self.gradeRank4 = 5;

    
    self.mainScrollView = [UIScrollView new];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.delegate = self;
    self.mainScrollView.contentSize = CGSizeMake(YXDScreenW, YXDScreenH + 1 );
    self.mainScrollView.backgroundColor = BACK_COLOR;
    
    
    self.shopImageView = [UIImageView new];
    self.shopImageView.image = IMAGECACHE(@"icon_0000");
    [self.mainScrollView addSubview:self.shopImageView];
    
    self.shopNameLabel = [UILabel new];
    self.shopNameLabel.text = self.shopName;
    [self.mainScrollView addSubview:self.shopNameLabel];
    
    self.label1 = [UILabel new];
    self.label1.text = @"店铺评分:";
    self.label1.font = LPFFONT(12);
    self.label1.frame = CGRectMake(20, 82, 60, 40);
    [self.mainScrollView addSubview:self.label1];
    
    self.bar1 = [[RatingBar alloc] initWithFrame:CGRectMake(80 ,80, YXDScreenW - 90, 40)];
    self.bar1.enable = YES;
    self.bar1.delegate = self;
    self.bar1.starNumber = 5;
    [self.mainScrollView addSubview:self.bar1];
    
    self.label2 = [UILabel new];
    self.label2.text = @"口味评分:";
    self.label2.font = LPFFONT(12);
    self.label2.frame = CGRectMake(20, 122, 60, 40);
    [self.mainScrollView addSubview:self.label2];
    
    self.bar2 = [[RatingBar alloc] initWithFrame:CGRectMake(80 ,120, YXDScreenW - 90, 40)];
    self.bar2.enable = YES;
    self.bar2.delegate = self;
    self.bar2.starNumber = 5;
    [self.mainScrollView addSubview:self.bar2];
    
    self.label3 = [UILabel new];
    self.label3.text = @"包装评分:";
    self.label3.font = LPFFONT(12);
    self.label3.frame = CGRectMake(20, 162, 60, 40);
    [self.mainScrollView addSubview:self.label3];

    
    self.bar3 = [[RatingBar alloc] initWithFrame:CGRectMake(80 ,160, YXDScreenW - 90, 40)];
    self.bar3.enable = YES;
    self.bar3.delegate = self;
    self.bar3.starNumber = 5;
    [self.mainScrollView addSubview:self.bar3];
    
    self.label4 = [UILabel new];
    self.label4.text = @"配送评分:";
    self.label4.font = LPFFONT(12);
    self.label4.frame = CGRectMake(20, 202, 60, 40);
    [self.mainScrollView addSubview:self.label4];
    
    self.bar4 = [[RatingBar alloc] initWithFrame:CGRectMake(80 ,200, YXDScreenW - 90, 40)];
    self.bar4.enable = YES;
    self.bar4.delegate = self;
    self.bar4.starNumber = 5;
    [self.mainScrollView addSubview:self.bar4];
    
    
    self.textView = [YXdTextView new];
    self.textView.delegate = self;
    self.textView.alwaysBounceVertical = YES; // 垂直方向永远可以滚动(弹簧效果)
    self.textView.placeholder = @"写下您对产品和商家的评论吧";
    self.textView.font = [UIFont systemFontOfSize:15];
    [self.mainScrollView addSubview:self.textView];
    
    
    //设置允许选择最多相片
    self.maxCountTF = 3;
    //3.设置相片资源
    _selectedPhotos = [NSMutableArray array];
    [self configCollectionViewHere];
    
    
    self.commintButton = [YXDButton shareButton];
    //    loginButton.frame = CGRectMake(textFileX + 10, codeTF.rcm_bottom + padding + 10 , textFildW - 20, 40);
    self.commintButton.backgroundColor = THEME_COLOR;
    [self.commintButton setTitle:@"发表评论" forState:UIControlStateNormal];
    [self.commintButton setTintColor:[UIColor whiteColor]];
    [self.commintButton addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:self.commintButton];
}

- (void)starRateView:(RatingBar *)starRateView scroePercentDidChange:(NSInteger)newScorePercent{
    if (starRateView == self.bar1) {
        self.gradeRank1 = newScorePercent;
    }else if (starRateView == self.bar2){
        self.gradeRank2 = newScorePercent;

    }else if (starRateView == self.bar3){
        self.gradeRank3 = newScorePercent;
    }else{
        self.gradeRank4 = newScorePercent;
    }
}

- (void)setLayout{
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.offset = 0;
    }];
    
    [self.shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset = 10;
        make.width.height.offset = 60;
    }];
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopImageView);
        make.left.equalTo(self.shopImageView.mas_right).offset = 15;
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = YXDScreenW - 20;;
        make.top.offset = 250;
        make.height.offset = 150;
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset = 20;
        make.left.right.offset = 0;
        make.height.offset = _itemWH + 5;
    }];
    
    [self.commintButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset = 10;
        make.width.offset = YXDScreenW -20;
        make.top.equalTo(self.collectionView.mas_bottom).offset = 20;
        make.height.offset = 35;
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView endEditing:YES];
}


- (void)commentAction:(UIButton *)sender{
    //有图传图
    NSString *imageLenth = @"";
    if (_selectedPhotos.count > 1) {
        [MBHUDHelper showLoadingHUDView:self.view withText:@"上传中"];
        for (DSYPhotoModel *model in _selectedPhotos) {
            imageLenth = [imageLenth stringByAppendingString:[NSString stringWithFormat:@"%@;",[self imageChangeBase64:model.photo]]];
        }
        WeakObj(self);
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        NSString *str3 = [imageLenth substringToIndex:imageLenth.length - 1];//str3 = "my"
        parames[@"img"] = str3;
        [[NetWorkManager shareManager] POST:USER_multiUpload parameters:parames successed:^(id json) {
            if (json) {
                [Weakself commentFinal:json];
            }
        } failure:^(NSError *error) {
            
        }];
    }else{
        [self commentFinal:@""];
    }

}

- (void)commentFinal:(NSString *)imagePath{
    
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    parames[@"accessToken"] = UserAccessToken;
    parames[@"orderId"] = self.orderId;
    parames[@"shopScore"] = [NSString stringWithFormat:@"%tu",self.gradeRank1];
    parames[@"tasteScore"] = [NSString stringWithFormat:@"%tu",self.gradeRank2];
    parames[@"packScore"] = [NSString stringWithFormat:@"%tu",self.gradeRank3];
    parames[@"transScore"] = [NSString stringWithFormat:@"%tu",self.gradeRank4];
    parames[@"content"] = self.textView.text.length ? self.textView.text : @"";
    if (imagePath.length) {
        parames[@"imgPath"] = imagePath;
    }
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_toAppraises parameters:parames successed:^(id json) {
        if (json) {
            if (Weakself.updateOrderBlock) {
                Weakself.updateOrderBlock();
            }
            [Weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 设置图片模块
/****************设置展示选择照片的集合视图**************/
- (void)configCollectionViewHere{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.mj_w - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    //    layout.footerReferenceSize = CGSizeMake(0, _itemWH + _margin*2);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" withReuseIdentifier:@"footerID"];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (_selectedPhotos.count < 3) {
        return _selectedPhotos.count + 1;
    }
    
    return _selectedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    
    if ((indexPath.item + 1) > _selectedPhotos.count) {
        
        cell.imageView.image = IMAGECACHE(@"addpicture");
        cell.deleteBtn.hidden = YES;
        
    }else{
        
        cell.deleteBtn.hidden = NO;
        cell.photoModel = _selectedPhotos[indexPath.item];
        cell.deleteBtn.tag = indexPath.row;
        [cell.deleteBtn addTarget:self action:@selector(deleteImageBtnClik:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    
    //    ZLPhotoAssets *asset = self.assets[indexPath.item];
    //    if ([asset isKindOfClass:[ZLPhotoAssets class]]) {
    //        cell.imageView.image = asset.thumbImage;
    //    }else if ([asset isKindOfClass:[NSString class]]){
    //        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)asset] placeholderImage:[UIImage imageNamed:@"pc_circle_placeholder"]];
    //    }else if([asset isKindOfClass:[UIImage class]]){
    //        cell.imageView.image = (UIImage *)asset;
    //    }else if ([asset isKindOfClass:[ZLCamera class]]){
    //        cell.imageView.image = [asset thumbImage];
    //    }
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == _selectedPhotos.count) {
        //打开照相机或者相册
        
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
        
        
    }else{
        
        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
        photoBrowser.delegate = self;
        photoBrowser.currentImageIndex = indexPath.item;
        photoBrowser.imageCount = _selectedPhotos.count;
        photoBrowser.sourceImagesContainerView = collectionView;
        [photoBrowser show];
    }
    
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    // 不建议用此种方式获取小图，这里只是为了简单实现展示而已
    
    DSYPhotoModel *photoModel = _selectedPhotos[index];
    
    if (photoModel.url.length) {
        
        TZTestCell *cell = (TZTestCell *)[self collectionView:self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        return cell.imageView.image;
    }else{
        return photoModel.photo;
    }
    
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    
    DSYPhotoModel *photoModel = _selectedPhotos[index];
    
    if (photoModel.url.length) {
        return [NSURL URLWithString:photoModel.url];
    }else{
        return nil;
    }
}




#pragma mark  ---拍照

- (void)openCamera{
    
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无权限 做一个友好的提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (iOS8Later) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"] options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }
            
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
        
        
    } else { // 调用相机
        //1.判断图片数量是否可以打开照相机
        
        
        if (_selectedPhotos.count >= self.maxCountTF) {
            [self presentAlertViewWith:@"提示" message:@"您最多只能选择3张照片"];
            return;
        }
        //2.设置为相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
            
            
        }
    }
    
    
}

#pragma mark ---选择照片
- (void)openLocalPhoto{
    
    //1设置：最大选择数（self.maxCountTF） ：每行照片显示数量 默认 3
    
    
    if (_selectedPhotos.count >= self.maxCountTF) {
        [self presentAlertViewWith:@"提示" message:@"您最多只能选择3张照片"];
        return;
    }
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(self.maxCountTF - _selectedPhotos.count) columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    //是否上传原图
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
    
    //______________________设置拍照按钮不在内部显示————————————————————————
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    
    // 2. 在这里设置imagePickerVc的外观
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // 3. 设置是否可以选择视频/图片/原图
    //______________________设置是否可以选择视频/图片/原图————————————————————————
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.minImagesCount = 0;
    imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // 你可以通过block或者代理，来得到用户选择的照片.
    //    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
    //
    //    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


#pragma mark 资源库采集的两个方法

//1.创建拍照界面控制器
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

//1.摄像机镜头拍摄照片或者视频后 点击使用后调用
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) { // 如果保存失败，基本是没有相册权限导致的...
                [tzImagePickerVc hideProgressHUD];
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法保存图片" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    if (iOS8Later) {
                        
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                        }];
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"] options:@{} completionHandler:^(BOOL success) {
                            
                        }];
                        
                        
                    } else {
                        
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                            
                        }];
                    }
                    
                }]];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }]];
                
                //弹出提示框；
                [self presentViewController:alert animated:true completion:nil];
                
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        
                        
                        NSMutableArray *numArray = [NSMutableArray arrayWithObjects:@1,@2,@3,nil];
                        
                        
                        //判断当前 pic 1 2 3 那个可用?
                        for (DSYPhotoModel *model in _selectedPhotos) {
                            if (model.num == 1) {
                                //1.不可用
                                [numArray removeObject:@1];
                            }
                            if (model.num == 2) {
                                //2.不可用
                                [numArray removeObject:@2];
                            }
                            if (model.num == 3) {
                                //3.不可用
                                [numArray removeObject:@3];
                            }
                        }
                        DSYPhotoModel *model = [[DSYPhotoModel alloc] init];
                        model.photo = image;
                        model.asset = assetModel.asset;
                        model.num = [numArray.firstObject integerValue];
                        [_selectedPhotos addObject:model];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_collectionView reloadData];
                        });
                    }];
                }];
            }
        }];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - TZImagePickerControllerDelegate
// 2.选择图片后点击完成调用
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    //目标很明确，只管添加
    
    NSMutableArray *numArray = [NSMutableArray arrayWithObjects:@1,@2,@3,nil];
    
    for (int i = 0; i < photos.count; i++) {
        
        for (DSYPhotoModel *model in _selectedPhotos) {
            if (model.num == 1) {
                //1.不可用
                [numArray removeObject:@1];
            }
            if (model.num == 2) {
                //2.不可用
                [numArray removeObject:@2];
            }
            if (model.num == 3) {
                //3.不可用
                [numArray removeObject:@3];
            }
        }
        
        DSYPhotoModel *model = [[DSYPhotoModel alloc] init];
        model.photo = photos[i];
        model.asset = assets[i];
        model.num = [numArray.firstObject integerValue];
        [_selectedPhotos addObject:model];
    }
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [_collectionView reloadData];
    
}


//图库取消按钮方法 拍照界面取消方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark Click Event
//点击图片删除按钮
- (void)deleteImageBtnClik:(UIButton *)sender {
    [self presentAlertViewWith:sender];
}

//各种警告框
- (void)presentAlertViewWith:(NSString *)title message:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
}

//删除图片和视频验证
- (void)presentAlertViewWith:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认删除吗" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if (sender) {
            [_selectedPhotos removeObjectAtIndex:sender.tag];
            
            [_collectionView reloadData];
            
        }
    }]];
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
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
