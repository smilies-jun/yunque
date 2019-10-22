//
//  YJShowYuanGongViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShowYuanGongViewController.h"
#import "CustomChooseView.h"
#import "YJAddYuanGongViewController.h"

@interface YJShowYuanGongViewController (){
        CustomChooseView *choseNameView;
        CustomChooseView *choseSexView;
        CustomChooseView *chosePhoneView;
        CustomChooseView *choseAdressView;
        CustomChooseView *choseAdressDetailView;
        CustomChooseView *choseNameTypeView;
        NSDictionary *mydic;
}

@end

@implementation YJShowYuanGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"员工信息";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    self.RightFirstButton.hidden = YES;
    mydic = [[NSDictionary alloc]init];
    [self reoadDate];
   
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");
    
    NSString *url = [NSString stringWithFormat:@"%@/clerk/info?userId=%@",BASE_URL,_userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            self->mydic = [result objectForKey:@"data"];
           [self setUI];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
}
- (void)rightClick{
    YJAddYuanGongViewController *vc = [[YJAddYuanGongViewController alloc]init];
    vc.type = @"1";
    vc.userID = _userID;
    vc.name = [mydic objectForKey:@"name"];
    [self.navigationController   pushViewController:vc animated:NO];
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setUI{
    choseNameView = [[CustomChooseView alloc]init];
    choseNameView.NameLabel.text = @"员工姓名";
      choseNameView.ChooseLabel.text = [NSString stringWithFormat:@"%@",[mydic objectForKey:@"name"]];
    [self.view addSubview:choseNameView];
    [choseNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseSexView = [[CustomChooseView alloc]init];
    choseSexView.NameLabel.text = @"员工姓别";
    if ([[mydic objectForKey:@"gender"]integerValue] == 1) {
        choseSexView.ChooseLabel.text =@"男";
    }else{
        choseSexView.ChooseLabel.text =@"女";
    }
    [self.view addSubview:choseSexView];
    [choseSexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseNameView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    chosePhoneView = [[CustomChooseView alloc]init];
    chosePhoneView.NameLabel.text = @"电话号码";
    chosePhoneView.ChooseLabel.text = [NSString stringWithFormat:@"%@",[mydic objectForKey:@"phone"]];
    [self.view addSubview:chosePhoneView];
    [chosePhoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseSexView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseAdressView = [[CustomChooseView alloc]init];
    choseAdressView.NameLabel.text = @"所属地区";
    choseAdressView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@%@",[mydic objectForKey:@"province"],[mydic objectForKey:@"city"],[mydic objectForKey:@"area"]];

    [self.view addSubview:choseAdressView];
    [choseAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->chosePhoneView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseAdressDetailView = [[CustomChooseView alloc]init];
    choseAdressDetailView.NameLabel.text = @"详细地址";
    choseAdressDetailView.ChooseLabel.text =[NSString stringWithFormat:@"%@",[mydic objectForKey:@"address"]];

    [self.view addSubview:choseAdressDetailView];
    [choseAdressDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseAdressView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseNameTypeView = [[CustomChooseView alloc]init];
    choseNameTypeView.NameLabel.text = @"员工角色";
    NSArray *aray = [mydic objectForKey:@"roleList"];
    if ([[[aray objectAtIndex:0]objectForKey:@"roleId"]integerValue] == 5) {
        choseNameTypeView.ChooseLabel.text =@"导购";
    }else{
        choseNameTypeView.ChooseLabel.text =@"店长";
    }
    [self.view addSubview:choseNameTypeView];
    [choseNameTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseAdressDetailView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];

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
