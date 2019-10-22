//
//  YJMyOrderDetailViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJMyOrderDetailViewController.h"
#import "YJOrderHeaderTableViewCell.h"
#import "YJOrderShopTableViewCell.h"
#import "YJOrderDetailTableViewCell.h"
#import "YJOrderPayDetailTableViewCell.h"
#import "YJOrderModel.h"
#import "YJPayViewController.h"


@interface YJMyOrderDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    NSDictionary *dic;
    NSMutableArray *ShopArray;
    NSMutableArray *PayArray;

}

@end

@implementation YJMyOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"订单详情";
    self.TopTitleLabel.textColor = [UIColor whiteColor];
    self.TopView.backgroundColor = font_main_color;
    self.BackButton.hidden = YES;
    UIButton *DDBackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [DDBackBtn  setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [DDBackBtn addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.TopView addSubview:DDBackBtn];
    [DDBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.TopView.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(30);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(10);
    }];
    dic = [[NSDictionary alloc]init];
    ShopArray = [[NSMutableArray alloc]init];
    PayArray = [[NSMutableArray alloc]init];
    [self reoadDate];
    
}
- (void)reoadDate{
    NSString *userID = NSuserUse(@"userId");

    NSString *url = [NSString stringWithFormat:@"%@/app/order/findOneById?orderId=%@&customerId=%@",BASE_URL,_orderId,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
       // self->ShopArray = [[result objectForKey:@"data"]objectForKey:@"orderDetailVOS"];
        self->dic = [result objectForKey:@"data"];
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
          //  NSLog(@"re  == =%@",result);
            for (NSDictionary *mydic in [dic objectForKey:@"orderDetailVOS"]) {
                YJOrderModel *model = [[YJOrderModel alloc]init];
                model.dataDictionary = mydic;
                [self->ShopArray addObject:model];
            }
            for (NSDictionary *mydic in [dic objectForKey:@"accountDOS"]) {
                YJOrderModel *model = [[YJOrderModel alloc]init];
                model.dataDictionary = mydic;
                [self->PayArray addObject:model];
            }
            if ([[dic objectForKey:@"content"] count]) {
                [self->shopListTableview endFooterRefresh];;
                [self->shopListTableview reloadData];
            }else{
                [self->shopListTableview endFooterNoMoreData];
            }
            [self SetUi];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
    
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64 -70);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(70);
    }];
    UIButton * payBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [payBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    [payBtn setTitle:@"继续收款" forState:UIControlStateNormal];
    //[payBtn setTintColor:font_main_color];
    [payBtn.layer setMasksToBounds:YES];
    [payBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [payBtn.layer setBorderWidth:1.0];
    //payBtn.layer.borderColor = font_main_color.CGColor;
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right).offset(-30);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-20);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
    }];
    UIButton * shouBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   // [shouBtn setTintColor:font_main_color];
    [shouBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [shouBtn.layer setMasksToBounds:YES];
    [shouBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [shouBtn.layer setBorderWidth:1.0];
    //shouBtn.layer.borderColor = font_main_color.CGColor;
    [shouBtn addTarget:self action:@selector(shouClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:shouBtn];
    [shouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(payBtn.mas_left).offset(-30);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-20);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
    }];
    switch ([[dic objectForKey:@"orderStatus"]integerValue]) {
        case 101:
            [payBtn setTitle:@"继续收款" forState:UIControlStateNormal];
            [shouBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            bottomView.hidden = NO;
            break;
        case 102:
            [payBtn setTitle:@"继续收款" forState:UIControlStateNormal];
            [shouBtn setTitle:@"确认完成" forState:UIControlStateNormal];
            bottomView.hidden = NO;
            break;
        case 103:
            [payBtn setTitle:@"继续收款" forState:UIControlStateNormal];
            [shouBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            bottomView.hidden = YES;
            break;
        default:
            break;
    }
}
- (void)shouClick{
    
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSDictionary *mydic = @{@"customerId":userID,
                          @"orderId":_orderId,
                          };
    NSString *url;
    if ([[dic objectForKey:@"orderStatus"]integerValue] == 102) {
          url = [NSString stringWithFormat:@"%@/app/order/completeOrder",BASE_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/app/order/closeOrder",BASE_URL];

    }
    NSLog(@"url = %@",url);
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)mydic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"re === %@",result);
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [AnimationView showString:@"操作成功"];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
}
- (void)sureClick{
    YJPayViewController *vc = [[YJPayViewController alloc]init];
    vc.shopId = _orderId;
    vc.moneyStr = [dic objectForKey:@"price"];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
        
    }else if (section == 1){
        return [ShopArray count];
    }else if (section == 2){
        return 1;
    }
    if ([[dic objectForKey:@"accountDOS"] count]) {
        return [[dic objectForKey:@"accountDOS"]count];
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(section == 3){
        return 15+60;
    }
    
    return 15;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 240;
        
    }else if (indexPath.section == 1){
        return 140;
    }else if (indexPath.section == 2){
        return 240;
    }else{
        if ([[dic objectForKey:@"accountDOS"] count]) {
            return 160;
        }else{
            return 0;
        }
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *titleView = [[UIView alloc]init];
        titleView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
        titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15+60);
        UIView *bottomView = [[UIView alloc]init];
        bottomView.backgroundColor = [UIColor whiteColor];
        bottomView.frame = CGRectMake(0, 15, SCREEN_WIDTH, 60);
        [titleView addSubview:bottomView];
        
        UILabel *payLabel = [[UILabel alloc]init];
        payLabel.text = @"支付信息";
        payLabel.font = [UIFont systemFontOfSize:16];
        payLabel.frame = CGRectMake(20, 20, 100, 20);
        [bottomView addSubview:payLabel];
        return titleView;
    }else{
        UIView *titleView = [[UIView alloc]init];
        titleView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
        titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 15);
        return titleView;
    }
   
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"headerProidentifier";
        
        YJOrderHeaderTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJOrderHeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.orderMoneyLabel.text=[NSString stringWithFormat:@"%ld", (long)[[dic objectForKey:@"productTotalAmount"]integerValue]];
        cell.NoPayLabel.text = [NSString stringWithFormat:@"%ld", (long)[[dic objectForKey:@"noPaidAmount"] integerValue]];
        cell.PayLabel.text = [NSString stringWithFormat:@"%ld", (long)[[dic objectForKey:@"paidAmount"]integerValue]];
        
        cell.NameLabel.text = [NSString stringWithFormat:@"%@  %ld",[dic objectForKey:@"buyer"],(long)[[dic objectForKey:@"cod"]integerValue]];
        cell.AdressLabel.text= [NSString   stringWithFormat:@"%@%@%@%@",[dic objectForKey:@"province"],[dic objectForKey:@"city"],[dic objectForKey:@"area"],[dic objectForKey:@"street"]];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identifier = @"orderShopProidentifier";
        
        YJOrderShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJOrderShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if ([ShopArray count]) {
            YJOrderModel *model = [ShopArray objectAtIndex:indexPath.row];
            cell.model = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }else if (indexPath.section ==2){
        static NSString *identifier = @"orderdetailProidentifier";
        
        YJOrderDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJOrderDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.orderNumberDetailLabel.text = [dic objectForKey:@"orderSn"];
        cell.OrderTimeDetailLabel.text = [dic objectForKey:@"createDate"];
        cell.OrderCreateDetailLabel.text = [dic objectForKey:@"paymentDate"];
        cell.OrderFirstPayDetailLabel.text = [dic objectForKey:@"paymentDate"];
        if ([[dic objectForKey:@"accountDOS"] count]) {
            cell.PayNameLabel.hidden = YES;
        }else{
             cell.PayNameLabel.hidden = NO;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }else{
        static NSString *identifier = @"payDetailProidentifier";
        
        YJOrderPayDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJOrderPayDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if ([PayArray count]) {
            YJOrderModel *model = [PayArray objectAtIndex:indexPath.row];
            cell.model = model;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
    }
   
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setStatusBarBackgroundColor:colorWithRGB(0.25, 0.33, 1)];

    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];

    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

@end
