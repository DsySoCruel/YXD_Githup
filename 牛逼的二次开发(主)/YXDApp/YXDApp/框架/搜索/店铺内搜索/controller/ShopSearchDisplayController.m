//
//  ShopSearchDisplayController.m
//  YXDApp
//
//  Created by daishaoyang on 2018/6/19.
//  Copyright © 2018年 beijixing. All rights reserved.
//

#import "ShopSearchDisplayController.h"
#import "ShopResultsTableViewController.h"
#import "SearchHistoryCell.h"
#import "ClearSearchHistoryCell.h"
#import "SearchResultModel.h"
#import "HotSearchModel.h"
#import "ShopResultsTableViewModel.h"

@interface ShopSearchDisplayController ()<UISearchResultsUpdating,UISearchBarDelegate,UISearchControllerDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,SearchHistoryCellDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) ShopResultsTableViewController *resultsTableController;

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *hotSearchSaveArray;
@property (nonatomic, strong) NSMutableArray *searchResultArray;

//搜索历史持久化
@property (nonatomic,   copy) NSString *filePath;
@property (nonatomic, strong) NSMutableArray *keywordsArray;

@property (nonatomic, strong) UILabel *presentLabel;
@end

@implementation ShopSearchDisplayController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:!isShowHomePage animated:YES];
}

- (UILabel *)presentLabel{
    if (!_presentLabel) {
        self.presentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, YXDScreenW, 200)];
        self.presentLabel.text = @"暂无搜索信息";
        self.presentLabel.textColor = TEXTGray_COLOR;
        self.presentLabel.numberOfLines = 0;
        self.presentLabel.font = LPFFONT(13);
        self.presentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _presentLabel;
}
/**
 *  搜索结果保存在这个数组
 */
- (NSMutableArray *)searchResultArray{
    if (!_searchResultArray) {
        self.searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
}
/**
 *  热门搜索词条保存在这个数组中
 */
- (NSMutableArray *)hotSearchSaveArray{
    if (!_hotSearchSaveArray) {
        self.hotSearchSaveArray = [NSMutableArray array];
    }
    return _hotSearchSaveArray;
}

/**
 *  搜索历史保存数组
 */
- (NSMutableArray *)keywordsArray {
    if (!_keywordsArray) {
        self.keywordsArray = [NSMutableArray array];
    }
    return _keywordsArray;
}


- (NSString *)filePath {
    if (!_filePath) {
        self.filePath = [[NSString alloc] init];
    }
    return _filePath;
}



- (UITableView *)mainTableView{
    if (!_mainTableView) {
        self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.mainTableView.delegate = self;
        self.mainTableView.dataSource = self;
        self.mainTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.mainTableView.showsVerticalScrollIndicator = NO;
        self.mainTableView.tableFooterView = [[UIView alloc] init];
        self.mainTableView.separatorInset = UIEdgeInsetsZero;
        
    }
    return _mainTableView;
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    
    //设置电池条为黑色
    
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    /**
     *  隐藏导航条返回按钮
     */
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.delegate = self;

    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //    [self.navigationController.navigationBar addSubview:self.searchController.searchBar];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*NSEC_PER_SEC)),dispatch_get_main_queue(), ^{// 1.0s后执行block里面的代码
        
        self.navigationController.navigationBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //延时执行才能让输入框变为第一响应者
        [self.searchController.searchBar becomeFirstResponder];
    });
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchController.searchBar becomeFirstResponder];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    /**
     *  隐藏导航条返回按钮
     */
    //    self.navigationItem.hidesBackButton = NO;
    //    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //
    //    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.barTintColor = THEME_COLOR;
    //    self.navigationController.navigationBar.hidden = NO;
    
    //    [self.searchController.searchBar removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /**
     *  获取热门搜索
     */
    
//    [self requsetHotSearchHistoryData];
    
    /**
     *  读取搜索历史记录
     */
//    [self _writeStringToFile];
    
    /**
     去除导航条黑线
     */
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    
    _resultsTableController = [[ShopResultsTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.searchController.searchBar.backgroundImage = [self imageWithColor:[UIColor groupTableViewBackgroundColor] size:self.searchController.searchBar.bounds.size];
    self.searchController.searchBar.placeholder = @"搜索店内商品";
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchController.searchBar;
        
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchBar.showsCancelButton = YES;
    self.searchController.searchBar.tintColor = THEME_COLOR;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    //    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
    
    [self.view addSubview:self.mainTableView];
    
}
//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  1.获取热门搜索
 */
- (void)requsetHotSearchHistoryData{
    NSMutableDictionary *parames = [NSMutableDictionary dictionary];
    parames[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
    //    parames[@"accessToken"] = UserAccessToken;
    WeakObj(self);
    [[NetWorkManager shareManager] POST:USER_getHotAndHistory parameters:parames successed:^(id json) {
        if (json) {
            [Weakself.hotSearchSaveArray removeAllObjects];
            NSArray *array = [HotSearchModel mj_objectArrayWithKeyValuesArray:json[@"hot"]];
            [Weakself.hotSearchSaveArray addObjectsFromArray:array];
            [Weakself.mainTableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark mainTableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.keywordsArray.count > 0 ? 2 : 1 ;
    return 0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    
    return self.keywordsArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        if (tableView == self.mainTableView) {
            return [SearchHistoryCell configureCellWithArry:self.hotSearchSaveArray];
        }
    }
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //使cell分割线顶到边
    if ([self.mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.mainTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.mainTableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.mainTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        return nil;
    }
    
    UIView *titleV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    titleV.backgroundColor = [UIColor whiteColor];
    UILabel *titleLa = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.view.bounds.size.width, 20)];
    titleLa.backgroundColor = [UIColor whiteColor];
    titleLa.font = [UIFont systemFontOfSize:11];
    titleLa.textColor = [UIColor grayColor];
    titleLa.text = @"搜索历史";
    [titleV addSubview:titleLa];
    return titleV;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SearchHistoryCell *cell = [SearchHistoryCell cellWithTableView:tableView];
        cell.delegate = self;
        [cell configureCellWithArray:self.hotSearchSaveArray];
        return cell;
    }
    
    
    if (indexPath.section == 1 && indexPath.row == self.keywordsArray.count) {
        ClearSearchHistoryCell *cell = [ClearSearchHistoryCell cellWithTableView:tableView];
        
        return cell;
    }
    
    static NSString *searchHistoryCell = @"searchHistoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchHistoryCell];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchHistoryCell];
    }
    
    //    NSInteger num = self.keywordsArray.count - indexPath.row;
    
    cell.textLabel.text = self.keywordsArray[self.keywordsArray.count - indexPath.row - 1];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.mainTableView) {//没有在输入框输入信息的时候
        if (indexPath.section == 1) {
            if (indexPath.row == self.keywordsArray.count) {//清除搜索历史记录
                [self.keywordsArray removeAllObjects];
                [self.keywordsArray writeToFile:self.filePath atomically:YES];
                [self.mainTableView reloadData];
            }else{//1.由搜索历史进入搜索结果列表界面
                [self searchGoodMessagesByKeyWord:self.keywordsArray[self.keywordsArray.count - indexPath.row - 1]];
            }
        }
    }
}

//===========数据持久化================
- (void)_writeStringToFile {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取沙盒路径下的document进行归档
    //获取地址
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentPath stringByAppendingPathComponent:@"serchKeyword.plist"];
    BOOL result = [fileManager fileExistsAtPath:path];
    if (!result) {
        //不包含
        NSString *path1 = [documentPath stringByAppendingPathComponent:@"serchKeyword.plist"];
        self.filePath = path1;
    } else {
        //包含
        self.filePath = path;
        self.keywordsArray = [NSMutableArray arrayWithContentsOfFile:self.filePath];
    }
}
/**
 *  滑动的时候释放键盘
 */

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.mainTableView) {
        [self.searchController.searchBar resignFirstResponder];
    }
}

/**
 *  搜索界面上的取消按钮
 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    [self.navigationController popViewControllerAnimated:YES];
    [[BaseViewController topViewController].navigationController popViewControllerAnimated:NO];
}
/**
 *  搜索界面上的键盘搜索按钮
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if (self.searchController.searchBar.text.length > 0) {
        if(![self.keywordsArray containsObject:self.searchController.searchBar.text]) {
            [self.keywordsArray addObject:self.searchController.searchBar.text];
            /**
             *  超过五条删除
             */
            if (self.keywordsArray.count > 5) {
                [self.keywordsArray removeObjectAtIndex:0];
            }
            [self.keywordsArray writeToFile:self.filePath atomically:YES];
        }
        
        if (self.searchResultArray.count == 0) {
//            [self searchGoodMessagesByKeyWord:searchBar.text];
            [self searchGoodMessagesByKeyWord:searchBar.text];
        }
    }
    //即使把搜索记录添加到搜索历史列表
    [self.mainTableView reloadData];
}

/**
 *  2.模糊搜索方法实时调用
 */
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchText = searchController.searchBar.text;
//    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self searchGoodMessagesByKeyWord:searchText];
}

#pragma mark searchHistoryDeleage
/**
 *  1.点击热门搜索按钮走的代理方法  --进行跳转搜索
 *
 */
- (void)searchHotKeywordAction:(SearchHistoryCell *)cell withKeyword:(NSString *)keyWord{
//    self.searchController.searchBar.text = keyWord;
//    [self searchGoodMessagesByKeyWord:keyWord];
}


- (void)searchGoodMessagesByKeyWord:(NSString *)str{
    [self.presentLabel removeFromSuperview];
    if (str.length) {
        ShopResultsTableViewController *tableController = (ShopResultsTableViewController *)self.searchController.searchResultsController;
        [MBHUDHelper showLoadingHUDView:tableController.view];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if ([YXDUserInfoStore sharedInstance].loginStatus) {
            params[@"userId"] = [YXDUserInfoStore sharedInstance].userModel.userId;
        }
        params[@"goodsName"] = str;
        params[@"shopId"] = self.shopId;
        WeakObj(self);
        [[NetWorkManager shareManager] POST:USER_searchGoodsByShopId parameters:params successed:^(id json) {
            if (json) {
                [Weakself.searchResultArray removeAllObjects];
                ShopResultsTableViewController *tableController = (ShopResultsTableViewController *)self.searchController.searchResultsController;
                NSArray *array = [ShopResultsTableViewModel mj_objectArrayWithKeyValuesArray:json[@"goodsList"]];
                [Weakself.searchResultArray addObjectsFromArray:array];
                tableController.dataSourceArray = Weakself.searchResultArray;
                tableController.nav = self.navigationController;
                [tableController.tableView reloadData];
                if (Weakself.searchResultArray.count == 0) {
                    [Weakself.searchController.searchResultsController.view addSubview:Weakself.presentLabel];
                }
            }
        } failure:^(NSError *error) {
            
        }];
    }
}




@end
