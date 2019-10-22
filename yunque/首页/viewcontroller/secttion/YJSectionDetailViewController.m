//
//  YJSectionDetailViewController.m
//  maike
//
//  Created by amin on 2019/8/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJSectionDetailViewController.h"
#import "YJShowShopTableViewCell.h"
#import "YJShopDetailViewController.h"
#import "YJHomeViewController.h"
#import "DropMenuBar.h"
#import "ItemModel.h"
#import "MenuAction.h"
#import "YJAllShopViewController.h"
#import "YJSectionShopViewController.h"
#import "YJShopUserPostTableViewCell.h"
#import "YJShowShopDeatilShopingViewController.h"
#import "YJShopListViewController.h"

@interface YJSectionDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DropMenuBarDelegate>{
    UITableView *shopListTableview;
    int page;
    NSMutableArray *dataArray;
    NSInteger sort;
    NSInteger xiaoLiangNumber;
    NSString *cataID;
    
    
}
@property (nonatomic, strong) DropMenuBar *menuScreeningView;  //条件选择器
@property (nonatomic, strong) NSMutableArray *threeuList;

@end

@implementation YJSectionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text= _TitleStr;
    page =1;
    self.threeuList = [NSMutableArray arrayWithCapacity:0];
    sort = 2;
    xiaoLiangNumber = 2;
    cataID = 0;
    dataArray = [[NSMutableArray alloc]init];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self creatData];
    
}
- (void)creatData {
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        // 三级列表
        
        for (int i = 0; i < [[result objectForKey:@"data"] count]+1; i++) {
            ItemModel *model;
            if(i == 0) {
                model = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", i] isSelect:i == 0];
            }else {
                model = [ItemModel modelWithText:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"]objectAtIndex:i-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"]objectAtIndex:i-1][@"categoryId"]] isSelect:i == 0];
                
                
                NSMutableArray *temp = [NSMutableArray array];
                for (int j = 0; j < [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"] count]+1; j++) {
                    ItemModel *layerModel;
                    if (j == 0) {
                        layerModel = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", j] isSelect:j == 0];
                    }else {
                        
                        layerModel = [ItemModel modelWithText:[NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"categoryId"]] isSelect:j == 0];
                        
                        NSMutableArray *temp2 = [NSMutableArray arrayWithCapacity:0];
                        for (int x = 0; x < [[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"] count]+1; x++) {
                            ItemModel *thirdModel;
                            if (x == 0) {
                                thirdModel = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", x] isSelect:x == 0];
                            }else {
                                thirdModel = [ItemModel modelWithText:[NSString stringWithFormat:@"%@",[[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"]objectAtIndex:x-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@",[[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"]objectAtIndex:x-1][@"categoryId"]] isSelect:x == 0];
                            }
                            [temp2 addObject:thirdModel];
                            
                        }
                        layerModel.dataSource = temp2;
                        
                        
                    }
                    [temp addObject:layerModel];
                    
                    
                }
                
                model.dataSource = temp;
            }
            
            [self.threeuList addObject:model];
            
            
        }
        [self SetUi];
    }];
    
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
        [dataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    
 //   NSString *userID = NSuserUse(@"userId");

    if ([cataID integerValue]) {
        
    }else{
        cataID = _cataIdStr;
    }
    NSString *url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pageNum=%d&pageSize=20&categoryId=%@",BASE_URL,page,_cataIdStr];
    //NSString *hotStrPOST = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"url = %@",url);
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSLog(@"re === %@",result);
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
        NSLog(@"error = %@",error);
    }];
    
}
- (void)ShopListBackClick{
    //    for (UIViewController *controller in self.navigationController.viewControllers) {
    //        if ([controller isKindOfClass:[YJHomeViewController class]]) {
    //            [self.navigationController popToViewController:controller animated:YES];
    //        }
    //    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJAllShopViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJSectionShopViewController class]]) {
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
      
            static NSString *identifier = @"showTopProidentifier";
            
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
- (void)ShopBtnClick:(UIButton *)btn{
    YJHotShopModel *model = [dataArray objectAtIndex:btn.tag -100];
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *upStr = [NSString stringWithFormat:@"热销"];
    NSString *url = [NSString stringWithFormat:@"%@/product/setHotOrLoad",BASE_URL];
    NSString *type;
    if ([btn.titleLabel.text isEqualToString:@"设置热销"]) {
        type = @"1";
    }else{
        type = @"0";
    }
    NSDictionary *dic = @{@"userId":userID,
                          @"ids":model.commodityId,
                          @"theme":upStr,
                          @"type":type,
                          };
    NSLog(@"dic = %@",dic);
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [self getNetworkData:YES];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        NSLog(@"re = %@",result);
        
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    YJHotShopModel *model = [dataArray objectAtIndex:indexPath.row];
    YJShowShopDeatilShopingViewController *vc = [[YJShowShopDeatilShopingViewController alloc]init];
    vc.WebStr = [NSString stringWithFormat:@"http://h5.maikehome.cn/?token=%@&productid=%@&userid=%@",tokenID,model.commodityId,userID];
    vc.ShopIDStr = model.commodityId;
    [self.navigationController pushViewController:vc animated:NO];
//    YJShowShopDeatilShopingViewController *vc = [[YJShowShopDeatilShopingViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
    
}
#pragma  mark --UISearchResultsUpdating
//UISearchResultsUpdating代理方法，跟新搜索结果界面
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSLog(@"更新结果 ");
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSString * inputStr = searchController.searchBar.text;
    //    if (self.resultArr.count > 0) {
    //        [self.resultArr removeAllObjects];
    //    }
    //    for (NSString * str in self.dataArr) {
    //        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
    //            [self.resultArr addObject:str];
    //        }
    //    }
    //    [self.OrderTableview reloadData];
}
#pragma  mark --UISearchControllerDelegate
//UISearchControllerDelegate代理方法
-(void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"------willPresentSearchController");
    
}

-(void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"------didPresentSearchController");
}

-(void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"------willDismissSearchController");
}

-(void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"------didDismissSearchController");
}

-(void)presentSearchController:(UISearchController *)searchController{
    NSLog(@"-------presentSearchController");
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
