//
//  YJNewShopDetailViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJNewShopDetailViewController.h"
#import "YJNewShopDetailTableViewCell.h"
#import "YJHotShopModel.h"



@interface YJNewShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
     int page;
     NSMutableArray *DataArray;
}

@end

@implementation YJNewShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text = @"新品";
    self.view.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    DataArray = [[NSMutableArray alloc]init];
    page = 1;
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
        [DataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *hotStr = [NSString stringWithFormat:@"新品"];
    NSString *url = [NSString stringWithFormat:@"%@/product/groupProdcutQury",BASE_URL];
    NSDictionary *dic;
    if ([userID integerValue]) {
        dic = @{@"pageNum":[NSNumber numberWithInteger:page],
                @"pageSize":[NSNumber numberWithInteger:20],
                @"userId":userID,
                @"groupName":hotStr,
                };
        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                NSDictionary *dic = [result objectForKey:@"data"];
                for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                    YJHotShopModel *model = [[YJHotShopModel alloc]init];
                    model.dataDictionary = mydic;
                    [self->DataArray addObject:model];
                }
                if ([[dic objectForKey:@"content"] count]) {
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
    //  NSString *hotStrPOST = [hotStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [DataArray count];
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
    return 140;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = [UIColor redColor];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    return titleView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DataArray.count) {
    static NSString *identifier = @"NewShopDetailProidentifier";
    
    YJNewShopDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJNewShopDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if ([DataArray count]) {
        YJHotShopModel *Model =[DataArray objectAtIndex:indexPath.row];
        cell.model = Model;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    }else{
         static NSString *identifier = @"NewNodatBundproductidentifier";
         
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
