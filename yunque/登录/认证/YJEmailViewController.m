//
//  YJEmailViewController.m
//  maike
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJEmailViewController.h"
#import "CustomView.h"
#import "UIButton+CountDown.h"

@interface YJEmailViewController (){
    CustomView *zhuceCustomView;
    CustomView *codeView;
      int _second;
}

@end

@implementation YJEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"邮箱认证";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);

    [self.BackButton addTarget:self action:@selector(AuthenticationBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self InitUI];
}
- (void)AuthenticationBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)InitUI{
    zhuceCustomView = [[CustomView alloc]init];
    zhuceCustomView.NameLabel.text = @"注册邮箱";
    [self.view addSubview:zhuceCustomView];
    [zhuceCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    codeView = [[CustomView alloc]init];
    codeView.NameLabel.text = @"验证码";
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->zhuceCustomView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _GetCode = [[UIButton alloc] init];
    _GetCode.hidden = YES;
    // [_GetCode setTitle:@"获取" forState:UIControlStateNormal];
    [_GetCode fireWithTime:0 title:@"发送验证码" countDownTitle:@"秒" mainBGColor:[UIColor clearColor] countBGColor:font_main_color mainTextColor:font_main_color countTextColor:[UIColor whiteColor]];
    _GetCode.titleLabel.font = [UIFont systemFontOfSize:16];
    // [_GetCode setBackgroundColor:font_main_color];
    [_GetCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_GetCode addTarget:self action:@selector(senderInputSecurityCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_GetCode];
    
    [_GetCode mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(self->codeView.mas_top);
        make.right.mas_equalTo(self->codeView.mas_right);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(25);
    }];
}
#pragma mark 获取验证码
- (void)senderInputSecurityCodeBtnClicked

{
    
    NSString *phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMatch  = [phoneTest evaluateWithObject:codeView.NameTextField.text];
    if (!isMatch) {
        normal_alert(@"提示", @"请输入正确的手机号", @"确定");
        
    }else{
        
        //        _second = 90;
        //        _securityCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing) userInfo:nil repeats:YES];
        NSMutableDictionary * YWDDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:codeView.NameTextField.text ,@"phoneNumber",@"1",@"type",nil];
        //验证码获取陈功or失败
        [[DateSource sharedInstance]requestHomeWithParameters:YWDDic withUrl:@"" withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            
            if ([[result objectForKey:@"statusCode"]integerValue] == 201) {
                [self->_GetCode fireWithTime:60 title:@"获取" countDownTitle:@"秒" mainBGColor:colorWithRGB(0.95, 0.6, 0.11) countBGColor:colorWithRGB(0.95, 0.6, 0.11) mainTextColor:[UIColor whiteColor] countTextColor:[UIColor whiteColor]];
                normal_alert(@"提示", @"验证码已发送", @"确定");
            }else{
                NSString *ErrorMessage = [result objectForKey:@"message"];
                normal_alert(@"提示", ErrorMessage, @"确定");
                
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
