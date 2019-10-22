//
//  YJHtmlShopDetailViewController.m
//  maike
//
//  Created by Apple on 2019/9/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJHtmlShopDetailViewController.h"
#import "UserAdresssTableViewCell.h"
#import "ShopTableViewCell.h"
#import "YJPayViewController.h"
#import "JSCartModel.h"
#import "YJGouWuCheTableViewCell.h"
#import "YJCustomerViewController.h"
#import "JSCartViewController.h"
#import "YJShowShopDeatilShopingViewController.h"


@interface YJHtmlShopDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    UILabel *payMoneyLabel;
    UIButton *payBtn;
    NSMutableArray *buyArray;
    NSString *buyIdStr;
    NSString *monryStr;
    
}

@end

@implementation YJHtmlShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"提交订单";
    self.view.backgroundColor = [UIColor whiteColor];
    // NSLog(@"shop == %lu",[_shopArray count])
    //[self reoadData];
    monryStr = _shopMoneyStr;

    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64- 100);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    shopListTableview.tableFooterView =  [UIView new];
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80);
    }];
    moneyLabel = [[UILabel alloc]init];
    moneyLabel.text = [NSString stringWithFormat:@"商品金额"];
    [bottomView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.mas_left).offset(20);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    payMoneyLabel = [[UILabel alloc]init];
    payMoneyLabel.text = [NSString stringWithFormat:@"￥%@",_shopMoneyStr];
    payMoneyLabel.textColor = [UIColor redColor];
    [bottomView addSubview:payMoneyLabel];
    [payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->moneyLabel.mas_right);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5.0;
    payBtn.backgroundColor = [UIColor redColor];
    [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right).offset(-20);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    
}
- (void)payPostClick{
    NSMutableArray *shopArray = [[NSMutableArray alloc]init];
    NSMutableArray *numArray = [[NSMutableArray alloc]init];
    for (int i =0 ; i< 1; i++) {
       // JSCartModel *model = [buyArray objectAtIndex:@"1"];
        [shopArray addObject:@""];
        NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@(1),@"number",@(150),@"productAttributesId",monryStr,@"productTotalPrice",_ProductArray,@"skuList", nil];
        
        [numArray addObject:dic];
    }
    NSString *userID = NSuserUse(@"userId");
    
    NSString *tokenID = NSuserUse(@"token");
    NSDictionary *dic = @{@"orderDetailParamList":numArray,
                          @"customerId":buyIdStr,
                          @"sellerId":userID,
                       
                          };
   //  @"shoppingDetailIdList":shopArray
    NSString *url = [NSString stringWithFormat:@"%@/app/order/createOrder",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
          
            YJPayViewController *vc = [[YJPayViewController alloc]init];
            vc.shopId = [[result objectForKey:@"data"]objectForKey:@"orderId"];;
            vc.moneyStr = self->_shopMoneyStr;
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
    
}
- (void)payClick{
    if ([buyIdStr integerValue]) {
        [self payPostClick];
    }else{
        [AnimationView showString:@"请选择客户"];
    }
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[JSCartViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJHtmlShopDetailViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJShowShopDeatilShopingViewController  class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
}
    //[self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 0;
    }
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else if (indexPath.section == 1){
        return 140;
    }
    return 0;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"TopHtmlProidentifier";
        
        UserAdresssTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UserAdresssTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
        cell.NameLabel.text= @"选择客户以及地址";
        cell.AdressLabel.text = @"";
        
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.section == 1)
    {
        static NSString *identifier = @"shopHtmlTopProidentifier";
        
        YJGouWuCheTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJGouWuCheTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        [cell.ShopImageView  sd_setImageWithURL:[NSURL URLWithString:_ProductImageStr] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
        cell.ShopNameLabel.text= _ProductTitleStr;
        cell.ShopMoneyLabel.text =[NSString stringWithFormat:@"￥%@",_shopMoneyStr];
        cell.ShopNumberLabel.text= @"1";
//        if ([_shopArray count]) {
//            JSCartModel *model = [_shopArray objectAtIndex:indexPath.row];
//            cell.model = model;
//        }
        cell.ShopTagFirstLabel.hidden = YES;
        cell.ShopTagSecondLabel.hidden = YES;
        cell.ShopTagThirdLabel.hidden = YES;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"detailHtmlTopProidentifier";
        
        ShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[ShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        if (indexPath.row== 0) {
            YJCustomerViewController *vc = [[YJCustomerViewController     alloc]init];
            vc.type = @"2";
            [vc setChoseShopBlock:^(NSString * _Nonnull string, NSString * _Nonnull adress, NSString * _Nonnull custonerid) {
                UserAdresssTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.NameLabel.text = [NSString stringWithFormat:@"收货人:%@",string];
                cell.AdressLabel.text = adress;
                self->buyIdStr =custonerid;
            }];
            
            [self.navigationController   pushViewController:vc animated:NO];
        }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
