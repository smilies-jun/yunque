//
//  YJSeconryViewController.m
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJSeconryViewController.h"
#import "YJHeaderUserTableViewCell.h"
#import "YJSetDetailTableViewCell.h"
#import "YJUserMessageViewController.h"
#import "YJUserSetViewController.h"
#import "YJMenDianViewController.h"
#import "YJUserShouCangViewController.h"
#import "YJUserCodeViewController.h"
#import "YJYaoQingViewController.h"
#import "YJAllShopViewController.h"

@interface YJSeconryViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    NSDictionary *userDic;
    
        NSMutableArray *DataArray;
       NSMutableArray *cateIDArray;
       NSMutableArray *titleArray;
       NSMutableArray *cateIDArray2;
       NSMutableArray *titleArray2;
       NSMutableArray *cateIDArray3;
       NSMutableArray *titleArray3;
       NSMutableArray *cateIDArray4;
       NSMutableArray *titleArray4;
       NSMutableArray *cateIDArray5;
       NSMutableArray *titleArray5;
    
    
}

@end

@implementation YJSeconryViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = YES;
    userDic = [[NSDictionary alloc]init];
   cateIDArray = [[NSMutableArray alloc]init];
   titleArray = [[NSMutableArray alloc]init];
   cateIDArray2 = [[NSMutableArray alloc]init];
   titleArray2 = [[NSMutableArray alloc]init];
   cateIDArray3 = [[NSMutableArray alloc]init];
   titleArray3 = [[NSMutableArray alloc]init];
   cateIDArray4 = [[NSMutableArray alloc]init];
   titleArray4 = [[NSMutableArray alloc]init];
   cateIDArray5 = [[NSMutableArray alloc]init];
   titleArray5 = [[NSMutableArray alloc]init];
   
   [self reoadMyDate];
   
}
- (void)reoadMyDate{
   
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *myarray = [result objectForKey:@"data"];
            for (int i =0; i < myarray.count; i++) {
                NSMutableArray *childArray = [NSMutableArray new];
                childArray = [[myarray objectAtIndex:i]objectForKey:@"children"];
                if (i==0) {
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==1){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray2 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray2 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==2){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray3 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray3 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==3){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray4 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray4 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }
//                }else{
//                    for (int j =0; j < childArray.count; j++) {
//                        [self->cateIDArray5 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
//                        [self->titleArray5 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
//                    }
//                }
            }
         
           

       // [self refreshUI];

    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self reoadDate];
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");

    NSString *url = [NSString stringWithFormat:@"%@/client/userInfo",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        self->userDic =[result objectForKey:@"data"];
        [self SetUi];
    }];
  
}

- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, 20, SCREEN_WIDTH, SCREEN_HEIGHT-20);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    shopListTableview.tableFooterView = [UIView new];
    [self.view addSubview:shopListTableview];
    
}

- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 6;
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
    if (indexPath.section ==0) {
         return 80;
    }
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"setheaderProidentifier";
        
        YJHeaderUserTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJHeaderUserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
       
        NSString *type = NSuserUse(@"type");
        if ([type integerValue] == 5) {
             cell.userNameLabel.text = [userDic objectForKey:@"name"];
            cell.AdressLabel.text =  [NSString stringWithFormat:@"%@:导购", [userDic objectForKey:@"shopName"]];
        }else{
             cell.userNameLabel.text = [userDic objectForKey:@"shopName"];
             cell.AdressLabel.text =  [NSString stringWithFormat:@"%@:店长", [userDic objectForKey:@"shopName"]];
        }
        
        [cell.userImageView sd_setImageWithURL:[NSURL URLWithString:[userDic objectForKey:@"picture"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"detailProidentifier";
        
        YJSetDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJSetDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        switch (indexPath.row) {
            case 0:
                if ([[userDic objectForKey:@"applyType"]integerValue] == 1) {
                    cell.stateImageView.hidden = NO;
                    cell.adressLabel.hidden = YES;
                }else if ([[userDic objectForKey:@"applyType"]integerValue] == 2){
                    cell.adressLabel.hidden = NO;
                    cell.adressLabel.text = @"认证失败";
                    cell.stateImageView.hidden = YES;
                }else{
                    cell.adressLabel.hidden = NO;
                    cell.adressLabel.text = @"正在认证";
                     cell.stateImageView.hidden = YES;
                }
                cell.iconImageView.image = [UIImage imageNamed:@"门店信息"];
                cell.NameLabel.text = @"门店信息";
                break;
            case 1:
                 cell.stateImageView.hidden = YES;
                 cell.adressLabel.hidden = YES;
                 cell.iconImageView.image = [UIImage imageNamed:@"我的二维码"];
                cell.NameLabel.text = @"我的二维码";
                break;
            case 2:
                 cell.stateImageView.hidden = YES;
                 cell.adressLabel.hidden = YES;
                 cell.iconImageView.image = [UIImage imageNamed:@"收藏"];
                cell.NameLabel.text = @"收藏";
                break;
            case 3:
                 cell.stateImageView.hidden = YES;
                 cell.adressLabel.hidden = YES;
                 cell.iconImageView.image = [UIImage imageNamed:@"我的店铺"];
                cell.NameLabel.text = @"我的店铺";
                break;
            case 4:
                 cell.stateImageView.hidden = YES;
                 cell.adressLabel.hidden = YES;
                 cell.iconImageView.image = [UIImage imageNamed:@"设置"];
                cell.NameLabel.text = @"设置";
                break;
            case 5:
                       cell.stateImageView.hidden = YES;
                       cell.adressLabel.hidden = YES;
                       cell.iconImageView.image = [UIImage imageNamed:@"联系我们"];
                      cell.NameLabel.text = @"联系我们";
                      break;
            default:
                break;
        }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        YJUserMessageViewController *vc = [[YJUserMessageViewController alloc]init];
        vc.dic = userDic;
        vc.typeStr = [userDic objectForKey:@"mainType"];
        [self.navigationController pushViewController:vc animated:NO];
    }else if (indexPath.section == 1){
        if (indexPath.row ==4) {
            YJUserSetViewController *vc = [[YJUserSetViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }else if (indexPath.row == 0){
            YJMenDianViewController *vc = [[YJMenDianViewController alloc]init];
            vc.dic = userDic;
            vc.typeStr = [userDic objectForKey:@"mainType"];
            [self.navigationController pushViewController:vc animated:NO];
        }else if (indexPath.row ==2){
            YJUserShouCangViewController *vc = [[YJUserShouCangViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }else if (indexPath.row ==1){
            YJUserCodeViewController *vc = [[YJUserCodeViewController alloc]init];
            vc.dic = userDic;
            [self.navigationController pushViewController:vc animated:NO];
        }else if (indexPath.row ==3){
            YJAllShopViewController *vc = [[YJAllShopViewController alloc]init];
                          vc.titleArray = titleArray;
                          vc.cataIDArray = cateIDArray;
                          
                          vc.titleArray2 = titleArray2;
                          vc.cataIDArray2 = cateIDArray2;
                          vc.titleArray3 = titleArray3;
                          vc.cataIDArray3 = cateIDArray3;
                          vc.titleArray4 = titleArray4;
                          vc.cataIDArray4 = cateIDArray4;
            [self.navigationController pushViewController:vc animated:NO];
        }else if (indexPath.row == 5){
           
        }
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
