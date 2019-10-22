//
//  YJForgetPassWordViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJForgetPassWordViewController.h"
#import "PooCodeView.h"
#import "YJAuthenticationViewController.h"
#import "UIButton+CountDown.h"
#import "YJLoginAndReginViewController.h"
#import "YJSetPassWordViewController.h"
#import "YJModefiyPassWordViewController.h"

@interface YJForgetPassWordViewController ()<UITextFieldDelegate>{
    UIButton *loginBtn;
    UIImageView *loginImage;
 
    UITextField *phoneNumberTextField;
    
    UILabel *phoneAndPasswordLabel;
    UITextField *passWordAndCodeNumberTextField;
    
    UILabel *ForgetPasswordLabel;
    UILabel *phonecodeLabel;
    UITextField *phoneCodeNumberTextField;
    UIImageView *PhoneCodelineImageView;
    

    
    PooCodeView *pooCodeView;
    
    int _second;
}

@end

@implementation YJForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
     [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    _second = 60;
    [self InitUI];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJLoginAndReginViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJModefiyPassWordViewController class]]) {
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
    [loginBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [loginBtn addTarget:self action:@selector(LoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(StatusBarHeight+64);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    loginImage = [[UIImageView alloc]init];
    loginImage.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:loginImage];
    [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left);
        make.top.mas_equalTo(self->loginBtn.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(2);
    }];
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->loginImage.mas_bottom).offset(40);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    phoneNumberTextField = [[UITextField alloc]init];
    phoneNumberTextField.placeholder = @"请输入手机号码";
    phoneNumberTextField.delegate = self;
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:phoneNumberTextField];
    [phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(100);
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80);
        make.height.mas_equalTo(25);
    }];
    UILabel *chinalabel = [[UILabel alloc]init];
    chinalabel.text = @"+86(中国)";
    chinalabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:chinalabel];
    [chinalabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    UIButton *PhoneIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [PhoneIconBtn addTarget:self action:@selector(deleClick) forControlEvents:UIControlEventTouchUpInside];
    [PhoneIconBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [self.view addSubview:PhoneIconBtn];
    [PhoneIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(phoneLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UIImageView *PhonelineImageView = [[UIImageView alloc]init];
    PhonelineImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:PhonelineImageView];
    [PhonelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->phoneNumberTextField.mas_left);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80);
        make.height.mas_equalTo(0.5);
    }];
    phonecodeLabel = [[UILabel alloc]init];
    phonecodeLabel.text = @"手机验证码";
    phonecodeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phonecodeLabel];
    [phonecodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    phoneCodeNumberTextField = [[UITextField alloc]init];
    phoneCodeNumberTextField.placeholder = @"请输入手机验证码";
    phoneCodeNumberTextField.delegate = self;
    phoneCodeNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneCodeNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机验证码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:phoneCodeNumberTextField];
    [phoneCodeNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phonecodeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80-40);
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
    _GetCode = [[UIButton alloc] init];
    _GetCode.hidden = NO;
    // [_GetCode setTitle:@"获取" forState:UIControlStateNormal];
      [_GetCode fireWithTime:0 title:@"发送验证码" countDownTitle:@"秒" mainBGColor:[UIColor whiteColor] countBGColor:[UIColor whiteColor] mainTextColor:font_main_color countTextColor:[UIColor blackColor]];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    [_GetCode setBackgroundColor:font_main_color];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_GetCode addTarget:self action:@selector(senderInputSecurityCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GetCode];
    
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(self->phoneCodeNumberTextField.mas_top);
        make.right.mas_equalTo(self->PhoneCodelineImageView.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(25);
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
- (void)deleClick{
    phoneNumberTextField.text = @"";
    phoneNumberTextField.placeholder = @"请输入手机号码";
}
#pragma mark 获取验证码
- (void)senderInputSecurityCodeBtnClicked

{
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:phoneNumberTextField.text];
    if (!isMatch) {
        [AnimationView showString:@"填写正确的手机号和密码"];
        
    }else{
        NSString *url = [NSString stringWithFormat:@"%@/client/forgotSendCode",BASE_URL];
        
        //        _second = 90;
        //        _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumberTextField.text ,@"phone",nil];
        //验证码获取陈功or失败
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue]==200) {
                [self->_GetCode fireWithTime:60 title:@"重新获取" countDownTitle:@"秒" mainBGColor:[UIColor whiteColor] countBGColor:[UIColor whiteColor] mainTextColor:font_main_color countTextColor:font_main_color];
                [AnimationView showString:@"验证码已发送"];
            }else{
                NSString *ErrorMessage = [result objectForKey:@"errmsg"];
                [AnimationView showString:ErrorMessage];
                
            }
            
        }];
        
        
        
    }
}

#pragma mark  - - 验证码倒计时 - -
- (void)timing
{
    if (_second > 0) {
        _second--; // 时间递减
        NSString* title = [NSString stringWithFormat:@"%dS", _second];
        _GetCode.enabled = NO;
        [_GetCode setTitle:title forState:UIControlStateDisabled];
        
    }
    else if (_second == 0) {
        [_securityCodeTimer invalidate];
        _GetCode.enabled = YES;
        [_GetCode setTitle:@"重新发送" forState:UIControlStateNormal];
        
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
- (void)LoginNextBtn{
    if (phoneCodeNumberTextField.text.length) {
        NSString *url = [NSString stringWithFormat:@"%@/client/forgotCheckCode",BASE_URL];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumberTextField.text,@"phone",phoneCodeNumberTextField.text,@"code",nil];
        [[DateSource  sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            
            if ([[result objectForKey:@"code"]integerValue]==200){
                // [self showProgress:@"注册成功"];
                YJSetPassWordViewController *vc = [[YJSetPassWordViewController alloc]init];
                vc.phoneStr = self->phoneNumberTextField.text;
                [self.navigationController pushViewController:vc animated:NO];
            }else{
                NSString *ErrorMessage = [result objectForKey:@"errmsg"];
                [AnimationView showString:ErrorMessage];
                
            }
        }];
    }else{
        [AnimationView showString:@"请输入验证码"];
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
