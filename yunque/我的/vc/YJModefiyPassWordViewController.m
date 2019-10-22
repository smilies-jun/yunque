//
//  YJModefiyPassWordViewController.m
//  maike
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJModefiyPassWordViewController.h"
#import "YJForgetPassWordViewController.h"

@interface YJModefiyPassWordViewController ()<UITextFieldDelegate>{
    UILabel *xiugaiLbel;
    UILabel *xiugaiDetailLabel;
    UILabel *oldPassLabel;
    UITextField *oldPassTextField;
    UILabel *newPassLabel;
    UITextField *newPassTextField;
    UILabel *SurePassLabel;
    UITextField *surePassTextField;

    UIButton *PassIconBtn;
    UIButton *newPassIconBtn;
    UIButton *surePassIconBtn;
}

@end

@implementation YJModefiyPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopTitleLabel.text = @"";
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    xiugaiLbel = [[UILabel alloc]init];
    xiugaiLbel.text = @"修改密码";
    xiugaiLbel.font = [UIFont systemFontOfSize:24];
    [self.view addSubview:xiugaiLbel];
    [xiugaiLbel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_bottom);
        make.width.mas_equalTo(126);
        make.height.mas_equalTo(33);
    }];
    xiugaiDetailLabel = [[UILabel alloc]init];
    xiugaiDetailLabel.text = @"密码为不少于8位e的字母、数字、字符的组合";
    xiugaiDetailLabel.font = [UIFont systemFontOfSize:12];
    xiugaiDetailLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self.view addSubview:xiugaiDetailLabel];
    [xiugaiDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->xiugaiLbel.mas_bottom);
        make.width.mas_equalTo(265);
        make.height.mas_equalTo(17);
    }];
    oldPassLabel = [[UILabel alloc]init];
    oldPassLabel.text = @"原密码";
    oldPassLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:oldPassLabel];
    [oldPassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->xiugaiDetailLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(126);
        make.height.mas_equalTo(33);
    }];
    oldPassTextField = [[UITextField alloc]init];
    oldPassTextField.placeholder = @"请输入账号当前密码";
    oldPassTextField.delegate = self;
    oldPassTextField.secureTextEntry = YES;
    oldPassTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入账号当前密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:oldPassTextField];
    [oldPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->oldPassLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(25);
    }];
   
    UIImageView *oldlineImageView = [[UIImageView alloc]init];
    oldlineImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:oldlineImageView];
    [oldlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->oldPassTextField.mas_left);
        make.top.mas_equalTo(self->oldPassTextField.mas_bottom);
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
        make.bottom.mas_equalTo(self->oldPassTextField.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    newPassLabel = [[UILabel alloc]init];
    newPassLabel.text = @"新密码";
    newPassLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:newPassLabel];
    [newPassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->oldPassLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(126);
        make.height.mas_equalTo(33);
    }];
    newPassTextField = [[UITextField alloc]init];
    newPassTextField.placeholder = @"请输入新的密码";
    newPassTextField.delegate = self;
     newPassTextField.secureTextEntry = YES;
    newPassTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入的新密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:newPassTextField];
    [newPassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->newPassLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(25);
    }];
    UIImageView *newlineImageView = [[UIImageView alloc]init];
    newlineImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:newlineImageView];
    [newlineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->newPassTextField.mas_left);
        make.top.mas_equalTo(self->newPassTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    newPassIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    newPassIconBtn.selected = YES;
    [newPassIconBtn addTarget:self action:@selector(newiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [newPassIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [newPassIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:newPassIconBtn];
    [newPassIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.bottom.mas_equalTo(self->newPassTextField.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    SurePassLabel = [[UILabel alloc]init];
    SurePassLabel.text = @"确认密码";
    SurePassLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:SurePassLabel];
    [SurePassLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->newPassLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(126);
        make.height.mas_equalTo(33);
    }];
    surePassTextField = [[UITextField alloc]init];
    surePassTextField.placeholder = @"请再次输入新的密码";
    surePassTextField.delegate = self;
    surePassTextField.secureTextEntry = YES;
    surePassTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请再次输入新的密码" attributes:@{NSForegroundColorAttributeName: colorWithRGB(0.71, 0.75, 0.72)}];
    [self.view addSubview:surePassTextField];
    [surePassTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self->SurePassLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(25);
    }];
    UIImageView *surelineImageView = [[UIImageView alloc]init];
    surelineImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:surelineImageView];
    [surelineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->surePassTextField.mas_left);
        make.top.mas_equalTo(self->surePassTextField.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH - 60);
        make.height.mas_equalTo(0.5);
    }];
    surePassIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    surePassIconBtn.selected = YES;
    [surePassIconBtn addTarget:self action:@selector(sureiceClick:) forControlEvents:UIControlEventTouchUpInside];
    [surePassIconBtn setImage:[UIImage imageNamed:@"密码不可见"] forState:UIControlStateSelected];
    [surePassIconBtn setImage:[UIImage imageNamed:@"密码可见"] forState:UIControlStateNormal];

    [self.view addSubview:surePassIconBtn];
    [surePassIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-30);
        make.bottom.mas_equalTo(self->surePassTextField.mas_bottom);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *  forgetLabel = [[UILabel alloc]init];
    forgetLabel.text = @"忘记密码";
    forgetLabel.font = [UIFont systemFontOfSize:14];
    forgetLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *forgetTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ForgetPassClick)];
    [forgetLabel addGestureRecognizer:forgetTap];
    forgetLabel.textAlignment = NSTextAlignmentRight;
    forgetLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self.view addSubview:forgetLabel];
    [forgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(surelineImageView.mas_right);
        make.top.mas_equalTo(surelineImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    UIButton *ComplayBtn = [[UIButton alloc]init];
    [ComplayBtn setTitle:@"完成" forState:UIControlStateNormal];
    ComplayBtn.layer.masksToBounds = YES;
    ComplayBtn.layer.cornerRadius = 5.0f;
    [ComplayBtn addTarget:self action:@selector(ComplayClicked) forControlEvents:UIControlEventTouchUpInside];
    [ComplayBtn setBackgroundColor:font_main_color];
    ComplayBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:ComplayBtn];
    [ComplayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(surelineImageView.mas_bottom).offset(100);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(40);
    }];
}
//忘记密码
- (void)ForgetPassClick{
    YJForgetPassWordViewController *vc = [[YJForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
    
}
- (void)iceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        oldPassTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        oldPassTextField.secureTextEntry = YES;
    }
}
- (void)sureiceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        surePassTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        surePassTextField.secureTextEntry = YES;
    }
}
- (void)newiceClick:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
        newPassTextField.secureTextEntry = NO;
    }else{
        btn.selected = YES;
        newPassTextField.secureTextEntry = YES;
    }
}
- (void)ComplayClicked{
    if ([surePassTextField.text isEqualToString:newPassTextField.text]) {
        if (surePassTextField.text.length) {
            NSString *tokenID = NSuserUse(@"token");
            NSString *url = [NSString stringWithFormat:@"%@/client/userResetPassword",BASE_URL];
            if (oldPassTextField.text.length) {
                NSDictionary *dic = @{@"newPasswordOne":newPassTextField.text,
                                      @"password":oldPassTextField.text,
                                       @"newPasswordTwo":surePassTextField.text,
                                      };
                [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                    if ([[result objectForKey:@"code"]integerValue] == 200) {
                        [AnimationView showString:@"密码修改成功"];
                        NSuserSave([[result objectForKey:@"data"]objectForKey:@"token"], @"token");
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }else{
                        [AnimationView showString:@"删除失败"];
                    }
                    
                    
                }];
            }else{
                 [AnimationView showString:@"清输入原密码"];
            }
           
        }else{
            [AnimationView showString:@"请输入密码"];
        }
    }else{
        [AnimationView showString:@"输入密码不一致"];

    }
}
-(void)ShopListBackClick{
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
