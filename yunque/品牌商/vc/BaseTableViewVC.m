//
//  BaseVC.m
//  YNPageViewController
//
//  Created by ZYN on 2018/6/22.
//  Copyright © 2018年 yongneng. All rights reserved.
//

#import "BaseTableViewVC.h"
#import "MJRefresh.h"
#import "BaseViewController.h"
#import "UIViewController+YNPageExtend.h"
#import "YJShowShopTableViewCell.h"
#import "YJHotShopModel.h"
#import "YJShowShopDeatilShopingViewController.h"

/// 开启刷新头部高度
#define kOpenRefreshHeaderViewHeight 0
/// cell高度
#define kCellHeight 44

@interface BaseTableViewVC () <UITableViewDataSource, UITableViewDelegate>{
      int page;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
/// 占位cell高度
@property (nonatomic, assign) CGFloat placeHolderCellHeight;

@end

@implementation BaseTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
     _dataArray = @[].mutableCopy;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"id"];
    [self.view addSubview:self.tableView];
    __weak __typeof(self) weakSelf = self;
       [self.tableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
           NSLog(@"pageIndex:%zd",pageIndex);
           //weakSelf.page = pageIndex;
           [weakSelf getNetworkData:YES];
       }];
       
       [self.tableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
           NSLog(@"pageIndex:%zd",pageIndex);
           //weakSelf.page = pageIndex;
           [weakSelf getNetworkData:NO];
       }];
   
    /// 加载数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        for (int i = 0; i < 30; i++) {
//            [_dataArray addObject:@""];
//        }
//        [self.tableView reloadData];
//    });
     [self getNetworkData:YES];
   // [self addTableViewRefresh];
}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    if (page ==1) {
        [_dataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    NSString *url;
    if ([self.cellTitle isEqualToString:@"2"]) {
         url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pageNum=%d&pageSize=20&brandId=%@",BASE_URL,page,_brandID];
    }else{
         url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pageNum=%d&pageSize=20&categoryId=%@&brandId=%@",BASE_URL,page,_cellTitle,_brandID];
    }
    
   
    NSLog(@"url = %@",url);
    //NSString *hotStrPOST = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {

        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                YJHotShopModel *model = [[YJHotShopModel alloc]init];
             
                model.dataDictionary = mydic;
                [self->_dataArray addObject:model];
            }
            //NSLog(@"da == %lu",(unsigned long)self->dataArray.count);
            if ([[dic objectForKey:@"content"] count]) {
                [self.tableView endFooterRefresh];;
                [self.tableView reloadData];
            }else{
                [self.tableView endFooterNoMoreData];
            }
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
//     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.tableView.mj_header beginRefreshing];
//    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"--%@--%@", [self class], NSStringFromSelector(_cmd));
}

///// 添加下拉刷新
//- (void)addTableViewRefresh {
//    __weak typeof (self) weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 3; i++) {
//                [weakSelf.dataArray addObject:@""];
//            }
//            [weakSelf.tableView reloadData];
//            if (kOpenRefreshHeaderViewHeight) {
//                [weakSelf suspendTopReloadHeaderViewHeight];
//            } else {
//                [weakSelf.tableView.mj_header endRefreshing];
//            }
//        });
//    }];
//
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 3; i++) {
//                [weakSelf.dataArray addObject:@""];
//            }
//            [weakSelf.tableView reloadData];
//            [weakSelf.tableView.mj_footer endRefreshing];
//        });
//    }];
//}

#pragma mark - 悬浮Center刷新高度方法
- (void)suspendTopReloadHeaderViewHeight {
    /// 布局高度
    CGFloat netWorkHeight = 400;
    __weak typeof (self) weakSelf = self;
    
    /// 结束刷新时 刷新 HeaderView高度
    [self.tableView.mj_header endRefreshingWithCompletionBlock:^{
        YNPageViewController *VC = weakSelf.yn_pageViewController;
        if (VC.headerView.frame.size.height != netWorkHeight) {
            VC.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, netWorkHeight);
//            CGFloat g = -VC.config.tempTopHeight;
            [VC reloadSuspendHeaderViewFrame];
//            [self.tableView setContentOffset:CGPointMake(0, g - 100) animated:NO];
        }
    }];
}

#pragma mark - 求出占位cell高度
- (CGFloat)placeHolderCellHeight {
    CGFloat height = self.config.contentHeight - kCellHeight * self.dataArray.count;
    height = height < 0 ? 0 : height;
    return height;
}

#pragma mark - UITableViewDelegate  UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row < self.dataArray.count) {
//        return kCellHeight;
//    }
    return 140 + 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *identifier = @"showTopProidentifier";
              
              YJShowShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
              if (!cell) {
                  cell = [[YJShowShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                  [cell configUI:indexPath];
              }
              if (_dataArray.count) {
                  YJHotShopModel *model = [_dataArray objectAtIndex:indexPath.row];
                  cell.model = model;
                  
                  
              }
              cell.backgroundColor = [UIColor whiteColor];
              cell.selectionStyle = UITableViewCellSelectionStyleNone;
              
              
              return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    YJHotShopModel *model = [_dataArray objectAtIndex:indexPath.row];
    YJShowShopDeatilShopingViewController *vc = [[YJShowShopDeatilShopingViewController alloc]init];
    vc.WebStr = [NSString stringWithFormat:@"http://h5.maikehome.cn/?token=%@&productid=%@&userid=%@",tokenID,model.commodityId,userID];
    vc.ShopIDStr = model.commodityId;
    [self.navigationController pushViewController:vc animated:NO];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    NSLog(@"----- %@ delloc", self.class);
}

@end
