
//
//  YJLoginAndReginViewController.m
//  maike
//
//  Created by Apple on 2019/7/22.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJLoginAndReginViewController.h"
#import "PooCodeView.h"
#import "YJAuthenticationViewController.h"
#import "UIButton+CountDown.h"
#import "YJForgetPassWordViewController.h"
#import "YJYingYeZhiZhaoViewController.h"
#import "TFPopup.h"
#import "YJProViewController.h"

@interface YJLoginAndReginViewController ()<UITextFieldDelegate>{
    UIButton *loginBtn;
    UIImageView *loginImage;
    
    UIButton *reginBtn;
    UIImageView *reginImage;
    
    
    UITextField *phoneNumberTextField;//手机号
    
    UILabel *phoneAndPasswordLabel;
    UITextField *passWordAndCodeNumberTextField;
    
    UILabel *ForgetPasswordLabel;
    UILabel *phonecodeLabel;
    UITextField *phoneCodeNumberTextField;
    UIImageView *PhoneCodelineImageView;
    
    UILabel *passWordcodeLabel;
    UITextField *passWordNumberTextField;
    UIImageView *PassWordlineImageView;
    
    UILabel *forgetLabel;
    
    PooCodeView *pooCodeView;
    
    UIButton *PassIconBtn;
    UIButton *ReginPassIconBtn;
    UIButton *PassWorldIconBtn;
 
    UIButton *sureBtn;
    int _second;
    
    
    UIButton *ClickBtn;
    UILabel *nameLabel;
    UIView *choseView;//弹出视图
    NSString *imageUrl;
    UIImageView *imageView;
    UITextField *codeTextField;
}

@end
@implementation YJLoginAndReginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = YES;
    _second = 60;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.userInteractionEnabled =  YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideAllKey)];
    [self.view addGestureRecognizer:tap];
    [self InitUI];
    NSString *url = [NSString stringWithFormat:@"%@/admin/getPicCode?phone=%@",BASE_URL,phoneNumberTextField.text];

    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->imageUrl = [result objectForKey:@"data"];
      
    }];
   

}
- (void)hideAllKey{
    [self HideKeyBoardClick];
}

-(void)InitUI{
    loginBtn = [[UIButton alloc]init];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5.0f;
    loginBtn.tag = 100;
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    loginBtn.selected = YES;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:font_main_color forState:UIControlStateSelected];
    [loginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(LoginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.view.mas_top).offset(StatusBarHeight+64);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(35);
    }];
    
    loginImage = [[UIImageView alloc]init];
    loginImage.backgroundColor = font_main_color;
    [self.view addSubview:loginImage];
    [loginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->loginBtn.mas_centerX);
        make.top.mas_equalTo(self->loginBtn.mas_bottom);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(2);
    }];
    
    reginBtn = [[UIButton alloc]init];
    reginBtn.tag = 101;
    reginBtn.selected = NO;
    reginBtn.layer.masksToBounds = YES;
    reginBtn.layer.cornerRadius = 5.0f;
    reginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [reginBtn setTitleColor:font_main_color forState:UIControlStateSelected];
    [reginBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [reginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [reginBtn addTarget:self action:@selector(reginClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reginBtn];
    [reginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_right).offset(10);
        make.top.mas_equalTo(self.view.mas_top).offset(StatusBarHeight+64);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(35);
    }];
    reginImage = [[UIImageView alloc]init];
    reginImage.backgroundColor = [UIColor grayColor];
    [self.view addSubview:reginImage];
    [reginImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->reginBtn.mas_centerX);
        make.top.mas_equalTo(self->reginBtn.mas_bottom);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(2);
    }];
    UILabel *phoneLabel = [[UILabel alloc]init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->reginImage.mas_bottom).offset(40);
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
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
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
    PhonelineImageView.backgroundColor = font_main_color;
    [self.view addSubview:PhonelineImageView];
    [PhonelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    
    phoneAndPasswordLabel = [[UILabel alloc]init];
    phoneAndPasswordLabel.text = @"密码";
    phoneAndPasswordLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:phoneAndPasswordLabel];
    [phoneAndPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phoneNumberTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    passWordAndCodeNumberTextField = [[UITextField alloc]init];
    passWordAndCodeNumberTextField.placeholder = @"请输入密码";
    passWordAndCodeNumberTextField.delegate = self;
    passWordAndCodeNumberTextField.secureTextEntry = YES;
    passWordAndCodeNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:passWordAndCodeNumberTextField];
    [passWordAndCodeNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->phoneAndPasswordLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80);
        make.height.mas_equalTo(25);
    }];
    PassIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    PassIconBtn.selected = YES;
    [PassIconBtn addTarget:self action:@selector(iceClick:) forControlEvents:UIControlEventTouchUpInside];
    [PassIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [PassIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:PassIconBtn];
    [PassIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(self->phoneAndPasswordLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
   
    
    UIImageView *PasslineImageView = [[UIImageView alloc]init];
    PasslineImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:PasslineImageView];
    [PasslineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->passWordAndCodeNumberTextField.mas_left);
        make.top.mas_equalTo(self->passWordAndCodeNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    forgetLabel = [[UILabel alloc]init];
    forgetLabel.text = @"忘记密码";
    forgetLabel.font = [UIFont systemFontOfSize:14];
    forgetLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetPassClick)];
    [forgetLabel addGestureRecognizer:forgetTap];
    forgetLabel.textAlignment = NSTextAlignmentRight;
    forgetLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self.view addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(PasslineImageView.mas_right);
        make.top.mas_equalTo(PasslineImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    PhoneCodelineImageView = [[UIImageView alloc]init];
    PhoneCodelineImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:PhoneCodelineImageView];
    [PhoneCodelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->passWordAndCodeNumberTextField.mas_left);
        make.top.mas_equalTo(self->passWordAndCodeNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    _GetCode = [[UIButton alloc] init];
    _GetCode.hidden = YES;

    [_GetCode fireWithTime:0 title:@"发送验证码" countDownTitle:@"秒" mainBGColor:[UIColor whiteColor] countBGColor:[UIColor whiteColor] mainTextColor:font_main_color countTextColor:[UIColor blackColor]];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
   // [_GetCode setBackgroundColor:font_main_color];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(senderInputSecurityCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GetCode];
    
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(self->passWordAndCodeNumberTextField.mas_top);
        make.right.mas_equalTo(self->PhoneCodelineImageView.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(25);
    }];
    passWordcodeLabel = [[UILabel alloc]init];
    passWordcodeLabel.text = @"密码";
    passWordcodeLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:passWordcodeLabel];
    [passWordcodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->passWordAndCodeNumberTextField.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    passWordNumberTextField = [[UITextField alloc]init];
    passWordNumberTextField.placeholder = @"请输入密码";
    passWordNumberTextField.delegate = self;
    passWordNumberTextField.secureTextEntry = YES;
    passWordNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:passWordNumberTextField];
    [passWordNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->loginBtn.mas_left).offset(10);
        make.top.mas_equalTo(self->passWordcodeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60-80);
        make.height.mas_equalTo(25);
    }];
    ReginPassIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ReginPassIconBtn.selected = YES;
    ReginPassIconBtn.hidden = YES;
    [ReginPassIconBtn addTarget:self action:@selector(ReiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [ReginPassIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [ReginPassIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:ReginPassIconBtn];
    [ReginPassIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.top.mas_equalTo(self->passWordcodeLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    PassWordlineImageView = [[UIImageView alloc]init];
    PassWordlineImageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:PassWordlineImageView];
    [PassWordlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->passWordNumberTextField.mas_left);
        make.top.mas_equalTo(self->passWordNumberTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    ClickBtn = [[UIButton alloc]init];
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickBtn.selected = YES;
    ClickBtn.hidden = YES;
    [ClickBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ClickBtn];
    [ClickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->PassWordlineImageView.mas_bottom).offset(20);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    nameLabel =[[UILabel alloc]init];
    nameLabel.hidden = YES;
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.userInteractionEnabled = YES;
    nameLabel.font = [UIFont systemFontOfSize:14];
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [self.view addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->ClickBtn.mas_right).offset(10);
        make.top.mas_equalTo(self->PassWordlineImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"登录" forState:UIControlStateNormal];
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
        make.top.mas_equalTo(self->PassWordlineImageView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
    phonecodeLabel.hidden = YES;
    phoneCodeNumberTextField.hidden = YES;
    PhoneCodelineImageView.hidden = YES;
    passWordcodeLabel.hidden = YES;
    passWordNumberTextField.hidden = YES;
    PassWordlineImageView.hidden = YES;
    pooCodeView.hidden = YES;
}
- (void)gesClick{
    YJProViewController *vc = [[YJProViewController alloc]init];
    vc.WebStr = @"http://www.maikehome.cn/registrationagreement.htm";
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)clicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
#pragma mark 获取验证码
- (void)senderInputSecurityCodeBtnClicked

{
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:phoneNumberTextField.text];
    if (!isMatch) {
         [AnimationView showString:@"填写正确的手机号"];
        
    }else{
         NSString *url = [NSString stringWithFormat:@"%@/client/sendCode",BASE_URL];
        
        //        _second = 90;
        //        _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumberTextField.text ,@"phone",nil];
        //验证码获取陈功or失败
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue]==200) {
                if ([[result objectForKey:@"data"] isEqualToString:@"1"]) {
                      [self choseShopType];
                }else{
                    [self->_GetCode fireWithTime:60 title:@"重新获取" countDownTitle:@"秒" mainBGColor:[UIColor whiteColor] countBGColor:[UIColor whiteColor] mainTextColor:font_main_color countTextColor:font_main_color];
                    [AnimationView showString:@"验证码已发送"];
                
                }
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
     [sureBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    reginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    reginImage.backgroundColor = [UIColor grayColor];
    loginImage.backgroundColor  = font_main_color;
    phonecodeLabel.hidden = YES;
    PassIconBtn.hidden  =NO;
    phoneCodeNumberTextField.hidden = YES;
    PhoneCodelineImageView.hidden = YES;
    loginBtn.selected = YES;
    reginBtn.selected = NO;
    passWordcodeLabel.hidden = YES;
    passWordNumberTextField.hidden = YES;
    PassWordlineImageView.hidden = YES;
    pooCodeView.hidden = YES;
    phoneAndPasswordLabel.text = @"密码";
    passWordAndCodeNumberTextField.text=@"";

    passWordAndCodeNumberTextField.placeholder = @"请输入密码";
        passWordAndCodeNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    passWordAndCodeNumberTextField.secureTextEntry = YES;
    passWordAndCodeNumberTextField.keyboardType = UIKeyboardTypeDefault;
    _GetCode.hidden = YES;
    ForgetPasswordLabel.hidden = NO;
    forgetLabel.hidden = NO;
 
    ClickBtn.hidden = YES;
    nameLabel.hidden = YES;
    ReginPassIconBtn.hidden = YES;
    ReginPassIconBtn.hidden = YES;

}
- (void)reginClicked:(UIButton *)sender{
    ReginPassIconBtn.hidden = NO;

     [sureBtn setTitle:@"注册" forState:UIControlStateNormal];
    PassIconBtn.hidden  =YES;
    forgetLabel.hidden = YES;
    reginImage.backgroundColor = font_main_color;
    loginImage.backgroundColor  = [UIColor grayColor];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    reginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    phonecodeLabel.hidden = NO;
    phoneCodeNumberTextField.hidden = NO;
    PhoneCodelineImageView.hidden = NO;
    loginBtn.selected = NO;
    _GetCode.hidden = NO;
    ForgetPasswordLabel.hidden = YES;
    reginBtn.selected = YES;
    passWordcodeLabel.hidden = NO;
    passWordNumberTextField.hidden = NO;
    PassWordlineImageView.hidden = NO;
    pooCodeView.hidden = NO;
    phoneAndPasswordLabel.text = @"验证码";
    passWordAndCodeNumberTextField.text=@"";
    passWordAndCodeNumberTextField.placeholder = @"请输入验证码";passWordAndCodeNumberTextField.secureTextEntry =NO;
    passWordAndCodeNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    passWordAndCodeNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    ClickBtn.hidden = NO;
    nameLabel.hidden = NO;
    ReginPassIconBtn.hidden = NO;
}
- (void)deleClick{
    phoneNumberTextField.text = @"";
    phoneNumberTextField.placeholder = @"请输入手机号码";
}
- (void)iceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        passWordAndCodeNumberTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        passWordAndCodeNumberTextField.secureTextEntry = YES;
    }
    
}
- (void)ReiceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        passWordNumberTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        passWordNumberTextField.secureTextEntry = YES;
    }
}
- (UIView *)getChoseView:(NSString *)str{
    UIView *TypeView= [[UIView alloc]init];
    TypeView.frame = CGRectMake(80, 200, SCREEN_WIDTH-80, SCREEN_HEIGHT-200);
    TypeView.backgroundColor = [UIColor whiteColor];
    imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(refreshImage)];
    [imageView addGestureRecognizer:imageTap];
    [TypeView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TypeView.mas_top).offset(20);
        make.left.mas_equalTo(TypeView.mas_left).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    codeTextField = [[UITextField alloc]init];
    codeTextField.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
    codeTextField.placeholder = @"输入图形验证码";
    [TypeView addSubview:codeTextField];
    [codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self->imageView.mas_bottom);
        make.left.mas_equalTo(self->imageView.mas_right).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-120-50);
        make.height.mas_equalTo(40);
    }];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"确定" forState:UIControlStateNormal];
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 5.0f;
    codeBtn.backgroundColor =font_main_color;
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [codeBtn addTarget:self action:@selector(codeBtn) forControlEvents:UIControlEventTouchUpInside];
    [TypeView  addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->imageView.mas_bottom).offset(20);
        make.left.mas_equalTo(TypeView.mas_left).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
    
    return TypeView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    passWordAndCodeNumberTextField.text= @"";
    passWordNumberTextField.text= @"";
     passWordAndCodeNumberTextField.placeholder = @"请输入密码";
     passWordNumberTextField.placeholder = @"请输入密码";
}
- (void)refreshImage{
    NSString *url = [NSString stringWithFormat:@"%@/admin/getPicCode?phone=%@",BASE_URL,phoneNumberTextField.text];

    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->imageUrl = [result objectForKey:@"data"];
        
    }];
}
- (void)codeBtn{
    if (codeTextField.text.length) {
         [choseView tf_hide];
    }else{
        [AnimationView showString:@"请输入图形验证"];
    }
   
}
//入驻类型选择
- (void)choseShopType{
    [self HideKeyBoardClick];
    TFPopupParam *param = [TFPopupParam new];
    param.disuseBackgroundTouchHide = YES;
    param.popupSize = CGSizeMake(SCREEN_WIDTH, 140);//设置弹框的尺寸
    param.offset = CGPointZero;//在计算好的位置上偏移
    choseView = [self getChoseView:@"1"];
    [choseView tf_showSlide:self.view direction:PopupDirectionContainerCenter popupParam:param];
}
- (void)LoginClicked{
//    YJAuthenticationViewController *vc = [[YJAuthenticationViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:NO];
    //    [self denglu];

}
- (void)denglu{
    NSString *url = [NSString stringWithFormat:@"%@/client/login",BASE_URL];
    if (phoneNumberTextField.text.length) {
        if (passWordAndCodeNumberTextField.text.length) {
            NSDictionary *dic = @{@"phone":phoneNumberTextField.text,
                                  @"password":passWordAndCodeNumberTextField.text,
                                  };
            [[DateSource  sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"code"]integerValue]==200){
                    //0 未注册 1未认证 2 已认证 3 认证申诉 4禁用 5 正在审核
                    NSuserSave([[result objectForKey:@"data"]objectForKey:@"token"], @"token");
                    NSuserSave([[result objectForKey:@"data"]objectForKey:@"name"], @"name");
                    NSuserSave([[result objectForKey:@"data"]objectForKey:@"userId"], @"userId");
                    NSuserSave([[result objectForKey:@"data"]objectForKey:@"type"], @"type");
                    NSuserSave([[result objectForKey:@"data"]objectForKey:@"status"], @"status");
                    //保存用户信息
                    NSLog(@"re = %@",result);
                    if ([[[result objectForKey:@"data"]objectForKey:@"status"]integerValue]==1) {
                        YJAuthenticationViewController *vc = [[YJAuthenticationViewController alloc]init];
                        [self.navigationController pushViewController:vc animated:NO];
                    }else if ([[[result objectForKey:@"data"]objectForKey:@"status"]integerValue]==5){
                        [self.navigationController dismissViewControllerAnimated:NO completion:^{
                            [self HideKeyBoardClick];
                        }];
                        [AnimationView showString:@"正在审核"];
                    }else if ([[[result objectForKey:@"data"]objectForKey:@"status"]integerValue]==2){
                        
                        
                        [self.navigationController dismissViewControllerAnimated:NO completion:^{
                            [self HideKeyBoardClick];
                            
                        }];
                    }else{
                        [AnimationView showString:@"请联系店主"];
                    }
                    
                    
                    //                [self.navigationController dismissViewControllerAnimated:NO completion:^{
                    //
                    //                }];
                }else{
                    NSString *ErrorMessage = [result objectForKey:@"errmsg"];
                    [AnimationView showString:ErrorMessage];
                }
            }];
        }else{
         [AnimationView showString:@"请填写密码"];
        }
        

    }else{
         [AnimationView showString:@"填写正确的手机号和密码"];
    }
}
- (void)zhuce{
    if (ClickBtn.selected) {
        NSString *url = [NSString stringWithFormat:@"%@/client/register",BASE_URL];
        if (phoneNumberTextField.text.length) {
            if (passWordAndCodeNumberTextField.text.length) {
                if (passWordNumberTextField.text.length) {
                    NSMutableDictionary *dic;
                    if (codeTextField.text.length) {
                        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumberTextField.text,@"phone",passWordAndCodeNumberTextField.text,@"code",passWordNumberTextField.text,@"password",codeTextField.text,@"picCode",nil];
                    }else{
                        dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNumberTextField.text,@"phone",passWordAndCodeNumberTextField.text,@"code",passWordNumberTextField.text,@"password",nil];
                    }
                    [[DateSource  sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
                        
                        if ([[result objectForKey:@"code"]integerValue]==200){
                            // [self showProgress:@"注册成功"];
                            NSuserSave([[result objectForKey:@"data"]objectForKey:@"token"], @"token");
                            NSuserSave([[result objectForKey:@"data"]objectForKey:@"name"], @"name");
                            NSuserSave([[result objectForKey:@"data"]objectForKey:@"userId"], @"userId");
                            NSuserSave([[result objectForKey:@"data"]objectForKey:@"type"], @"type");
                            
                            NSuserSave([[result objectForKey:@"data"]objectForKey:@"status"], @"status");
                            [AnimationView showString:@"注册成功！进行认证"];
                            YJAuthenticationViewController *vc = [[YJAuthenticationViewController alloc]init];
                            [self.navigationController pushViewController:vc animated:NO];
                        }else{
                            NSString *ErrorMessage = [result objectForKey:@"errmsg"];
                            [AnimationView showString:ErrorMessage];
                            
                        }
                    }];
                }else{
                    [AnimationView showString:@"填写密码"];
                }
            }else{
                [AnimationView showString:@"填写验证码"];
            }
            
            
        }else{
            [AnimationView showString:@"填写正确的手机号"];
        }
    }else{
         [AnimationView showString:@"填同意注册协议"];
    }
    
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
  
    if (loginBtn.isSelected) {
        [self denglu];
    }else{
        // [self showProgress:@"注册成功"];
       [self zhuce];
    }
//    if (loginBtn.selected) {
//        NSLog(@"login");
//    }else{
//         NSLog(@"regin");
//        YJAuthenticationViewController *vc = [[YJAuthenticationViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:NO];
//    }
}
-(int)checkIsHaveNumAndLetter:(NSString*)password{
    //数字条件
    
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    
    //符合数字条件的有几个字节
    
    NSUInteger tNumMatchCount = [tNumRegularExpression numberOfMatchesInString:password
                                 
                                                                       options:NSMatchingReportProgress
                                 
                                                                         range:NSMakeRange(0, password.length)];
    
    
    
    //英文字条件
    
    NSRegularExpression *tLetterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    
    //符合英文字条件的有几个字节
    
    NSUInteger tLetterMatchCount = [tLetterRegularExpression numberOfMatchesInString:password options:NSMatchingReportProgress range:NSMakeRange(0, password.length)];
    
    
    
    if (tNumMatchCount == password.length) {
        
        //全部符合数字，表示沒有英文
        
        return 1;
        
    } else if (tLetterMatchCount == password.length) {
        
        //全部符合英文，表示沒有数字
        
        return 2;
        
    } else if (tNumMatchCount + tLetterMatchCount == password.length) {
        
        //符合英文和符合数字条件的相加等于密码长度
        
        return 3;
        
    } else {
        
        return 4;
        
        //可能包含标点符号的情況，或是包含非英文的文字，这里再依照需求详细判断想呈现的错误
        
    }
}
//忘记密码
- (void)ForgetPassClick{
    YJForgetPassWordViewController *vc = [[YJForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
}

@end
