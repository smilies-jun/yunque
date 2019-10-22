//
//  YJSetPassWordViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJSetPassWordViewController.h"
#import "YJForgetPassWordViewController.h"
#import "YJLoginAndReginViewController.h"
#import "YJModefiyPassWordViewController.h"



@interface YJSetPassWordViewController ()<UITextFieldDelegate>{
    UIButton *loginBtn;
    UIImageView *loginImage;
    
    UITextField *phoneNumberTextField;
    
    UILabel *phoneAndPasswordLabel;
    UITextField *passWordAndCodeNumberTextField;
    
    UILabel *ForgetPasswordLabel;
    UILabel *phonecodeLabel;
    UITextField *phoneCodeNumberTextField;
    UIImageView *PhoneCodelineImageView;
    
    
    UIButton *PassIconBtn;
    UIButton *SureIconBtn;
}


@end

@implementation YJSetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
     [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self InitUI];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJForgetPassWordViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
-(void)InitUI{
    loginBtn = [[UIButton alloc]init];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5.0f;
    loginBtn.tag = 100;
    loginBtn.selected = YES;
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loginBtn setTitle:@"重新设置密码" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(StatusBarHeight+64);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(20);
    }];
    
    loginImage = [[UIImageView alloc]init];
    loginImage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginImage];
    [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left);
        make.top.mas_equalTo(self->loginBtn.mas_bottom);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(2);
    }];
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"新密码";
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->loginImage.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    phoneNumberTextField = [[UITextField alloc]init];
    phoneNumberTextField.placeholder = @"请输入不低于8位数的字母和数字组合";
    phoneNumberTextField.delegate = self;
    phoneNumberTextField.secureTextEntry = YES;
    phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入不低于8位数的字母和数字组合" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:phoneNumberTextField];
    [phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(25);
    }];
   
    UIImageView *PhonelineImageView = [[UIImageView alloc]init];
    PhonelineImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:PhonelineImageView];
    [PhonelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->phoneNumberTextField.mas_left);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    PassIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PassIconBtn.selected = YES;
    [PassIconBtn addTarget:self action:@selector(iceClick:) forControlEvents:UIControlEventTouchUpInside];
    [PassIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [PassIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:PassIconBtn];
    [PassIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.bottom.mas_equalTo(PhonelineImageView.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    phonecodeLabel = [[UILabel alloc]init];
    phonecodeLabel.text = @"确认密码";
    phonecodeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phonecodeLabel];
    [phonecodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    phoneCodeNumberTextField = [[UITextField alloc]init];
    phoneCodeNumberTextField.placeholder = @"请输入确认密码";
    phoneCodeNumberTextField.delegate = self;
    phoneCodeNumberTextField.secureTextEntry = YES;
    phoneCodeNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:phoneCodeNumberTextField];
    [phoneCodeNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phonecodeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80);
        make.height.mas_equalTo(25);
    }];
    
    PhoneCodelineImageView = [[UIImageView alloc]init];
    PhoneCodelineImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:PhoneCodelineImageView];
    [PhoneCodelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->phoneCodeNumberTextField.mas_left);
        make.top.mas_equalTo(self->phoneCodeNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    SureIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SureIconBtn.selected = YES;
    [SureIconBtn addTarget:self action:@selector(iceSureClick:) forControlEvents:UIControlEventTouchUpInside];
    [SureIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [SureIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:SureIconBtn];
    [SureIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.bottom.mas_equalTo(self->PhoneCodelineImageView.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(LoginNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->PhoneCodelineImageView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}
- (void)iceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        phoneNumberTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        phoneNumberTextField.secureTextEntry = YES;
    }
    
}
- (void)iceSureClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        phoneCodeNumberTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        phoneCodeNumberTextField.secureTextEntry = YES;
    }
}
- (void)LoginNextBtn{
    if ([phoneNumberTextField.text isEqualToString:phoneCodeNumberTextField.text]) {
        [self postClick];
    }else{
         [AnimationView showString:@"两次输入密码不一致"];
    }
}
- (void)postClick{
    if (phoneNumberTextField.text.length) {
        NSString *url = [NSString stringWithFormat:@"%@/client/resetPassword",BASE_URL];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:_phoneStr,@"phone",phoneNumberTextField.text,@"password",nil];
        [[DateSource  sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            
            if ([[result objectForKey:@"code"]integerValue]==200){
                // [self showProgress:@"注册成功"];
                 [AnimationView showString:@"请重新登陆"];
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[YJLoginAndReginViewController     class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[YJModefiyPassWordViewController     class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                
            }else{
                NSString *ErrorMessage = [result objectForKey:@"errmsg"];
                [AnimationView showString:ErrorMessage];
                
            }
        }];
    }else{
        [AnimationView showString:@"请输入密码"];
    }
}
- (void)LoginClicked:(UIButton *)sender{
    
}

#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
    }
    
}

- (BOOL)dismissAllKeyBoard:(UIView *)view{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
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
