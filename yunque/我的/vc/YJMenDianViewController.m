//
//  YJMenDianViewController.m
//  maike
//
//  Created by Apple on 2019/8/5.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJMenDianViewController.h"
#import "CustomChooseView.h"
#import "YJUserAuViewController.h"

@interface YJMenDianViewController (){
    NSDictionary *mydic;
    UIButton *rightBtn;
}
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)CustomChooseView *customZTView;

@property (nonatomic,strong)CustomChooseView *customTypeView;
@property (nonatomic,strong)CustomChooseView *customNameView;
@property (nonatomic,strong)CustomChooseView *customNameSortView;
@property (nonatomic,strong)CustomChooseView *customShopTypeView;
@property (nonatomic,strong)CustomChooseView *customShopAdressView;

@property (nonatomic,strong)CustomChooseView *customNumberView;
@property (nonatomic,strong)CustomChooseView *customUserView;
@property (nonatomic,strong)CustomChooseView *customUserAdressView;
@property (nonatomic,strong)CustomChooseView *customUserAdminView;
@property (nonatomic,strong)CustomChooseView *customUserMoneyView;


@end

@implementation YJMenDianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopTitleLabel.text = @"门店信息";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    mydic = [[NSDictionary alloc]init];
    rightBtn = [[UIButton alloc]init];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"重新认证" forState:UIControlStateNormal];
    [rightBtn setTitleColor:font_main_color forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    rightBtn.hidden = YES;
    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(30);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
     [self reloadData];
   
}
- (void)rightClick{
    YJUserAuViewController *vc = [[YJUserAuViewController alloc]init];
    vc.shopIdStr = [mydic objectForKey:@"shopId"];
    vc.shopname = [mydic objectForKey:@"shopName"];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)reloadData{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url;
    
    if ([_typeStr integerValue] == 5) {
        url = [NSString stringWithFormat:@"%@/shop/selShopfirm",BASE_URL];
        
    }else{
        url = [NSString stringWithFormat:@"%@/shop/selShopPersonal",BASE_URL];
        
    }
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->mydic =[result objectForKey:@"data"];
        NSLog(@"result == %@",result);
        [self initUI];
    }];
}
-(void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)initUI{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44-StatusBarHeight);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:_scrollView];
    
    _customZTView = [[CustomChooseView alloc]init];
    _customZTView.NameLabel.text = @"已认证";
    _customZTView.ChooseLabel.hidden = YES;
    [_scrollView  addSubview:_customZTView];
    [_customZTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    switch ([[mydic objectForKey:@"applyType"]integerValue]) {
        case 0:
            rightBtn.hidden = YES;

             _customZTView.NameLabel.text = @"待审核";
            break;
        case 1:
            rightBtn.hidden = YES;

            _customZTView.NameLabel.text = @"已认证";
            break;
        case 2:
            rightBtn.hidden = NO;
             _customZTView.NameLabel.text = @"认证失败";
            _customZTView.ChooseLabel.text = [NSString stringWithFormat:@"%@ 点击右上角重新认证",[mydic objectForKey:@"lossAppeal"]];
            break;
        default:
            rightBtn.hidden = NO;
            _customZTView.NameLabel.text = @"认证失败";
            _customZTView.ChooseLabel.text = [NSString stringWithFormat:@"%@ 点击右上角重新认证",[mydic objectForKey:@"lossAppeal"]];
            break;
    }
    UILabel *jiben = [[UILabel alloc]init];
    jiben.text  = @"基本信息";
    jiben.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:jiben];
    [jiben mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left).offset(20);
        make.top.mas_equalTo(self->_customZTView.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _customTypeView = [[CustomChooseView alloc]init];
    _customTypeView.NameLabel.text = @"门店类型";
    switch ([_typeStr integerValue]) {
        case 0:
             _customTypeView.ChooseLabel.text =@"个人";
            break;
        case 1:
             _customTypeView.ChooseLabel.text = @"企业";
            break;
        default:
            break;
    }
   
    [_scrollView  addSubview:_customTypeView];
    [_customTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_scrollView.mas_top).offset(120);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customNameView = [[CustomChooseView alloc]init];
    _customNameView.NameLabel.text = @"门店名称";
    _customNameView.ChooseLabel.text = [mydic objectForKey:@"shopName"];
    [_scrollView  addSubview:_customNameView];
    [_customNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customTypeView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    _customNameSortView = [[CustomChooseView alloc]init];
    
    _customNameSortView.NameLabel.text = @"门店简称";
    _customNameSortView.ChooseLabel.text = [mydic objectForKey:@"shopShortName"];

    [_scrollView  addSubview:_customNameSortView];
    [_customNameSortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customNameView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customShopTypeView = [[CustomChooseView alloc]init];
    _customShopTypeView.NameLabel.text = @"加盟类型";
    _customShopTypeView.ChooseLabel.text = [mydic objectForKey:@"typeJoinStr"];
    [_scrollView  addSubview:_customShopTypeView];
    [_customShopTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customNameSortView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customShopAdressView = [[CustomChooseView alloc]init];
    _customShopAdressView.NameLabel.text = @"加盟区域";
    _customShopAdressView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@",[mydic objectForKey:@"province"],[mydic objectForKey:@"city"]];
    [_scrollView  addSubview:_customShopAdressView];
    [_customShopAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customShopTypeView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UILabel *shengfen = [[UILabel alloc]init];
    shengfen.text  = @"身份信息";
    shengfen.font = [UIFont systemFontOfSize:12];
    [_scrollView addSubview:shengfen];
    [shengfen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left).offset(20);
        make.top.mas_equalTo(self->_customShopAdressView.mas_bottom).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    _customNumberView = [[CustomChooseView alloc]init];
   
   
    [_scrollView  addSubview:_customNumberView];
    [_customNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customShopAdressView.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customUserView = [[CustomChooseView alloc]init];
    _customUserView.NameLabel.text = @"持卡人";
    [_scrollView  addSubview:_customUserView];
    [_customUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customNumberView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    if ([_typeStr integerValue]) {
        shengfen.text  = @"银行卡信息";
         _customNumberView.NameLabel.text = @"账号";
         _customUserView.NameLabel.text = @"账户";
    }else{
        shengfen.text  = @"身份信息";
         _customNumberView.NameLabel.text = @"身份证号";
        _customUserView.NameLabel.text = @"真实姓名";
      
    }
   
    
    
   
    
    _customUserAdressView = [[CustomChooseView alloc]init];
    _customUserAdressView.NameLabel.text = @"开户行";
     _customUserAdressView.ChooseLabel.text = [mydic objectForKey:@"bank"];
    [_scrollView  addSubview:_customUserAdressView];
    [_customUserAdressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customUserView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customUserAdminView = [[CustomChooseView alloc]init];
    _customUserAdminView.NameLabel.text = @"结算类型";
    switch ([[mydic objectForKey:@"otherSettlementAccountType"] integerValue]) {
        case 0:
            _customUserAdminView.ChooseLabel.text =@"支付宝";
            break;
        case 1:
            _customUserAdminView.ChooseLabel.text =@"微信";
            break;
        case 2:
            _customUserAdminView.ChooseLabel.text =@"其他";
            break;
        default:
            break;
    }
    
    [_scrollView  addSubview:_customUserAdminView];
    
    [_customUserAdminView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customUserAdressView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    _customUserMoneyView = [[CustomChooseView alloc]init];
    _customUserMoneyView.NameLabel.text = @"结算账户";
    _customUserMoneyView.ChooseLabel.text = [mydic objectForKey:@"othersettlementAccount"];

    [_scrollView  addSubview:_customUserMoneyView];
    [_customUserMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_scrollView.mas_left);
        make.top.mas_equalTo(self->_customUserAdminView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    if ([_typeStr integerValue]) {
        _customUserAdressView.hidden= NO;
       
        _customNumberView.ChooseLabel.text = [mydic objectForKey:@"bankNumber"];
        _customUserView.ChooseLabel.text = [mydic objectForKey:@"bankAccount"];
    }else{
       
        _customUserAdressView.hidden= YES;
        _customNumberView.ChooseLabel.text = [mydic objectForKey:@"identityNumber"];
        _customUserView.ChooseLabel.text = [mydic objectForKey:@"realName"];
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
