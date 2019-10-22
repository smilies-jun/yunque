//
//  YJYaoQingViewController.m
//  maike
//
//  Created by Apple on 2019/9/5.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJYaoQingViewController.h"

@interface YJYaoQingViewController ()<UITextFieldDelegate>{
    UITextField *phoneTextField;
}

@end

@implementation YJYaoQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"邀请注册";
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self setUI];
}
- (void)HotListBackClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)setUI{
    UIImageView *imageView =[[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"邀请注册"];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKey)];
    [imageView addGestureRecognizer:tap];
    
    imageView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    [self.view addSubview:imageView];
    
    phoneTextField = [[UITextField alloc]init];
    phoneTextField.layer.masksToBounds = YES;
    phoneTextField.layer.cornerRadius = 5.0f;
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.backgroundColor = [UIColor whiteColor];
    
    phoneTextField.placeholder = @"请输入被邀请手机号码";
    [imageView addSubview:phoneTextField];
    [phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iPhoneXAndXS) {
            make.bottom.mas_equalTo(imageView.mas_bottom).offset(-280);

        }else{
            make.bottom.mas_equalTo(imageView.mas_bottom).offset(-180);

        }
        make.centerX.mas_equalTo(imageView.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    UIButton *  sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"邀请" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =colorWithRGB(0.97, 0.78, 0.1);
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(LoginNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_left).offset(40);
        make.right.mas_equalTo(imageView.mas_right).offset(-40);
        make.top.mas_equalTo(self->phoneTextField.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)hideKey{
    [self HideKeyBoardClick];
}
-(void)LoginNextBtn{
    if (phoneTextField.text.length) {
        NSString *url = [NSString stringWithFormat:@"%@/client/invitedToJoinIn?phone=%@",BASE_URL,phoneTextField.text];
        
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
            //self->myArray = [result objectForKey:@"data"];
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                [AnimationView showString:@"邀请成功"];
            }else{
                [AnimationView showString:[result objectForKey:@"errmsg"]];

            }
        }];
    }else{
        [AnimationView showString:@"请输入电话号码"];
    }
   
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
