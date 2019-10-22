//
//  YJPayResultViewController.m
//  maike
//
//  Created by Apple on 2019/9/11.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPayResultViewController.h"

@interface YJPayResultViewController (){
    UIImageView *stateImageView;
    UILabel *sucessLabel;
    UIButton *showBtn;
    UIButton *popBtn;
    
    
}

@end

@implementation YJPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    
    self.TopTitleLabel.text = @"支付完成";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
   // [self reoadDate];
    [self initUI];
}
- (void)initUI{
    stateImageView  = [[UIImageView alloc]init];
    stateImageView.image = [UIImage imageNamed:@"成功"];
    [self.view addSubview:stateImageView];
    [stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(80);
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(86);
    }];
    sucessLabel = [[UILabel alloc]init];
    sucessLabel.text = @"支付成功";
    sucessLabel.font= [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:sucessLabel];
    [sucessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self->stateImageView.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UIButton * _SureOverBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_SureOverBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [_SureOverBtn addTarget:self action:@selector(PostClick) forControlEvents:UIControlEventTouchUpInside];
    [_SureOverBtn setTintColor:font_main_color];
    [_SureOverBtn.layer setMasksToBounds:YES];
    [_SureOverBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [_SureOverBtn.layer setBorderWidth:1.0];
    _SureOverBtn.layer.borderColor = font_main_color.CGColor;
    
    [self.view addSubview:_SureOverBtn];
    [_SureOverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(80);
        make.bottom.mas_equalTo(self->sucessLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
    }];
    UIButton * _PayMoneyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_PayMoneyBtn setTintColor:font_main_color];
    [_PayMoneyBtn addTarget:self action:@selector(BackClick) forControlEvents:UIControlEventTouchUpInside];

    [_PayMoneyBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [_PayMoneyBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [_PayMoneyBtn.layer setBorderWidth:1.0];
    _PayMoneyBtn.layer.borderColor = font_main_color.CGColor;
    [self.view addSubview:_PayMoneyBtn];
    [_PayMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-80);
        make.bottom.mas_equalTo(self->sucessLabel.mas_bottom).offset(60);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
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
- (void)BackClick{
    
     [self .navigationController popToRootViewControllerAnimated:NO];
}
- (void)PostClick{
    [self rdv_tabBarController].selectedIndex = 3;
     [self .navigationController popToRootViewControllerAnimated:NO];
}
- (void)ShopListBackClick{
    [self .navigationController popToRootViewControllerAnimated:NO];
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
