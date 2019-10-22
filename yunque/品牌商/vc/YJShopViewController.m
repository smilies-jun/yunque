//
//  YJShopViewController.m
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShopViewController.h"
#import "YJNewShopTableViewCell.h"
#import "YJNewShopDetailViewController.h"

@interface YJShopViewController ()<UITableViewDataSource,UITableViewDelegate,RootCellDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    int page;
    NSMutableArray *dataArray;
}

@end

@implementation YJShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.hidden =YES;
    UILabel *myTitile = [[UILabel alloc]init];
    myTitile.text = @"新品";
    myTitile.font = [UIFont systemFontOfSize:24];
    [self.TopView addSubview:myTitile];
    [myTitile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.TopView.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
        
    }];
    self.view.backgroundColor = [UIColor whiteColor];
    self.BackButton.hidden = YES;
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    page = 1;
    dataArray = [[NSMutableArray alloc]init];
   
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64-60-20);
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
        if (dataArray.count) {
          //   [dataArray  removeAllObjects];
        }
       
    }
    
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *url = [NSString stringWithFormat:@"%@/product/prodcuTheme?userId=231",BASE_URL];

    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
//            NSDictionary *dic = [result objectForKey:@"data"];
//            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
//                YJHotShopModel *model = [[YJHotShopModel alloc]init];
//                model.dataDictionary = mydic;
//                [self->dataArray addObject:model];
//            }
//
//            if ([[dic objectForKey:@"content"] count]) {
//                [self->shopListTableview endFooterRefresh];;
//                [self->shopListTableview reloadData];
//            }else{
//                [self->shopListTableview endFooterNoMoreData];
//            }
            self->dataArray = [result objectForKey:@"data"];
             [self->shopListTableview reloadData];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
        
    }];
    
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArray.count) {
        return dataArray.count;
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
         return 267+30;
    }
    return SCREEN_HEIGHT - 64;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
    static NSString *identifier = @"newshoproidentifier";
    
    YJNewShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJNewShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
        cell.indexPath =indexPath;
        [cell configUI:indexPath];
    }
    cell.dataLabel.text = [[dataArray objectAtIndex:indexPath.row]objectForKey:@"productGroupName"];
    cell.dataNumberLabel.text = [[dataArray objectAtIndex:indexPath.row]objectForKey:@"createDate"];
    cell.dataAry = [[dataArray objectAtIndex:indexPath.row]objectForKey:@"commodityVOS"];
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
    if (dataArray.count) {
        YJNewShopDetailViewController *vc = [[YJNewShopDetailViewController alloc]init];
        //vc.titleStr = [[dataArray objectAtIndex:indexPath.row]objectForKey:@"productGroupName"];
        [self.navigationController pushViewController:vc animated:NO];
    }
   

}
//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    if (dataArray.count) {
        YJNewShopDetailViewController *vc = [[YJNewShopDetailViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:NO];
    }
  
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
