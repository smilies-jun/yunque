
//
//  YJPeopleMessageViewController.m
//  maike
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPeopleMessageViewController.h"
#import "YJPayStyleTableViewCell.h"
#import "YJMessageTableViewCell.h"
#import "YJTextFieldTableViewCell.h"

@interface YJPeopleMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>{
    UITableView *shopListTableview;
    NSInteger indexRow;
    NSString *messageStr;
    NSString *phoneStr;
}

@end

@implementation YJPeopleMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopTitleLabel.text = @"意见反馈 ";
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    indexRow = 0;
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, 580);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"确定" forState:UIControlStateNormal];
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 5.0f;
    codeBtn.backgroundColor =font_main_color;
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [codeBtn addTarget:self action:@selector(postBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view  addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->shopListTableview.mas_bottom).offset(20);
        make.left.mas_equalTo(self->shopListTableview.mas_left).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
}
-(void)postBtn{
    if (messageStr.length) {
        if (phoneStr.length) {
            NSString *url ;
            NSDictionary *dic;
            NSString *tokenID = NSuserUse(@"token");
            url = [NSString stringWithFormat:@"%@/feedback/add",BASE_URL];
            dic = @{@"contactInformation":phoneStr,
                    @"content":messageStr,
                    @"feedType":[NSNumber numberWithInteger:indexRow],
                  
                    };
  
        
        
        [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                [self.navigationController popToRootViewControllerAnimated:NO];
            }else{
                [AnimationView showString:[result objectForKey:@"errmsg"]];
            }
        }];
        }else{
            [AnimationView showString:@"请填写联系方式"];
        }
    }else{
        [AnimationView showString:@"请填写意见"];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 100) {
        messageStr = textField.text;
    }else{
        phoneStr = textField.text;
    }
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 3;
    }else if (section == 1){
        return 1;
    }else{
        return 1;
    }
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    if (section==0) {
        titleLabel.text = @"请选择问题类型";
    }else if (section == 1){
          titleLabel.text = @"请补充您宝贵的意见和建议";
    }else{
          titleLabel.text = @"联系方式";
    }
    
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleView.mas_left).offset(20);
        make.centerY.mas_equalTo(titleView.mas_centerY);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(30);
    }];
    return titleView;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
  
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 160;
    }else if (indexPath.row == 2){
        return 60;
    }
    else{
        return 60;
    }
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *identifier = @"messageProidentifier";
        
        YJPayStyleTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJPayStyleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        if (indexPath.row == 0) {
            cell.NameLabel.text = @"商品问题";
        }else if (indexPath.row == 1){
              cell.NameLabel.text = @"物流问题";
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
    }else if (indexPath.section == 1){
        static NSString *identifier = @"messageDetailTopProidentifier";
        
        YJTextFieldTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.YJTextField.delegate = self;
        cell.YJTextField.tag = 100;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        static NSString *identifier = @"MessageTextfiledProidentifier";
        
        YJMessageTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
        cell.YJTextField.tag = 200;

        cell.YJTextField.delegate = self;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    
    
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0  ) {
        indexRow = indexPath.row;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
 
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
