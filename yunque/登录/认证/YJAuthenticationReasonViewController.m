//
//  YJAuthenticationReasonViewController.m
//  maike
//
//  Created by Apple on 2019/8/7.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAuthenticationReasonViewController.h"
#import "YJAutherTableViewCell.h"
#import "YJYingYeZhiZhaoViewController.h"
#import "YJCustomViewController.h"
#import "YJEmailViewController.h"
#import "YJUserAuViewController.h"
#import "YJAuthenticationViewController.h"

@interface YJAuthenticationReasonViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UITextFieldDelegate>{

    UITableView *shopListTableview;
    NSInteger indexRow;
    NSString *UserStr;
    NSString *shopStr;
    NSString *reasonStr;
    UIButton *sureBtn;
    
    
    NSString *nameStr;
    NSString *numberStr;
}

@end

@implementation YJAuthenticationReasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"认证申诉";
    [self.BackButton addTarget:self action:@selector(AuthenticationBackClick) forControlEvents:UIControlEventTouchUpInside];
    indexRow = 4;
    if ([_type integerValue] == 1) {
        UserStr = [_dic objectForKey:@"shopName"];
    }else{
        UserStr = [_dic objectForKey:@"shopName"];
    }
    shopStr = [_dic objectForKey:@"shopName"];
    [self InitUI];
}
- (void)AuthenticationBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJAuthenticationViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserAuViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

   // NSString *inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (textField.tag == 101) {
        numberStr = textField.text;
    }else{
        nameStr = textField.text;
    }
    return YES;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@" == = == =%@",textField);
//    if (textField.tag == 101) {
//        numberStr = textField.text;
//    }else{
//        nameStr = textField.text;
//    }
//}
- (void)InitUI{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, 320);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(postBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->shopListTableview.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
}
- (void)postBtn{
    if ([_type integerValue] == 1) {
        [self postPerson];
    }else{
        [self postShop];
    }
}

- (void)postPerson{
    NSString *tokenID = NSuserUse(@"token");
    NSIndexPath *indexPathName=[NSIndexPath indexPathForRow:0 inSection:1];
    YJAutherTableViewCell *nameCell = (YJAutherTableViewCell *)[shopListTableview cellForRowAtIndexPath:indexPathName];
    
    NSIndexPath *indexPathNumber=[NSIndexPath indexPathForRow:1 inSection:1];
     YJAutherTableViewCell *numberCell = (YJAutherTableViewCell *)[shopListTableview cellForRowAtIndexPath:indexPathNumber];
    if (reasonStr.length) {
    if (nameStr.length) {
        if ([numberStr integerValue]) {
            NSDictionary *dic = @{@"agreeAgreement":@"1",
                                  @"realName":[_dic objectForKey:@"realName"],
                                  @"identityNumber":[_dic objectForKey:@"identityNumber"],
                                  @"shopName":[_dic objectForKey:@"shopName"],
                                  @"shopShortName":[_dic objectForKey:@"shopShortName"],
                                  @"province":[_dic objectForKey:@"province"],
                                  @"city":[_dic objectForKey:@"city"],
                                  @"otherSettlementAccountType":[_dic objectForKey:@"otherSettlementAccountType"],
                                  @"typeJoinId":[_dic objectForKey:@"typeJoinId"],
                                  @"brandIds":[_dic objectForKey:@"brandIds"],
                                  @"idCard":[NSNumber numberWithInteger:[numberCell.choseTextField.text integerValue]],
                                  @"idCardName":nameCell.choseTextField.text,
                                  @"areasonAppeal":reasonStr,
                                  @"type":[NSNumber numberWithInteger:0],
                                  @"state":[NSNumber numberWithInteger:0]
                                  };
            NSLog(@"dic == %@",dic);
            NSString *url = [NSString stringWithFormat:@"%@/shop/shopPersonal",BASE_URL];
            [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"code"]integerValue] == 200) {
                    [AnimationView showString:@"正在审核"];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    
                }else{
                    [AnimationView showString:[result objectForKey:@"errmsg"]];
                }
            }];
        }else{
            [AnimationView showString:@"请填写身份证号"];
        }
    }else{
        [AnimationView showString:@"请填写姓名"];
    }
    }else{
        [AnimationView showString:@"请选择原因"];
    }
    
}
- (void)postShop{
    if (indexRow == 4) {
        
    }else if (indexRow == 1){
        if (reasonStr.length) {
            YJCustomViewController   *vc = [[YJCustomViewController alloc]init];
            vc.dic = _dic;
            vc.shopId = _shopId;
            vc.str = reasonStr;
            [self.navigationController pushViewController:vc animated:NO];
        }else{
           
             [AnimationView showString:@"请选择原因"];
        }
        
    }else{
        if (reasonStr.length) {
            YJYingYeZhiZhaoViewController   *vc = [[YJYingYeZhiZhaoViewController alloc]init];
            vc.dic = _dic;
            vc.shopId = _shopId;
            vc.str = reasonStr;
            [self.navigationController pushViewController:vc animated:NO];
            
        }else{
            [AnimationView showString:@"请选择原因"];
        }
       
    }
}


//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 2;
    }
    
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    UILabel *label = [[UILabel alloc]init];
    if (section ==0) {
        label.text = [NSString stringWithFormat:@"原认证门店账户：%@",UserStr];
    }else{
        label.text = @"选择申诉方式";
    }
    
    label.font = [UIFont systemFontOfSize:12];
    label.frame = CGRectMake(20, 10, 220, 20);
    [titleView addSubview:label];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    return titleView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"yjAutheProidentifier";
    
    YJAutherTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJAutherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.AutherButton.hidden = YES;
             [cell.AutherButton setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
            cell.AutherTitleLabel.text =@"门店全称";
            cell.choseTextField.text = shopStr;
        }else{
             [cell.AutherButton setImage:[UIImage imageNamed:@"下一步"] forState:UIControlStateNormal];
            if (reasonStr.length) {
                cell.AutherTitleLabel.text =@"申诉原因:";
                cell.choseTextField.text = reasonStr;
            }else{
                cell.AutherTitleLabel.text =@"申诉原因:";
                cell.choseTextField.text = @"选择申诉原因";
            }
            
        }
    }else{
        if ([_type integerValue] ==1) {
             cell.AutherButton.hidden = YES;
            if (indexPath.row == 0) {
                cell.AutherTitleLabel.text =@"姓名:";
                cell.choseTextField.enabled = YES;
                cell.choseTextField.tag = 100;
                cell.choseTextField.delegate = self;

                cell.choseTextField.placeholder = @"请输入姓名";
            }else if (indexPath.row ==1){
                cell.AutherTitleLabel.text =@"身份证号:";
                cell.choseTextField.enabled = YES;
                cell.choseTextField.tag = 101;
                cell.choseTextField.delegate = self;
                cell.choseTextField.placeholder = @"请输入身份证号";
            }
        }else{
            cell.AutherButton.hidden = NO;
            if (indexPath.row == indexRow) {
                cell.AutherButton.selected = YES;
            }else{
                cell.AutherButton.selected = NO;
            }
            cell.choseTextField.text = @"";
            if (indexPath.row == 0) {
                cell.AutherTitleLabel.text = @"营业执照认证";
            }else if (indexPath.row ==1){
                cell.AutherTitleLabel.text = @"开户行认证";
            }
        }
       
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        indexRow = indexPath.row;
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];

    }else if (indexPath.section == 0){
        if (indexPath.row == 1) {
            UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择重复原因" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"重名",@"重开", nil];
            [actionSheet showInView:self.view];
        }
        
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        reasonStr = @"重名";
    }else{
        reasonStr = @"重开";
    }
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [shopListTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
