//
//  YJAddCustomerViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAddCustomerViewController.h"
#import "YJChoseBtnView.h"
#import "CustomView.h"
#import "HDSelecterView.h"
#import "CustomChooseView.h"
#import "YJCustomerViewController.h"
#import "HDSelecterViewController.h"

@interface YJAddCustomerViewController ()<UITextFieldDelegate>{
    CustomView *choseNameView;
    CustomChooseView *choseAdressView;
    CustomView *choseAdressDetailView;
    YJChoseBtnView *choseSex;
    CustomView *choseCustomerDetailView;
    CustomView *chosePhonelView;
    CustomView *choseBeiZhuDetailView;
    NSArray *myArray;
      UIScrollView *scrollView;
}
@property(nonatomic,strong)NSString *defualtProvince;
@property(nonatomic,strong)NSString *defualtCity;
@property(nonatomic,strong)NSString *defualtDistricts;
@end

@implementation YJAddCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    if ([_type integerValue ] == 1) {
         self.TopTitleLabel.text= @"修改客户";
    }else{
         self.TopTitleLabel.text= @"新建客户";
        
    }
   
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
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJCustomerViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}

- (void)setUI{
    scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+300);
      

    [self.view addSubview:scrollView];
    
    choseNameView = [[CustomView alloc]init];
    choseNameView.NameLabel.text = @"客户名称";
    choseNameView.NameTextField.placeholder = @"请填写客户名称";
    if ([_customerid integerValue]) {
        choseNameView.NameTextField.text = _name;
      //  choseNameView.NameTextField.enabled = NO;
    }else{
        //  choseNameView.NameTextField.enabled = YES;
    }
    choseNameView.NameTextField.delegate = self;
    [scrollView addSubview:choseNameView];
    [choseNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseSex = [[YJChoseBtnView alloc]init];
    choseSex.NameLabel.text = @"客户性别";
    choseSex.ChooseFirstLabel.text = @"男";
    choseSex.ChooseSecondLabel.text = @"女";
    choseSex.ChooseFirstbutton.tag = 101;
    choseSex.ChooseSecondbutton.tag = 102;
    choseSex.ChooseFirstbutton.selected = YES;
    [choseSex.ChooseFirstbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [choseSex.ChooseSecondbutton addTarget:self action:@selector(choseBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [scrollView addSubview:choseSex];
    [choseSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->choseNameView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseAdressView = [[CustomChooseView alloc]init];
    choseAdressView.NameLabel.text = @"客户地址";
    choseAdressView.ChooseLabel.text = @"请选择客户地址";
    choseAdressView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *choseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseAdressClick)];
    [choseAdressView addGestureRecognizer:choseTap];
    [scrollView addSubview:choseAdressView];
    [choseAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->choseSex.mas_bottom).offset(20);
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
    choseAdressDetailView.NameTextField.placeholder = @"请填写详细地址";
    choseAdressDetailView.NameTextField.delegate = self;
    [scrollView addSubview:choseAdressDetailView];
    [choseAdressDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->choseAdressView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];

    chosePhonelView = [[CustomView alloc]init];
    chosePhonelView.NameLabel.text = @"手机号码";
    chosePhonelView.NameTextField.placeholder = @"请填写手机号码";
    chosePhonelView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    chosePhonelView.NameTextField.delegate = self;
    [scrollView addSubview:chosePhonelView];
    [chosePhonelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->choseAdressDetailView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];

    choseCustomerDetailView = [[CustomView alloc]init];
    choseCustomerDetailView.NameLabel.text = @"客户需求";
    choseCustomerDetailView.NameTextField.placeholder = @"请填写客户需求";
    choseCustomerDetailView.NameTextField.delegate = self;
    [scrollView addSubview:choseCustomerDetailView];
    [choseCustomerDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->chosePhonelView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseBeiZhuDetailView = [[CustomView alloc]init];
    choseBeiZhuDetailView.NameLabel.text = @"备      注";
    choseBeiZhuDetailView.NameTextField.placeholder = @"请填写备注";
    choseBeiZhuDetailView.NameTextField.delegate = self;
    [scrollView addSubview:choseBeiZhuDetailView];
    [choseBeiZhuDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scrollView.mas_left);
        make.top.mas_equalTo(self->choseCustomerDetailView.mas_bottom).offset(1);
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
    [scrollView   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->choseBeiZhuDetailView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)nextBtn{
   
    if(choseNameView.NameTextField.text.length){
            if (_defualtProvince.length) {
                if ( choseAdressDetailView.NameTextField.text.length) {
                    if (choseCustomerDetailView.NameTextField.text.length) {
                        if (chosePhonelView.NameTextField.text.length) {
                          [self postClick];
                        }else{
                          [AnimationView showString:@"请填写客户电话号码"];
                        }
                            
                            
                       
                    }else{
                        [AnimationView showString:@"请输入需求"];
                    }
                }else{
                    [AnimationView showString:@"请输入详细地址"];
                }
                
            }else{
             [AnimationView showString:@"请选择地址"];
        }
    }else{
        [AnimationView showString:@"请输入客户名称"];
    }

}
- (void)postClick{
    NSInteger sex;
    UIButton *myBtn = (UIButton *)[self.view viewWithTag:101];
    if (myBtn.selected) {
        sex = 1;
    }else{
        sex = 2;
    }
    NSDictionary *dic;
    NSString *tokenID = NSuserUse(@"token");
    if ([_type integerValue] == 1) {
        dic = @{@"nickName":choseNameView.NameTextField.text,
                @"address":choseAdressDetailView.NameTextField.text,
                @"demand":choseCustomerDetailView.NameTextField.text,
                @"gender":[NSNumber numberWithInteger:sex],
                @"city":_defualtCity,
                @"province":_defualtProvince,
                @"town":_defualtDistricts,
                @"phoneNumber":chosePhonelView.NameTextField.text,
                @"remark":choseBeiZhuDetailView.NameTextField.text,
                @"customerId":_customerid
                };
    }else{
        dic = @{@"nickName":choseNameView.NameTextField.text,
                @"address":choseAdressDetailView.NameTextField.text,
                @"demand":choseCustomerDetailView.NameTextField.text,
                @"gender":[NSNumber numberWithInteger:sex],
                @"city":_defualtCity,
                @"province":_defualtProvince,
                @"town":_defualtDistricts,
                @"phoneNumber":chosePhonelView.NameTextField.text,
                @"remark":choseBeiZhuDetailView.NameTextField.text
                };
    }
  
    
    NSLog(@"dic = %@",dic);
    
    NSString *url = [NSString stringWithFormat:@"%@/customer/beforeAdd",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        NSLog(@"re == %@",result);
         NSLog(@"errr == %@",error);
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[YJCustomerViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
   
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
- (void)choseAdressClick{
    HDSelecterViewController *vc = [[HDSelecterViewController alloc]initWithDefualtProvince:self.defualtProvince city:self.defualtCity districts:self.defualtDistricts];
    //NSLog(@"mya=== %@",myArray);
    vc.MyArray = myArray;
    vc.MyFirstStr = @"name";//
    vc.MySecondStr = @"areaVOS";//
    vc.MyThirdStr = @"name";//
    vc.MyFourStr = @"areaVOS";//
    vc.MyFiveStr =@"name";
    vc.categoryId = @"areaId";
    //     vc.MyFirstStr = @"province";//
    //        vc.MySecondStr = @"citys";//
    //        vc.MyThirdStr = @"city";//
    //        vc.MyFourStr = @"districts";//
    //        vc.title = @"请选择地址";
    __weak typeof(self) weakSelf = self;
    [vc setCompleteSelectBlock:^(NSString*province,NSString*provincecategoryId,NSString*city,NSString*citycategoryId,NSString*districts,NSString*districtscategoryId) {
        weakSelf.defualtProvince = province;
        weakSelf.defualtCity = city;
           weakSelf.defualtDistricts = districts;
        self->choseAdressView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,districts];
        NSLog(@"%@,%@,%@ = %@",province,city,districts,districtscategoryId);
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
    [self HideKeyBoardClick];
    [self presentViewController:vc animated:true completion:nil];
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
