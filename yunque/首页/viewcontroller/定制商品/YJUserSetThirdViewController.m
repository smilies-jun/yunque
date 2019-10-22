//
//  YJUserSetThirdViewController.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetThirdViewController.h"
#import "CustomView.h"
#import "YJUserSetSecondViewController.h"
#import "YJChoseBtnView.h"
#import "YJUserSetFourViewController.h"

@interface YJUserSetThirdViewController ()<UITextFieldDelegate>{
    UIImageView *typeImageView;
    CustomView *choseHeightView;
    CustomView *choseWidthiew;
    
    CustomView *choseDongHeightView;
    CustomView *choseDongWidthView;

    YJChoseBtnView *ChuangView;
    YJChoseBtnView *MenView;
    YJChoseBtnView *MaoYanView;
    YJChoseBtnView *XiaDanView;
    YJChoseBtnView *LianView;
    CustomView *BaShouView;
    UIButton *selectedBtn;
    UIScrollView *scrollView;
}


@end

@implementation YJUserSetThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self setUI];
}
- (void)setUI{
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:scrollView];
    
    typeImageView = [[UIImageView alloc]init];
    typeImageView.image = [UIImage imageNamed:@"导航3"];
    [scrollView addSubview:typeImageView];
    [typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(77);
    }];
    choseHeightView = [[CustomView alloc]init];
    choseHeightView.NameLabel.text = @"骨架";
    choseHeightView.NameTextField.delegate = self;

    [scrollView addSubview:choseHeightView];
    [choseHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->typeImageView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseWidthiew = [[CustomView alloc]init];
    choseWidthiew.NameLabel.text = @"填充物";
    choseWidthiew.NameTextField.delegate = self;

    [scrollView addSubview:choseWidthiew];
    [choseWidthiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    ChuangView = [[YJChoseBtnView alloc]init];
    ChuangView.NameLabel.text = @"气窗";
    
    ChuangView.ChooseFirstbutton.tag = 101;
    ChuangView.ChooseFirstbutton.selected = YES;
    ChuangView.ChooseSecondbutton.tag =102;
    ChuangView.ChooseSecondbutton.selected = NO;
    ChuangView.ChooseFirstLabel.text = @"开放";
    ChuangView.ChooseSecondLabel.text = @"封闭";
    [ChuangView.ChooseFirstbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [ChuangView.ChooseSecondbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:ChuangView];
    [ChuangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseWidthiew.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    MenView = [[YJChoseBtnView alloc]init];
    MenView.NameLabel.text = @"门铃";
    MenView.ChooseFirstLabel.text = @"有";
    MenView.ChooseSecondLabel.text = @"无";
    MenView.ChooseFirstbutton.selected = YES;
    MenView.ChooseFirstbutton.tag =201;
    MenView.ChooseSecondbutton.selected = NO;
    MenView.ChooseSecondbutton.tag =202;
    [MenView.ChooseFirstbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [MenView.ChooseSecondbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:MenView];
    [MenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->ChuangView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    MaoYanView = [[YJChoseBtnView alloc]init];
    MaoYanView.NameLabel.text = @"猫眼";
    MaoYanView.ChooseFirstLabel.text = @"有";
    MaoYanView.ChooseSecondLabel.text = @"无";
    MaoYanView.ChooseFirstbutton.selected = YES;
    MaoYanView.ChooseFirstbutton.tag =301;
    MaoYanView.ChooseSecondbutton.selected = NO;
    MaoYanView.ChooseSecondbutton.tag =302;
    [MaoYanView.ChooseFirstbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [MaoYanView.ChooseSecondbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:MaoYanView];
    [MaoYanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->MenView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    XiaDanView = [[YJChoseBtnView alloc]init];
    XiaDanView.NameLabel.text = @"下档";
    XiaDanView.ChooseFirstLabel.text = @"有";
    XiaDanView.ChooseSecondLabel.text = @"无";
    XiaDanView.ChooseFirstbutton.selected = YES;
    XiaDanView.ChooseFirstbutton.tag =401;
    XiaDanView.ChooseSecondbutton.selected = NO;
    XiaDanView.ChooseSecondbutton.tag =402;
    [XiaDanView.ChooseFirstbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [XiaDanView.ChooseSecondbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:XiaDanView];
    [XiaDanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->MaoYanView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    LianView = [[YJChoseBtnView alloc]init];
    LianView.NameLabel.text = @"铰链";
    LianView.ChooseFirstLabel.text = @"明";
    LianView.ChooseSecondLabel.text = @"暗";
    LianView.ChooseFirstbutton.selected = YES;
    LianView.ChooseFirstbutton.tag =501;
    LianView.ChooseSecondbutton.selected = NO;
    LianView.ChooseSecondbutton.tag =502;
    [LianView.ChooseFirstbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [LianView.ChooseSecondbutton    addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:LianView];
    [LianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->XiaDanView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseDongHeightView = [[CustomView alloc]init];
    choseDongHeightView.NameLabel.text = @"门锁";
    choseDongHeightView.NameTextField.delegate = self;

    choseHeightView.NameTextField.placeholder = @"请填写需求，选填";
    [scrollView addSubview:choseDongHeightView];
    [choseDongHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->LianView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseDongWidthView = [[CustomView alloc]init];
    choseDongWidthView.NameTextField.placeholder = @"请填写需求，选填";
    choseDongWidthView.NameLabel.text = @"拉手";
    choseDongWidthView.NameTextField.delegate = self;

    [scrollView addSubview:choseDongWidthView];
    [choseDongWidthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    BaShouView = [[CustomView alloc]init];
    BaShouView.NameTextField.placeholder = @"请填写需求，选填";
    BaShouView.NameLabel.text = @"把手";
    BaShouView.NameTextField.delegate = self;

    [scrollView addSubview:BaShouView];
    [BaShouView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongWidthView.mas_bottom).offset(1);
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
        make.top.mas_equalTo(self->BaShouView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}
- (void)nextBtn{
    int first;int second;int third;int four;int five;
     UIButton *myBtn1 = (UIButton *)[self.view viewWithTag:101];
     UIButton *myBtn2 = (UIButton *)[self.view viewWithTag:201];
     UIButton *myBtn3 = (UIButton *)[self.view viewWithTag:301];
     UIButton *myBtn4 = (UIButton *)[self.view viewWithTag:401];
     UIButton *myBtn5 = (UIButton *)[self.view viewWithTag:501];
    if (myBtn1.selected) {   
        first =1;
    }else{
        first =0;
    }
    if (myBtn2.selected) {
        second =1;
    }else{
        second =0;
    }
    if (myBtn3.selected) {
        third =1;
    }else{
        third =0;
    }
    if (myBtn4.selected) {
        four =1;
    }else{
        four =0;
    }
    if (myBtn5.selected) {
        five =1;
    }else{
        five =0;
    }
    NSDictionary *mydic = @{@"skeleton":choseHeightView.NameTextField.text,
                            @"filler":choseWidthiew.NameTextField.text,
                            @"transom":[NSNumber numberWithInteger:first],
                            @"doorbell":[NSNumber numberWithInteger:second],
                            @"cateye":[NSNumber numberWithInteger:third],
                             @"downshift":[NSNumber numberWithInteger:four],
                             @"hinge":[NSNumber numberWithInteger:five],
                             @"doorLock":choseDongHeightView.NameTextField.text,
                             @"handle":choseDongWidthView.NameTextField.text,
                            @"knob":BaShouView.NameTextField.text
                            };
    YJUserSetFourViewController *user = [[YJUserSetFourViewController alloc]init];
    user.firstDic = _firstDic;
    user.secondDic = _secondDic;
    user.thirdDic = _thirdDic;
    user.fourDic = mydic;
    user.categoryId = _categoryId;
    [self.navigationController pushViewController:user animated:NO];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserSetSecondViewController class]]) {
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
- (void)BtnClick:(UIButton *)Btn{
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
