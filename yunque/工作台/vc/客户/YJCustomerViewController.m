//
//  YJCustomerViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJCustomerViewController.h"
#import "YJKeHuTableViewCell.h"
#import "YJCustomerDetailViewController.h"
#import "YJAddCustomerViewController.h"
#import "YJKeHuModel.h"
#import "YJShopSetDetailViewController.h"
#import "YJShopDetailViewController.h"
#import "YJUserViewController.h"
#import "YJHtmlShopDetailViewController.h"
#import "YJUserShopSetViewController.h"


@interface YJCustomerViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
     int page;
    NSMutableArray *DataArray;
}

@end

@implementation YJCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"客户";
    self.view.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-15);
        make.top.mas_equalTo(self.TopView.mas_top).offset(25);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    page = 1;
    DataArray = [[NSMutableArray alloc]init];
  
    [self SetUi];
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

     NSString *url;
    if (isRefresh) {
        page = 1;
        url = [NSString stringWithFormat:@"%@/customer/beforeCustomerList?pageNum=1&pageSize=20",BASE_URL];
    }else{
        page++;
        url = [NSString stringWithFormat:@"%@/customer/beforeCustomerList?pageNum=%d&pageSize=20",BASE_URL,page];
    }
    if (page ==1) {
        [DataArray removeAllObjects];
    }
    
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
                for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                    YJKeHuModel *model = [[YJKeHuModel alloc]init];
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

- (void)rightClick{
    YJAddCustomerViewController *vc = [[YJAddCustomerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-64);
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
- (void)sureClick{
    
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJShopDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJHtmlShopDetailViewController    class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserShopSetViewController      class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
   // [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (DataArray.count) {
        return DataArray.count;
    }
    return 1;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
    if (DataArray.count) {
        return 60;
    }
    return SCREEN_HEIGHT-64;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DataArray.count) {
        static NSString *identifier = @"YJKEeHuProidentifier";
        
        YJKeHuTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJKeHuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.UserNameLabel.hidden = YES;
        cell.UserNumberLabel.hidden = YES;
        [cell.EditBtn setImage:[UIImage imageNamed:@"打电话"] forState:UIControlStateNormal];
        cell.EditBtn.tag = indexPath.row + 100;
        [cell.EditBtn addTarget:self action:@selector(PhoneClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.backgroundColor = [UIColor whiteColor];
        if (DataArray.count) {
            YJKeHuModel *model = [DataArray objectAtIndex:indexPath.row];
            cell.model = model;
            
        }
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
- (void)PhoneClick:(UIButton *)btn{
    YJKeHuModel *model = [DataArray objectAtIndex:btn.tag-100];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",model.phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

}

- (void)editTableview{
    
   // [shopListTableview setEditing:YES animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     YJKeHuModel *model = [DataArray objectAtIndex:indexPath.row];
    if ([_type integerValue] ==1) {
        if (_ChoseCustomerBlock) {
            _ChoseCustomerBlock(model.nickName,model.customerId);
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJShopSetDetailViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else if ([_type integerValue] ==2){
        if (_ChoseShopBlock) {
            NSString *name = [NSString stringWithFormat:@"%@ %@",model.nickName,model.phoneNumber];
            NSString *adress = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.town,model.address];
            _ChoseShopBlock(name,adress,model.customerId);
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJShopDetailViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJHtmlShopDetailViewController    class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else{
        YJCustomerDetailViewController *vc = [[YJCustomerDetailViewController alloc]init];
        vc.customerid = model.customerId;
        [self.navigationController pushViewController:vc animated:NO];
    }
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
