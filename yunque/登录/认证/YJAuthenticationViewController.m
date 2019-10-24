//
//  YJAuthenticationViewController.m
//  maike
//
//  Created by Apple on 2019/7/22.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAuthenticationViewController.h"
#import "CustomView.h"
#import "CustomChooseView.h"
#import "YJAutherTableViewCell.h"
#import "TFPopup.h"
#import "YJAuthenticationReasonViewController.h"
#import "HDSelecterViewController.h"
#import "YJMenDianViewController.h"
#import "YJLoginAndReginViewController.h"
#import "YJProViewController.h"


@interface YJAuthenticationViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    CustomChooseView *choseShopTypeView;
    CustomView *choseShopNameView;
    CustomView *choseShopSortShopView;
    CustomChooseView *choseShopAdressView;
    CustomChooseView *ShopTypeView;
    
    UIButton *userBtn;
    UIButton *shopBtn;
    
    CustomView *bankCardView;
    CustomView *bankNameView;
    CustomView *bankAdressView;
    CustomChooseView *PayTypeView;
    UIButton *sureBtn;
    
    CustomChooseView *ShopPayTypeView;
    UIButton *ShopsureBtn;
    
    UITableView *choseTableview;
    
    UIView *choseView;//弹出视图
    UIScrollView *backScrollview;
    NSInteger indexRow;
    NSArray *myArray;
    NSArray *payArray;
    NSArray *ShopTypeArray;
    
    UIButton *ClickPersonBtn;
    UILabel *personNameLabel;
    UILabel *nameLabel;
    UIButton *ClickQiYeBtn;
    NSInteger sectionRow;
    NSInteger brandIds;
    NSInteger otherPayType;
    NSInteger otherQiYePayType;
    NSDictionary *mydic;
    UILabel *shenSuLabel;
    CustomView *moneyTextField;
    CustomView *PersonmoneyTextField;
    
    NSString    *shopId;

    
}
@property(nonatomic,strong)NSString *defualtProvince;
@property(nonatomic,strong)NSString *defualtCity;
@property(nonatomic,strong)NSString *defualtDistricts;
@end

@implementation YJAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"门店入驻";
    [self.BackButton addTarget:self action:@selector(AuthenticationBackClick) forControlEvents:UIControlEventTouchUpInside];
    indexRow = 0;
    otherPayType = 0;
    sectionRow = 0;
    otherQiYePayType = 0;
    myArray = [[NSArray alloc]init];
    payArray = [[NSArray alloc]initWithObjects:@"银行卡",@"微信",@"支付宝", nil];
    ShopTypeArray = [[NSArray alloc]init];
    mydic = [[NSDictionary alloc]init];
    [self reoadDate];
    [self InitUI];
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");

    NSString *Typeurl = [NSString stringWithFormat:@"%@/shop/typeJoin",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:Typeurl withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->ShopTypeArray  = [result objectForKey:@"data"];
    }];
    NSString *url = [NSString stringWithFormat:@"%@/area/list",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->myArray = [result objectForKey:@"data"];
        
    }];
    NSString *brandIdsurl = [NSString stringWithFormat:@"%@/brand/brands",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:brandIdsurl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        
        NSString *brandStr = [[[result objectForKey:@"data"]objectForKey:@"content"]objectAtIndex:0][@"brandId"];
        self->brandIds = [brandStr integerValue];
    }];
}
- (void)AuthenticationBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJMenDianViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJLoginAndReginViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    backScrollview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
//    backScrollview.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+300);
//}
- (UIView *)getChoseView:(NSString *)str{
    UIView *TypeView= [[UIView alloc]init];
    TypeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    TypeView.backgroundColor = [UIColor whiteColor];
    UILabel *TitleLabel = [[UILabel alloc]init];
    
    TitleLabel.text = @"选择结算账户";
    TitleLabel.textAlignment = NSTextAlignmentCenter;
    [TypeView addSubview:TitleLabel];
    [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TypeView.mas_centerX);
        make.top.mas_equalTo(TypeView.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
   // cancelBtn.backgroundColor = [UIColor redColor];
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [TypeView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(TypeView.mas_right).offset(-20);
        make.top.mas_equalTo(TypeView.mas_top).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    choseTableview  = [[UITableView alloc]init];
    choseTableview.dataSource = self;
    choseTableview.delegate = self;
    [TypeView addSubview:choseTableview];
    [choseTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TypeView.mas_left);
        make.top.mas_equalTo(TitleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(180);
    }];
    UILabel *bottomLabel = [[UILabel alloc]init];
    bottomLabel.text = @"使用微信或支付宝结算需要完成一笔0.99支付认证。";
    bottomLabel.font = [UIFont systemFontOfSize:12];
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [TypeView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(TypeView.mas_centerX);
        make.top.mas_equalTo(self->choseTableview.mas_bottom).offset(2);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(30);
    }];
    
    if ([str integerValue] == 1) {
        choseTableview.tag = 100;
          TitleLabel.text = @"选择入驻类型";
        bottomLabel.hidden = YES;;
    }else{
        choseTableview.tag = 101;
          TitleLabel.text = @"选择结算账户";
         bottomLabel.text = @"使用微信或支付宝结算需要完成一笔0.99支付认证。";
    }
    return TypeView;
}


- (void)InitUI{
    backScrollview = [[UIScrollView alloc]init];
    backScrollview.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    backScrollview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64);
    backScrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT+300);
    [self.view addSubview:backScrollview];
    
    choseShopTypeView = [[CustomChooseView alloc]init];
    choseShopTypeView.ChooseLabel.hidden = YES;
    choseShopTypeView.NameLabel.text = @"门店类型";
    [backScrollview addSubview:choseShopTypeView];
    [choseShopTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->backScrollview.mas_top).offset(2);
        make.height.mas_equalTo(60);
    }];
    userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    userBtn.tag = 101;
    userBtn.selected = YES;
    [userBtn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
    [userBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [userBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [choseShopTypeView addSubview:userBtn];
    [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->choseShopTypeView.NameLabel.mas_right).offset(20);
        make.top.mas_equalTo(self->choseShopTypeView.mas_top).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    UILabel *userLabe = [[UILabel alloc]init];
    userLabe.text = @"个人";
    [choseShopTypeView addSubview:userLabe];
    [userLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->userBtn.mas_right).offset(5);
        make.top.mas_equalTo(self->choseShopTypeView.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shopBtn.tag = 102;
    [shopBtn addTarget:self action:@selector(typeClick:) forControlEvents:UIControlEventTouchUpInside];
    [shopBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [shopBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [choseShopTypeView addSubview:shopBtn];
    [shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userLabe.mas_right).offset(60);
        make.top.mas_equalTo(self->choseShopTypeView.mas_top).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    UILabel *shopLabe = [[UILabel alloc]init];
    shopLabe.text = @"商户";
    [choseShopTypeView addSubview:shopLabe];
    [shopLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->shopBtn.mas_right).offset(5);
        make.top.mas_equalTo(self->choseShopTypeView.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    UILabel *jiben = [[UILabel alloc]init];
    jiben.text = @"基本信息";
    jiben.font = [UIFont systemFontOfSize:12];
    [backScrollview addSubview:jiben];
    [jiben mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopTypeView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    choseShopNameView = [[CustomView alloc]init];
    choseShopNameView.NameLabel.text = @"门店全称";
    choseShopNameView.NameTextField.delegate = self;
    choseShopNameView.NameTextField.placeholder = @"请输入门店全称";
    [backScrollview addSubview:choseShopNameView];
    [choseShopNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopTypeView.mas_bottom).offset(60);
        make.height.mas_equalTo(60);
    }];
    shenSuLabel = [[UILabel alloc]init];
    shenSuLabel.text= @"去申诉";
    shenSuLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shensuClick)];
    [shenSuLabel addGestureRecognizer:tap];
    shenSuLabel.font = [UIFont systemFontOfSize:14];
    shenSuLabel.textColor = font_main_color;
    shenSuLabel.hidden = YES;
    [choseShopNameView addSubview:shenSuLabel];
    [shenSuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->choseShopNameView.mas_right).offset(-20);
        make.bottom.mas_equalTo(self->choseShopNameView.mas_bottom).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    choseShopSortShopView = [[CustomView alloc]init];
     choseShopSortShopView.NameTextField.delegate = self;
    choseShopSortShopView.NameLabel.text = @"门店简称";
    choseShopSortShopView.NameTextField.placeholder = @"请输入门店简称";

    [backScrollview addSubview:choseShopSortShopView];
    [choseShopSortShopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopNameView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
   
    ShopTypeView = [[CustomChooseView alloc]init];
    ShopTypeView.NameLabel.text = @"入驻类型";
    ShopTypeView.ChooseLabel.text = @"请选择";
    ShopTypeView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *choseTypeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseShopType)];
    [ShopTypeView addGestureRecognizer:choseTypeTap];
    [backScrollview addSubview:ShopTypeView];
    [ShopTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopSortShopView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    choseShopAdressView = [[CustomChooseView alloc]init];
    choseShopAdressView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *choseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseAdressClick)];
    [choseShopAdressView addGestureRecognizer:choseTap];
    choseShopAdressView.NameLabel.text = @"入驻区域";
    choseShopAdressView.ChooseLabel.text = @"请选择入驻区域";
    [backScrollview addSubview:choseShopAdressView];
    [choseShopAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->ShopTypeView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    UILabel *zhanghao = [[UILabel alloc]init];
    zhanghao.text = @"账号信息";
    zhanghao.font = [UIFont systemFontOfSize:12];
    [backScrollview addSubview:zhanghao];
    [zhanghao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopAdressView.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    bankCardView = [[CustomView alloc]init];
    bankCardView.NameLabel.text = @"真实姓名";
    bankCardView.NameTextField.placeholder = @"请填写真实姓名";
    bankCardView.NameTextField.delegate = self;
    [backScrollview addSubview:bankCardView];
    [bankCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopAdressView.mas_bottom).offset(60);
        make.height.mas_equalTo(60);
    }];
    bankNameView = [[CustomView alloc]init];
    bankNameView.NameLabel.text = @"身份证号";
    bankNameView.NameTextField.placeholder = @"请填写身份证号";

    bankNameView.NameTextField.delegate = self;
    [backScrollview addSubview:bankNameView];
    [bankNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->bankCardView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    bankAdressView = [[CustomView alloc]init];
    bankAdressView.NameLabel.text = @"开户行";
     bankAdressView.NameTextField.delegate = self;
    bankAdressView.NameTextField.placeholder = @"请输入开户行";
    [backScrollview addSubview:bankAdressView];
    [bankAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->bankNameView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    
    PayTypeView = [[CustomChooseView alloc]init];
    PayTypeView.NameLabel.text = @"结算账户";
    PayTypeView.ChooseLabel.text = @"选择结算方式";
    PayTypeView.ChooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *choseType = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseType)];
    [PayTypeView.ChooseLabel addGestureRecognizer:choseType];
    [backScrollview addSubview:PayTypeView];
    [PayTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->bankNameView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    PersonmoneyTextField = [[CustomView alloc]init];
    PersonmoneyTextField.NameLabel.text = @"";
    PersonmoneyTextField.NameTextField.delegate = self;
     PersonmoneyTextField.NameTextField.placeholder = @"请输入银行卡/微信/支付宝账号";
    PersonmoneyTextField.backgroundColor = [UIColor whiteColor];
    PersonmoneyTextField.hidden = NO;
    [backScrollview addSubview:PersonmoneyTextField];
    [PersonmoneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->PayTypeView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(LoginNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [backScrollview   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->PersonmoneyTextField.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    ClickPersonBtn = [[UIButton alloc]init];
    [ClickPersonBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickPersonBtn.selected = YES;
    [ClickPersonBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickPersonBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollview addSubview:ClickPersonBtn];
    [ClickPersonBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.bottom.mas_equalTo(self->sureBtn.mas_top).offset(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    personNameLabel =[[UILabel alloc]init];
    NSMutableAttributedString *PersonConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange perconectRange = {4,4};
    [PersonConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:perconectRange];
    personNameLabel.attributedText = PersonConnectStr;
    personNameLabel.userInteractionEnabled = YES;
    personNameLabel.font = [UIFont systemFontOfSize:12];
    UITapGestureRecognizer *pergesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesClick)];
    [personNameLabel addGestureRecognizer:pergesTap];
    [backScrollview addSubview:personNameLabel];
    [personNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->ClickPersonBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(self->ClickPersonBtn.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    ShopPayTypeView = [[CustomChooseView alloc]init];
    ShopPayTypeView.NameLabel.text = @"结算账户";
    ShopPayTypeView.ChooseLabel.text = @"选择结算方式";
    ShopPayTypeView.hidden = YES;
    ShopPayTypeView.ChooseLabel.userInteractionEnabled = YES;
    ShopPayTypeView.tag = 100;
    UITapGestureRecognizer *shopchoseType = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseType
                                                                                                                )];
    [ShopPayTypeView.ChooseLabel addGestureRecognizer:shopchoseType];
    [backScrollview addSubview:ShopPayTypeView];
    [ShopPayTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->bankAdressView.mas_bottom).offset(2);
        make.height.mas_equalTo(60);
    }];
    
    moneyTextField = [[CustomView alloc]init];
    moneyTextField.NameLabel.text = @"";
    moneyTextField.NameTextField.placeholder = @"请输入银行卡/微信/支付宝账号";
    moneyTextField.hidden = YES;
    moneyTextField.NameTextField.delegate = self;
    [backScrollview addSubview:moneyTextField];
    [moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->ShopPayTypeView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    
    
    
    ShopsureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ShopsureBtn setTitle:@"提交" forState:UIControlStateNormal];
    ShopsureBtn.layer.masksToBounds = YES;
    ShopsureBtn.hidden = YES;
    ShopsureBtn.layer.cornerRadius = 5.0f;
    ShopsureBtn.backgroundColor =font_main_color;
    [ShopsureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ShopsureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [ShopsureBtn addTarget:self action:@selector(LoginShopNextBtn) forControlEvents:UIControlEventTouchUpInside];
    [backScrollview   addSubview:ShopsureBtn];
    [ShopsureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->moneyTextField.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    ClickQiYeBtn = [[UIButton alloc]init];
    [ClickQiYeBtn setBackgroundImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    ClickQiYeBtn.selected = YES;
    ClickQiYeBtn.hidden = YES;
    [ClickQiYeBtn setBackgroundImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [ClickQiYeBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    [backScrollview addSubview:ClickQiYeBtn];
    [ClickQiYeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.bottom.mas_equalTo(self->ShopsureBtn.mas_top).offset(-10);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    nameLabel =[[UILabel alloc]init];
    NSMutableAttributedString *ConnectStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"我同意《服务协议》"]];
    NSRange conectRange = {4,4};
    [ConnectStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:conectRange];
    nameLabel.attributedText = ConnectStr;
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.userInteractionEnabled = YES;
    nameLabel.hidden = YES;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesClick)];
    [nameLabel addGestureRecognizer:gesTap];
    [backScrollview addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->ClickQiYeBtn.mas_right).offset(10);
        make.centerY.mas_equalTo(self->ClickQiYeBtn.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}
- (void)gesClick{
    //协议
    YJProViewController *vc = [[YJProViewController alloc]init];
    vc.WebStr = @"http://39.100.129.115:3000/franchiseagreement.htm";
    vc.type = @"1";
    [self.navigationController pushViewController:vc animated:NO];
    
}
- (void)clicked:(UIButton *)btn{
    if (btn.selected) {
        btn.selected = NO;
    }else{
        btn.selected = YES;
    }
}
- (void)choseAdressClick{
    HDSelecterViewController *vc = [[HDSelecterViewController alloc]initWithDefualtProvince:self.defualtProvince city:self.defualtCity districts:self.defualtDistricts];
    //NSLog(@"mya=== %@",myArray);
    vc.MyArray = self->myArray;
    
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
//        weakSelf.defualtDistricts = districts;
        self->choseShopAdressView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,districts];
        NSLog(@"%@,%@,%@",province,city,districts);
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
    [self HideKeyBoardClick];
    [self presentViewController:vc animated:true completion:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
//提交
- (void)LoginNextBtn{
    mydic = nil;

    NSString *tokenID = NSuserUse(@"token");    
    if (bankCardView.NameTextField.text.length) {
        if (bankNameView.NameTextField.text.length) {
            if (choseShopNameView.NameTextField.text.length) {
                if (choseShopSortShopView.NameTextField.text.length) {
                    if (_defualtProvince.length) {
                        if (sectionRow>0) {
                            if (otherPayType > 0) {
                                NSDictionary *dic = @{@"agreeAgreement":[NSNumber numberWithInteger:1],
                                                      @"realName":bankCardView.NameTextField.text,
                                                      @"identityNumber":[NSNumber numberWithInteger:[bankNameView.NameTextField.text integerValue]],
                                                      @"shopName":choseShopNameView.NameTextField.text,
                                                      @"shopShortName":choseShopSortShopView.NameTextField.text,
                                                      @"province":_defualtProvince,
                                                      @"city":_defualtCity,
                                                       @"othersettlementAccount":PersonmoneyTextField.NameTextField.text,
                                                      @"otherSettlementAccountType":[NSNumber numberWithInteger:otherPayType-100],
                                                      @"typeJoinId":[NSNumber numberWithInteger:sectionRow],
                                                      @"brandIds":[NSNumber numberWithInteger:brandIds]};
                                
                                
                                
                                NSString *url = [NSString stringWithFormat:@"%@/shop/shopPersonal",BASE_URL];
                                [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                                    if ([[result objectForKey:@"code"]integerValue] == 200) {
                                        NSuserSave(@"5", @"status");
                                        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
                                    }else if ([[result objectForKey:@"code"]integerValue] == 50956){
                                        self->shenSuLabel.hidden = NO;
                                        self->mydic = dic;
                                        self->shopId = [[result objectForKey:@"data"]objectForKey:@"shopId"];
                                        [AnimationView showString:@"店铺名称已存在，请去申诉"];
                                    }else{
                                         [AnimationView showString:[result objectForKey:@"errmsg"]];
                                    }
                                }];
                            }else{
                                 [AnimationView showString:@"请选择结算方式"];
                            }
                            
                        }else{
                             [AnimationView showString:@"请选择加盟类型"];
                        }
                    }else{
                         [AnimationView showString:@"请选择地址"];
                    }
                }else{
                     [AnimationView showString:@"店铺简称未填写"];
                }
            }else{
                 [AnimationView showString:@"店铺名称未填写"];
            }
        }else{
             [AnimationView showString:@"身份证号未填写"];
        }
    }else{
         [AnimationView showString:@"真实姓名未填写"];
    }
    
        

    


}
- (void)shensuClick{
    YJAuthenticationReasonViewController *vc  = [[YJAuthenticationReasonViewController alloc]init];
    
    vc.dic = mydic;
    vc.shopId = shopId;
    if (userBtn.selected) {
        vc.type= @"1";//个人
    }else{
        vc.type= @"2";//店铺
    }
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)LoginShopNextBtn{
    mydic = nil;
    NSString *tokenID = NSuserUse(@"token");
    if (bankCardView.NameTextField.text.length) {
        if (bankNameView.NameTextField.text.length) {
            if (choseShopNameView.NameTextField.text.length) {
                if (choseShopSortShopView.NameTextField.text.length) {
                    if (_defualtProvince.length) {
                        if (sectionRow>0) {
                            if (bankAdressView.NameTextField.text.length) {
                                if (otherQiYePayType >0) {
                                    NSDictionary *dic = @{@"agreeAgreement":[NSNumber numberWithInteger:1],
                                                          @"bankAccount":bankCardView.NameTextField.text,
                                                          @"bankNumber":bankNameView.NameTextField.text,
                                                          @"shopName":choseShopNameView.NameTextField.text,
                                                          @"shopShortName":choseShopSortShopView.NameTextField.text,
                                                          @"province":_defualtProvince,
                                                          @"city":_defualtCity,
                                                          @"bank":bankAdressView.NameTextField.text,
                                                          @"othersettlementAccount":moneyTextField.NameTextField.text,
                                                          @"otherSettlementAccountType":[NSNumber numberWithInteger:otherQiYePayType-100],
                                                          @"typeJoinId":[NSNumber numberWithInteger:sectionRow],
                                                          @"brandIds":[NSNumber numberWithInteger:brandIds]};
                                    
                                    
                                    
                                    NSString *url = [NSString stringWithFormat:@"%@/shop/shopfirm",BASE_URL];
                                    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                                        if ([[result objectForKey:@"code"]integerValue] == 200) {
                                              NSuserSave(@"5", @"status");
                                            [self.navigationController dismissViewControllerAnimated:NO completion:nil];
                                        }else if ([[result objectForKey:@"code"]integerValue] == 50956){
                                            self->shenSuLabel.hidden = NO;
                                            self->mydic = dic;
                                            self->shopId = [[result objectForKey:@"data"]objectForKey:@"shopId"];
                                            [AnimationView showString:@"店铺名称已存在，请去申诉"];
                                        }
                                        else{
                                            [AnimationView showString:[result objectForKey:@"errmsg"]];
                                        }
                                    }];
                                }else{
                                    [AnimationView showString:@"请选择结算方式"];
                                }
                               
                            }else{
                                [AnimationView showString:@"请输入开户行"];
                            }
                           
                        }else{
                            [AnimationView showString:@"请选择入驻类型"];
                        }
                    }else{
                        [AnimationView showString:@"请选择地址"];
                    }
                }else{
                    [AnimationView showString:@"店铺简称未填写"];
                }
            }else{
                [AnimationView showString:@"店铺名称未填写"];
            }
        }else{
            [AnimationView showString:@"账号未填写"];
        }
    }else{
        [AnimationView showString:@"账户未填写"];
    }
}

- (void)typeClick:(UIButton *)btn{
    NSInteger j = btn.tag/100;
    for (int i =1; i <3 ; i++) {
        if (btn.tag == 100*j +i) {
            btn.selected = YES;
            continue;
        }
        UIButton *myBtn = (UIButton *)[self.view viewWithTag:i+100*j];
        myBtn.selected = NO;
       
        if (btn.tag == 101) {
            bankAdressView.hidden = YES;
            PayTypeView.hidden = NO;
            sureBtn.hidden = NO;
            ShopPayTypeView.hidden = YES;
            ShopsureBtn.hidden = YES;
            bankCardView.NameLabel.text = @"真实姓名";
            bankNameView.NameLabel.text = @"身份证号";
            bankCardView.NameTextField.text = @"";
            bankNameView.NameTextField.text = @"";
            
            bankCardView.NameTextField.placeholder = @"请输入真实姓名";
            bankNameView.NameTextField.placeholder = @"请输入身份证号";
            
            
            
            
            ClickQiYeBtn.hidden = YES;
            nameLabel.hidden= YES;
            ClickPersonBtn.hidden = NO;
            personNameLabel.hidden = NO;
            moneyTextField.hidden = YES;
            PersonmoneyTextField.hidden = NO;
           
        }else if(btn.tag == 102){
            PayTypeView.hidden = YES;
            sureBtn.hidden = YES;
            ShopPayTypeView.hidden = NO;
            ShopsureBtn.hidden = NO;
            bankCardView.NameLabel.text = @"账号";
            bankNameView.NameLabel.text = @"持卡人";
            bankCardView.NameTextField.text = @"";
            bankNameView.NameTextField.text = @"";
            bankCardView.NameTextField.placeholder = @"请输入账号";
            bankNameView.NameTextField.placeholder = @"请输入持卡人";
            
            
            
            bankAdressView.hidden = NO;
            ClickQiYeBtn.hidden = NO;
            nameLabel.hidden= NO;
            ClickPersonBtn.hidden = YES;
            personNameLabel.hidden = YES;
            moneyTextField.hidden = NO;
            PersonmoneyTextField.hidden = YES;
        }
       
}
}
//入驻类型选择
- (void)choseShopType{
    [self HideKeyBoardClick];
    TFPopupParam *param = [TFPopupParam new];
    param.disuseBackgroundTouchHide = NO;
    param.popupSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);//设置弹框的尺寸
    param.offset = CGPointZero;//在计算好的位置上偏移
    choseView = [self getChoseView:@"1"];
    [choseView tf_showSlide:self.view direction:PopupDirectionBottom popupParam:param];
}
//弹出视图账户
- (void)choseType{
    [self HideKeyBoardClick];
    TFPopupParam *param = [TFPopupParam new];
    param.disuseBackgroundTouchHide = NO;
    param.popupSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);//设置弹框的尺寸
    param.offset = CGPointZero;//在计算好的位置上偏移
    choseView = [self getChoseView:@"2"];
    [choseView tf_showSlide:self.view direction:PopupDirectionBottom popupParam:param];
}
- (void)cancelClick{
     [choseView tf_hide];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return ShopTypeArray.count;
    }
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
  
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"yjAutheProidentifier";
    
    YJAutherTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJAutherTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    if (indexPath.row == indexRow) {
        cell.AutherButton.selected = YES;
    }else{
        cell.AutherButton.selected = NO;
    }
    
    if (tableView.tag ==  101) {
        cell.AutherTitleLabel.text = [payArray objectAtIndex:indexPath.row];
    }else{
        cell.AutherTitleLabel.text = [ShopTypeArray objectAtIndex:indexPath.row][@"name"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexRow = indexPath.row;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    
    if (tableView.tag ==  101) {
        if (ClickQiYeBtn.hidden) {
             otherPayType = indexPath.row + 100;
           
        }else{
           otherQiYePayType = indexPath.row + 100;
           
        }
        PayTypeView.ChooseLabel.text = [payArray objectAtIndex:indexPath.row];

        ShopPayTypeView.ChooseLabel.text  = [payArray objectAtIndex:indexPath.row];
    }else{
       
        ShopTypeView.ChooseLabel.text = [ShopTypeArray objectAtIndex:indexPath.row][@"name"];
        sectionRow = [[ShopTypeArray objectAtIndex:indexPath.row][@"typeJoinId"] integerValue];
       
    }
   
    [choseView tf_hide];
}
@end
