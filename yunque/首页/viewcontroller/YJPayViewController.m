//
//  YJPayViewController.m
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPayViewController.h"
#import "YJPayStyleTableViewCell.h"
#import "YJPayTopTableViewCell.h"
#import "YJPayCodeViewController.h"
#import "YJShopDetailViewController.h"
#import "YJHtmlShopDetailViewController.h"
#import "YJMyOrderViewController.h"
#import "YJMyOrderDetailViewController.h"



@interface YJPayViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *shopListTableview;
    UIButton *payBtn;
    NSInteger indexRow;
    NSInteger indexSectionRow;
    NSInteger indexSection;
    NSString *PayMoneyStr;
}

@end

@implementation YJPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"支付金额";
    indexRow = 0;
    indexSectionRow = 4;
    indexSection = 1;
    PayMoneyStr = _moneyStr;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64- 100);
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
        make.height.mas_equalTo(80);
    }];
    payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.backgroundColor = font_main_color;
    payBtn.layer.masksToBounds = YES;
    payBtn.layer.cornerRadius = 5.0;
    [payBtn setTitle:@"支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bottomView.mas_right).offset(-30);
        make.bottom.mas_equalTo(bottomView.mas_bottom).offset(-20);
        make.width.mas_equalTo(SCREEN_WIDTH-60 );
        make.height.mas_equalTo(40);
    }];
}
- (void)sureClick{
    if ([PayMoneyStr isEqualToString:@"0"]) {
         [AnimationView showString:@"金额不能为0"];
       
    }else{
        [self postClick];
    }
    
}

- (void)postClick{
    if (indexSectionRow == 4) {
        YJPayCodeViewController *vc = [[YJPayCodeViewController alloc]init];
        if (indexRow == 0) {
            vc.typeStr = @"0";
        }else{
            vc.typeStr = @"1";
        }
        vc.shopId = _shopId;
        vc.moneyStr = PayMoneyStr;
        [self.navigationController pushViewController:vc animated:NO ];
    }else{
        NSString *url;
   
        url = [NSString stringWithFormat:@"%@/alipay/other?transaction=%@&orderId=%@&type=%ld",BASE_URL,PayMoneyStr,_shopId,indexSectionRow+1];
    
        
        //NSLog(@"url = %@",url);
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                [AnimationView showString:@"支付成功"];
                [self.navigationController popToRootViewControllerAnimated:NO];
            }
            else{
                 [AnimationView showString:[result objectForKey:@"errmsg"]];
            }
        }];
        
    }
    
}
- (void)ShopListBackClick{
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
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJMyOrderViewController    class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJMyOrderDetailViewController    class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section == 1){
        return 2;
    }else{
        return 3;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *titleView = [[UIView alloc]init];
        titleView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
        titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"线上支付";
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.frame = CGRectMake(20, 10, 200, 20);
        [titleView addSubview:titleLabel];
        
        return titleView;
    }else if (section ==2){
        UIView *titleView = [[UIView alloc]init];
        titleView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
        titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"线下支付";
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.frame = CGRectMake(20, 10, 200, 20);
        [titleView addSubview:titleLabel];
        return titleView;
    }else{
        return nil;
        
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
         return 40;
    }else if (section == 2){
        return 40;
    }else{
         return 0;
    }
   
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else{
        return 60;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"payTopProidentifier";
        
        YJPayTopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJPayTopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
      
        if ([_moneyStr floatValue] > 0) {
            cell.AdressTextField.text = [NSString stringWithFormat:@"%@",_moneyStr];
        }else{
            cell.AdressTextField.text = @"100";
        }
        cell.AdressTextField.enabled = YES;
        cell.AdressTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.AdressTextField.delegate = self;
        cell.AdressTextField.tag = 100;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.section ==1){
        
        static NSString *identifier = @"SaomapaydetailTopProidentifier";
        
        YJPayStyleTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJPayStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (indexPath.row == 0) {
            cell.NameLabel.text = @"微信扫码";
        }else if (indexPath.row == 1){
            cell.NameLabel.text = @"支付宝扫码";
            
        }else{
            cell.NameLabel.text = @"其他";
        }
            if (indexPath.row == indexRow) {
                cell.AdressBtn.selected = YES;
            }else{
                cell.AdressBtn.selected = NO;
            }
     
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        
        static NSString *identifier = @"paydetailTopProidentifier";
        
        YJPayStyleTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJPayStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }

            if (indexPath.row == indexSectionRow) {
                cell.AdressBtn.selected = YES;
            }else{
                cell.AdressBtn.selected = NO;
            }

        if (indexPath.row == 0) {
            cell.NameLabel.text = @"现金";
        }else if (indexPath.row == 1){
            cell.NameLabel.text = @"刷卡";

        }else{
            cell.NameLabel.text = @"其他";
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    
    
    
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        PayMoneyStr = textField.text;

    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexSection = indexPath.section;
    if (indexPath.section == 1) {
        indexRow = indexPath.row;
        indexSectionRow = 4;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
//        NSIndexSet *indexSet111 = [[NSIndexSet alloc] initWithIndex:2];
  //      [tableView reloadSections:indexSet111 withRowAnimation:UITableViewRowAnimationNone];
        
        
    }else if(indexPath.section ==2){
        indexRow = 4;
        indexSectionRow = indexPath.row;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        
        NSIndexSet *indexSet222 = [[NSIndexSet alloc] initWithIndex:1];
        [tableView reloadSections:indexSet222 withRowAnimation:UITableViewRowAnimationNone];
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
