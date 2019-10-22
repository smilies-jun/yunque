//
//  YJHistoryViewController.m
//  maike
//
//  Created by Apple on 2019/8/1.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJHistoryViewController.h"
#import "YJShowShopTableViewCell.h"
#import "UserAdresssTableViewCell.h"
#import "ShopTableViewCell.h"
#import "YJShopListViewController.h"

@interface YJHistoryViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    int page;
    NSMutableArray *dataArray;
}

@end

@implementation YJHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"足迹历史";
    self.view.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    page = 1;
    dataArray = [[NSMutableArray alloc]init];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    __weak __typeof(self) weakSelf = self;
    [shopListTableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:YES];
    }];
    
    [shopListTableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:NO];
    }];
    
    [self getNetworkData:YES];
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, 40)];
//    searchBar.placeholder = @"搜索内容";
//    searchBar.hidden = NO;
//    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
//    searchBar.delegate = self;
//    searchBar.showsCancelButton = NO;
//    UIView *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
//    searchTextField.backgroundColor = [UIColor whiteColor];
//    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
//    //修改标题和标题颜色
//    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.view addSubview:searchBar];
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
    [shopListTableview.mj_header endRefreshing];
    [shopListTableview.mj_footer endRefreshing];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    if (page ==1) {
        [dataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    
    NSString *userID = NSuserUse(@"userId");
    

    NSString *url = [NSString stringWithFormat:@"%@/product/queryFootPrint?userId=%@",BASE_URL,userID];
    //NSString *hotStrPOST = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSArray *array = [result objectForKey:@"data"];
            for (NSDictionary *mydic in array) {
                YJHotShopModel *model = [[YJHotShopModel alloc]init];
                model.dataDictionary = mydic;
                [self->dataArray addObject:model];
            }
            
            if ([array count]) {
                [self->shopListTableview endFooterRefresh];;
                [self->shopListTableview reloadData];
            }else{
                [self->shopListTableview endFooterNoMoreData];
            }
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJShopListViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArray.count) {
        return [dataArray count];
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
            return 140;
     
    }
    return SCREEN_HEIGHT - 64;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor redColor];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    return titleView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (dataArray.count) {
    static NSString *identifier = @"historyProidentifier";
    
    YJShowShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJShowShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
     if (dataArray.count) {
         YJHotShopModel *model = [dataArray objectAtIndex:indexPath.row];
         cell.model = model;
     }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
 }else{
     static NSString *identifier = @"NodatBundproductidentifier";
     
     NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
     if (!cell) {
         cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
         [cell configUI:indexPath];
         cell.backgroundColor = [UIColor whiteColor];
         cell.ImageView.image = [UIImage imageNamed:@"暂无客户"];
         // cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
         
     }
     
     //  cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
 }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
