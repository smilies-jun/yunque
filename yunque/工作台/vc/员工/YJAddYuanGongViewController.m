//
//  YJAddYuanGongViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAddYuanGongViewController.h"
#import "CustomChooseView.h"
#import "YJChoseBtnView.h"
#import "CustomView.h"
#import "HDSelecterViewController.h"
#import "YJKeHuViewController.h"

@interface YJAddYuanGongViewController ()<UITextFieldDelegate>{
    CustomView *choseNameView;
    CustomView *chosePhonelView;
    CustomChooseView *choseAdressView;
    CustomView *choseAdressDetailView;
    YJChoseBtnView *choseSex;
    YJChoseBtnView *choseType;
    NSArray *myArray;

    
}
@property(nonatomic,strong)NSString *defualtProvince;
@property(nonatomic,strong)NSString *defualtCity;
@property(nonatomic,strong)NSString *defualtDistricts;
@end

@implementation YJAddYuanGongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"添加员工";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.RightFirstButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
     myArray = [[NSArray alloc]init];
     [self reoadDate];
    [self setUI];
}
- (void)reoadDate{
    
    NSString *url = [NSString stringWithFormat:@"%@/area/list",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->myArray = [result objectForKey:@"data"];
        // NSLog(  @"ree = ===%@",result);
    }];
    
}
- (void)rightClick{
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setUI{
    choseNameView = [[CustomView alloc]init];
    choseNameView.NameLabel.text = @"员工姓名";
    choseNameView.NameTextField.placeholder = @"请填写员工名称";
    choseNameView.NameTextField.delegate = self;
    if ([_userID integerValue]) {
        choseNameView.NameTextField.text = _name;
        //choseNameView.NameTextField.enabled = NO;

    }else{
        choseNameView.NameTextField.enabled = YES;
    }
    [self.view addSubview:choseNameView];
    [choseNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseSex = [[YJChoseBtnView alloc]init];
    choseSex.NameLabel.text = @"员工性别";
    choseSex.ChooseFirstLabel.text = @"男";
    choseSex.ChooseSecondLabel.text = @"女";
    choseSex.ChooseFirstbutton.tag = 101;
    choseSex.ChooseSecondbutton.tag = 102;
    choseSex.ChooseFirstbutton.selected = YES;
    [choseSex.ChooseFirstbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [choseSex.ChooseSecondbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseSex];
    [choseSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseNameView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    chosePhonelView = [[CustomView alloc]init];
    chosePhonelView.NameLabel.text = @"手机号码";
    chosePhonelView.NameTextField.placeholder = @"请填写手机号码";
    chosePhonelView.NameTextField.delegate = self;
    [self.view addSubview:chosePhonelView];
    [chosePhonelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseSex.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseAdressView = [[CustomChooseView alloc]init];
    choseAdressView.NameLabel.text = @"v收货人地址";
    choseAdressView.ChooseLabel.text = @"请选择收货人地址";
    choseAdressView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *choseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseAdressClick)];
    [choseAdressView addGestureRecognizer:choseTap];
    [self.view addSubview:choseAdressView];
    [choseAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->chosePhonelView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"下一步"];
    [choseAdressView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->choseAdressView.mas_right).offset(-20);
        make.top.mas_equalTo(self->choseAdressView.mas_top).offset(20);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    choseAdressDetailView = [[CustomView alloc]init];
    choseAdressDetailView.NameLabel.text = @"详细地址";
    choseAdressDetailView.NameTextField.delegate = self;

    choseAdressDetailView.NameTextField.placeholder = @"请填写详细地址";
    [self.view addSubview:choseAdressDetailView];
    [choseAdressDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseAdressView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseType = [[YJChoseBtnView alloc]init];
    choseType.NameLabel.text = @"员工角色";
    choseType.ChooseFirstLabel.text = @"导购";
    choseType.ChooseSecondLabel.text = @"店长";
    choseType.ChooseFirstbutton.tag = 201;
    choseType.ChooseSecondbutton.tag = 202;
    choseType.ChooseFirstbutton.selected = YES;
    [choseType.ChooseFirstbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [choseType.ChooseSecondbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:choseType];
    [choseType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseAdressDetailView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->choseType.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}
- (void)choseAdressClick{
    HDSelecterViewController *vc = [[HDSelecterViewController alloc]initWithDefualtProvince:self.defualtProvince city:self.defualtCity districts:self.defualtDistricts];
    vc.MyArray = self->myArray;
    
    vc.MyFirstStr = @"name";//
    vc.MySecondStr = @"areaVOS";//
    vc.MyThirdStr = @"name";//
    vc.MyFourStr = @"areaVOS";//
    vc.MyFiveStr =@"name";
    vc.categoryId = @"areaId";
    vc.title = @"请选择地址";
    __weak typeof(self) weakSelf = self;
    [vc setCompleteSelectBlock:^(NSString*province,NSString*provincecategoryId,NSString*city,NSString*citycategoryId,NSString*districts,NSString*districtscategoryId) {
        weakSelf.defualtProvince = province;
        weakSelf.defualtCity = city;
        weakSelf.defualtDistricts = districts;
        self->choseAdressView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,districts];
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
    [self presentViewController:vc animated:true completion:nil];
}
- (void)choseBtnClick:(UIButton *)Btn{
    NSInteger j = Btn.tag/100;
    for (int i =1; i <3 ; i++) {
        if (Btn.tag == 100*j +i) {
            Btn.selected = YES;
            continue;
        }
        UIButton *myBtn = (UIButton *)[self.view viewWithTag:i+100*j];
        myBtn.selected = NO;
        
    }
}
- (void)nextBtn{
    
    if(choseNameView.NameTextField.text.length){
        if (_defualtProvince.length) {
            if ( choseAdressDetailView.NameTextField.text.length) {
                if ([chosePhonelView.NameTextField.text integerValue]) {
                     [self postClick];
                }else{
                    [AnimationView showString:@"请输入手机号码"];
                }
               
            }else{
                [AnimationView showString:@"请输入详细地址"];
            }
            
        }else{
            [AnimationView showString:@"请选择地址"];
        }
    }else{
        [AnimationView showString:@"请输入员工姓名"];
    }
    
}
- (void)postClick{
    NSInteger sex;
    sex =1;
    
    UIButton *myBtn = (UIButton *)[self.view viewWithTag:101];
    if (myBtn.selected) {
        sex = 1;
    }else{
        sex = 2;
    }
    NSInteger name;
    name = 1;
    UIButton *myNameBtn = (UIButton *)[self.view viewWithTag:201];
    if (myNameBtn.selected) {
        name = 1;
    }else{
        name = 0;
    }
    NSString *url ;
    NSDictionary *dic;
    NSString *tokenID = NSuserUse(@"token");
    if ([_type integerValue] == 1) {
          url = [NSString stringWithFormat:@"%@/clerk/edit",BASE_URL];
        dic = @{@"name":choseNameView.NameTextField.text,
                @"address":choseAdressDetailView.NameTextField.text,
                 @"phone":chosePhonelView.NameTextField.text,
                @"gender":[NSNumber numberWithInteger:sex],
                 @"role":[NSNumber numberWithInteger:name],
                @"city":_defualtCity,
                @"userId":_userID,
                @"province":_defualtProvince,
                @"town":_defualtDistricts,
                };
    }else{
        url = [NSString stringWithFormat:@"%@/clerk/add",BASE_URL];
        dic = @{@"name":choseNameView.NameTextField.text,
                  @"phone":chosePhonelView.NameTextField.text,
                @"address":choseAdressDetailView.NameTextField.text,
                @"gender":[NSNumber numberWithInteger:sex],
                @"role":[NSNumber numberWithInteger:name],
                @"city":_defualtCity,
                @"province":_defualtProvince,
                @"town":_defualtDistricts,
                };
    }
    

  
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[YJKeHuViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
