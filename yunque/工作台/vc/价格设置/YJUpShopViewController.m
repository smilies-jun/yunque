//
//  YJUpShopViewController.m
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUpShopViewController.h"
#import "YJUpLoadShopTableViewCell.h"
#import "YJModifyMoneyViewController.h"
#import "YJJiaGeModel.h"

@interface YJUpShopViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    NSArray *Myarray;
    
    
}


@end

@implementation YJUpShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"价格设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    Myarray = [[NSArray alloc]init];
   
    [self SetUi];
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/categoryprice/list?pageNum=1&pageSize=10",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->Myarray = [[result objectForKey:@"data"]objectForKey:@"content"];
        [self->shopListTableview reloadData];
    }];
    
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
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/categoryprice/list?pageNum=1&pageSize=10",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->Myarray = [[result objectForKey:@"data"]objectForKey:@"content"];
        [self->shopListTableview reloadData];
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

- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (Myarray.count) {
        return Myarray.count;
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 160;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    titleView.frame = CGRectMake(20, 0, SCREEN_WIDTH-40, 60);
    titleView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addClick)];
    [titleView addGestureRecognizer:tap];
    UILabel *addLabel = [[UILabel alloc]init];
    addLabel.text = @"新建规则";
    addLabel.textColor = font_main_color;
    [titleView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(titleView.mas_centerX);
        make.top.mas_equalTo(titleView.mas_top).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setImage:[UIImage imageNamed:@"新建价格"] forState:UIControlStateNormal];
    
   // [btn addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(addLabel.mas_left);
        make.top.mas_equalTo(titleView.mas_top).offset(25);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
   
    return  titleView;
}
-(void)addClick{
    YJModifyMoneyViewController *vc =[[YJModifyMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"upMoneyShopProidentifier";
    
    YJUpLoadShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJUpLoadShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    NSDictionary *dic = [Myarray objectAtIndex:indexPath.row];
    cell.NameLabel.text= [dic objectForKey:@"ruleName"];
    cell.MoneyLabel.text = [NSString stringWithFormat:@"%@%%",[dic objectForKey:@"profitMargin"]];
    NSArray *resultArray = [dic objectForKey:@"category"];
    NSString *styleStr;
    styleStr = [resultArray componentsJoinedByString:@";"];
    cell.TypeLabel.text = styleStr;
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)HotListBackClick{
    [self.navigationController   popToRootViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self getNetworkData:YES];
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
