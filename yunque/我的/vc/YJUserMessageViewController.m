//
//  YJUserMessageViewController.m
//  maike
//
//  Created by Apple on 2019/8/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserMessageViewController.h"
#import "YJUserDetailTableViewCell.h"

@interface YJUserMessageViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    NSDictionary *mydic;
}

@end

@implementation YJUserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopTitleLabel.text = @"个人信息";
    self.view.backgroundColor = colorWithRGB(0.83, 0.83, 0.83);
    mydic = [[NSDictionary alloc]init];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self reloadData];
    
}
- (void)reloadData{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url;
    if ([_typeStr integerValue] == 5) {
        url = [NSString stringWithFormat:@"%@/shop/selShopfirm",BASE_URL];

    }else{
        url = [NSString stringWithFormat:@"%@/shop/selShopPersonal",BASE_URL];

    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        //NSLog(@"result = %@",result  );
        self->mydic =[result objectForKey:@"data"];
        [self SetUi];
    }];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64);
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

    return 5;
    
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
    if (indexPath.row == 0) {
        return 80;
    }
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        static NSString *identifier = @"detailProidentifier";
        
        YJUserDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJUserDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
    switch (indexPath.row) {
        case 0:
            [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"picture"]] placeholderImage:[UIImage imageNamed:@"默认头像"]];
            cell.NameLabel.text  = @"头像";
            cell.choseLabel.hidden = YES;
            break;
        case 1:
            cell.choseLabel.text = [_dic objectForKey:@"name"];
            cell.NameLabel.text  = @"真实姓名";
        
            break;
        case 2:
            cell.choseLabel.text = [NSString stringWithFormat:@"%@",[_dic objectForKey:@"shopAddress"]];

             cell.NameLabel.text  = @"门店地址";
            break;
        case 3:
            if ([[_dic objectForKey:@"type"] integerValue] == 5) {
                cell.choseLabel.text = @"员工";
            }else{
                cell.choseLabel.text = @"店主";
            }
             cell.NameLabel.text  = @"角色";
            break;
        case 4:
            cell.choseLabel.text = [mydic objectForKey:@"shopName"];

             cell.NameLabel.text  = @"门店名称";
            break;
        default:
            break;
    }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
