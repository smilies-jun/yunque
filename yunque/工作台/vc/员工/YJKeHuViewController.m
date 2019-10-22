//
//  YJKeFuViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJKeHuViewController.h"
#import "YJYuanGongTableViewCell.h"
#import "YJShowYuanGongViewController.h"
#import "YJAddYuanGongViewController.h"
#import "YJKeHuModel.h"


@interface YJKeHuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    int page;
    NSMutableArray *DataArray;
}

@end

@implementation YJKeHuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"员工";
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
- (void)rightClick{
    YJAddYuanGongViewController *vc = [[YJAddYuanGongViewController alloc]init];
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
        url = [NSString stringWithFormat:@"%@/clerk/list?page=1&pageSize=20",BASE_URL];
    }else{
        page++;
        url = [NSString stringWithFormat:@"%@/clerk/list?page=%d&pageSize=20",BASE_URL,page];
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
- (void)sureClick{
    
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
        
        YJYuanGongTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJYuanGongTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        [cell.EditBtn addTarget:self action:@selector(editTableview:) forControlEvents:UIControlEventTouchUpInside];
        cell.EditBtn.tag =indexPath.row +100;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (DataArray.count) {
            YJKeHuModel *model = [DataArray objectAtIndex:indexPath.row];
            cell.model = model;
        }
        
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

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tokenID = NSuserUse(@"token");
    YJKeHuModel *model = [DataArray objectAtIndex:indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@/clerk/delete",BASE_URL];
    NSDictionary *dic = @{@"userId":[NSNumber numberWithInteger:[model.userId integerValue]]};
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [self->DataArray removeObjectAtIndex:indexPath.row];
            [self->shopListTableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationFade];

        }else{
            [AnimationView showString:@"删除失败"];
        }
        
        
    }];
 
    
      [shopListTableview setEditing:NO animated:YES];
    
  
}
- (void)editTableview:(UIButton *)btn{
    YJKeHuModel *model = [DataArray objectAtIndex:btn.tag - 100];

    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/clerk/disable",BASE_URL];
    NSDictionary *dic = @{@"userId":[NSNumber numberWithInteger:[model.userId integerValue]]};
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [self getNetworkData:YES];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
        
    }];
  //  [shopListTableview setEditing:YES animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YJShowYuanGongViewController    *vc = [[YJShowYuanGongViewController alloc]init];
    YJKeHuModel *model = [DataArray objectAtIndex:indexPath.row];
    vc.userID = model.userId;
    [self.navigationController pushViewController:vc animated:NO];
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
