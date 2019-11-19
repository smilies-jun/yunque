//
//  YJAllOrderViewController.m
//  maike
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAllOrderViewController.h"
#import "YJOrderTableViewCell.h"
#import "YJMyOrderDetailViewController.h"
#import "YJOrderModel.h"
#import "YJPayViewController.h"


@interface YJAllOrderViewController (){
    NSMutableArray *DataArray;
    
}

@end

@implementation YJAllOrderViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    DataArray = [[NSMutableArray alloc]init];
    page =1;
   // [self getNetworkData:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
   // [self getNetworkData:YES];
    
}
- (void)setUI{
    _AllOrderTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60-40) style:UITableViewStylePlain];
    _AllOrderTableView.delegate = self;
    _AllOrderTableView.dataSource = self;
    [self.view addSubview:_AllOrderTableView];
    __weak __typeof(self) weakSelf = self;
    [_AllOrderTableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:YES];
    }];
    
    [_AllOrderTableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
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
    [_AllOrderTableView.mj_header endRefreshing];
    [_AllOrderTableView.mj_footer endRefreshing];
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

    
 
    NSString *url = [NSString stringWithFormat:@"%@/app/order/queryOderList?pageNum=%d&pageSize=10&customerId=%@",BASE_URL,page,userID];
    //NSString *hotStrPOST = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                YJOrderModel *model = [[YJOrderModel alloc]init];
                model.dataDictionary = mydic;
                [self->DataArray addObject:model];
            }
            
            if ([[dic objectForKey:@"content"] count]) {
                [self->_AllOrderTableView endFooterRefresh];;
                [self->_AllOrderTableView reloadData];
            }else{
                [self->_AllOrderTableView endFooterNoMoreData];
            }
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
}

- (void)reset{
   // [self.tableView reloadData];
    
    // 拿到当前的上拉刷新控件，变为没有更多数据的状态
  //  [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark - UITableViewDelegate  UITableViewDataSource

//header-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 0;
    
}
//header-secion
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [UIView new];
}

//footer-hegiht
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//footer-section
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


//sections-tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
//rows-section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (DataArray.count) {
        return [DataArray count];
    }
    return 1;
}
//cell-height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DataArray.count) {
        return 320;
    }
    return SCREEN_HEIGHT-60;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([DataArray count]) {
        YJMyOrderDetailViewController *vc = [[YJMyOrderDetailViewController alloc]init];
        YJOrderModel *model = [DataArray objectAtIndex:indexPath.row];
        vc.orderId = model.orderId;
        [self.navigationController pushViewController:vc animated:NO];
    }
 
}
//cell-tableview
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   if (DataArray.count) {
            static NSString *identifier = @"allShopidentifier";
            
            YJOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[YJOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if ([DataArray count]) {
                YJOrderModel *model = [DataArray objectAtIndex:indexPath.row];
                cell.orderModel = model;
            }
        cell.PayMoneyBtn.tag = 100+indexPath.row;
        cell.SureOverBtn.tag = 101+indexPath.row;
        [cell.PayMoneyBtn addTarget:self action:@selector(payClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.SureOverBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];

//            if ([cell.stageModel.state integerValue] == 2) {
//                cell.RightImageView.userInteractionEnabled = YES;
//                UITapGestureRecognizer *qiyeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QiYeClick)];
//                [cell.RightImageView addGestureRecognizer:qiyeTap];
//
//            }else{
//                cell.RightImageView.userInteractionEnabled = NO;
//
//            }
    
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

- (void)payClick:(UIButton *)btn{
    NSInteger index = btn.tag;
    YJOrderModel *model = [DataArray objectAtIndex:index-100];
    YJPayViewController *vc = [[YJPayViewController alloc]init];
    vc.shopId = model.orderId;
    vc.moneyStr = model.orderTotalAmount;
    [self.navigationController pushViewController:vc animated:NO];
    
}
- (void)sureClick:(UIButton *)btn{
    NSInteger index = btn.tag;
    YJOrderModel *model = [DataArray objectAtIndex:index-101];
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSDictionary *dic = @{@"customerId":userID,
                          @"orderId":model.orderId,
                          };
    NSString *url;
    if ([model.orderStatus integerValue] == 102) {
       
        url = [NSString stringWithFormat:@"%@/app/order/completeOrder",BASE_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/app/order/closeOrder",BASE_URL];

    }
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [AnimationView showString:@"操作成功"];
            [self getNetworkData:YES];
            //[self.navigationController popToRootViewControllerAnimated:NO];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
    
}
- (void)QiYeClick{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  [self getNetworkData:YES];


    
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
