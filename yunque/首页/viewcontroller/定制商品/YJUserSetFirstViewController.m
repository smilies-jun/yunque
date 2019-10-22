//
//  YJUserSetFirstViewController.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetFirstViewController.h"
#import "CustomView.h"
#import "YJUserSetSecondViewController.h"
#import "YJShopSetDetailViewController.h"

@interface YJUserSetFirstViewController ()<UITextFieldDelegate>{
    UIImageView *typeImageView;
      CustomView *choseHeightView;
      CustomView *choseWidthiew;
    
      CustomView *choseDongHeightView;
      CustomView *choseDongWidthView;
    
      CustomView *choseQiangView;
      CustomView *choseMenView;
      UIScrollView *scrollView;
}

@end

@implementation YJUserSetFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品";
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self setUI];
}
- (void)setUI{
    scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:scrollView];
    typeImageView = [[UIImageView alloc]init];
    typeImageView.image = [UIImage imageNamed:@"导航1"];
    [scrollView addSubview:typeImageView];
    [typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(77);
    }];
    choseHeightView = [[CustomView alloc]init];
    choseHeightView.NameLabel.text = @"门扇高";
    choseHeightView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    choseMenView.NameTextField.delegate = self;
    [scrollView addSubview:choseHeightView];
    [choseHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->typeImageView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseWidthiew = [[CustomView alloc]init];
    choseWidthiew.NameTextField.delegate =self;
    choseWidthiew.NameLabel.text = @"门扇宽";
    choseWidthiew.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    [scrollView addSubview:choseWidthiew];
    [choseWidthiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseDongHeightView = [[CustomView alloc]init];
    choseDongHeightView.NameTextField.delegate =self;
    choseDongHeightView.NameLabel.text = @"门洞高";
    choseDongHeightView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    [scrollView addSubview:choseDongHeightView];
    [choseDongHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseWidthiew.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseDongWidthView = [[CustomView alloc]init];
    choseDongWidthView.NameTextField.delegate = self;
    choseDongWidthView.NameLabel.text = @"门洞宽";
    choseDongWidthView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    [scrollView addSubview:choseDongWidthView];
    [choseDongWidthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseQiangView = [[CustomView alloc]init];
    choseQiangView.NameLabel.text = @"墙体厚度";
    choseQiangView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;

    choseQiangView.NameTextField.delegate = self;
    [scrollView addSubview:choseQiangView];
    [choseQiangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongWidthView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenView = [[CustomView alloc]init];
    choseMenView.NameLabel.text = @"门版厚度";
    choseMenView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    choseMenView.NameTextField.delegate = self;
    [scrollView addSubview:choseMenView];
    [choseMenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseQiangView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
        make.top.mas_equalTo(self->choseMenView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)nextBtn{
    NSDictionary *mydic = @{@"doorLeafHeight":choseHeightView.NameTextField.text,
                            @"doorLeafWidth":choseWidthiew.NameTextField.text,
                            @"doorOpeningHeight":choseDongHeightView.NameTextField.text,
                            @"doorOpeningWidth":choseDongWidthView.NameTextField.text,
                            @"wallThickness":choseQiangView.NameTextField.text,
                            @"doorPanelThickness":choseMenView.NameTextField.text,
                            };
    YJUserSetSecondViewController *user = [[YJUserSetSecondViewController alloc]init];
    user.firstDic = _dic;
    user.secondDic = mydic;
    user.categoryId = _categoryId;
    [self.navigationController pushViewController:user animated:NO];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJShopSetDetailViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
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
