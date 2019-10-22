//
//  YJShopSetDetailViewController.m
//  maike
//
//  Created by Apple on 2019/7/28.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShopSetDetailViewController.h"
#import "CustomView.h"
#import "CustomChooseView.h"
#import "YJUserSetFirstViewController.h"
#import "YJCustomerViewController.h"
#import "HDSelecterViewController.h"

@interface YJShopSetDetailViewController ()<pickerDelegate,UITextFieldDelegate>{
    CustomView *choseShopTitleView;
    CustomChooseView *choseNameView;
    CustomChooseView *choseTypeView;
    CustomChooseView *choseSpaceView;
    CustomView *choseSInfoView;
    UIPickerView *pickerView;
    NSString *name;
    NSString *customerID;
    NSString *categoryId;
    NSArray *myArray;
    NSMutableArray *spacearray;
    NSDictionary *mydic;
    NSString *myCategordID;
}
@property(nonatomic,strong)NSString *defualtProvince;
@property(nonatomic,strong)NSString *defualtCity;
@property(nonatomic,strong)NSString *defualtDistricts;
@end

@implementation YJShopSetDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品";
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
     myArray = [[NSArray alloc]init];
    spacearray = [[NSMutableArray alloc]init];
    [self reoadDate];
    [self initUI];
    
}
- (void)reoadDate{
    
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->myArray = [result objectForKey:@"data"];
        
    }];
    NSString *Spaceurl = [NSString stringWithFormat:@"%@/space/applist",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:Spaceurl withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        for (NSDictionary *mydic  in [result objectForKey:@"data"]) {
            [self->spacearray  addObject:[mydic objectForKey:@"name"]];
        }
        
        
    }];
    
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)initUI{
    choseShopTitleView  = [[CustomView alloc]init];
    choseShopTitleView.NameLabel.text = @"标题";
    choseShopTitleView.NameTextField.placeholder = @"请输入标题";
    choseShopTitleView.NameTextField.delegate = self;
    [self.view addSubview:choseShopTitleView];
    [choseShopTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    choseNameView  = [[CustomChooseView alloc]init];
    choseNameView.NameLabel.text = @"客户";
    choseNameView.ChooseLabel.text = @"请选择客户";
    choseNameView.ChooseLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *kehuTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kehuClick)];
    [choseNameView.ChooseLabel addGestureRecognizer:kehuTap];
    [self.view addSubview:choseNameView];
    [choseNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseShopTitleView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    choseTypeView  = [[CustomChooseView alloc]init];
    choseTypeView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *choseTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseAdressClick)];
    [choseTypeView addGestureRecognizer:choseTap];
    choseTypeView.NameLabel.text = @"分类";
    choseTypeView.ChooseLabel.text = @"请选择分类";
    [self.view addSubview:choseTypeView];
    [choseTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseNameView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    choseSpaceView  = [[CustomChooseView alloc]init];
    choseSpaceView.userInteractionEnabled = YES;
    UITapGestureRecognizer  *chosesSpaceTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseSpaceClick)];
    [choseSpaceView addGestureRecognizer:chosesSpaceTap];
    choseSpaceView.NameLabel.text = @"空间";
    choseSpaceView.ChooseLabel.text=  @"请选择空间";
    [self.view addSubview:choseSpaceView];
    [choseSpaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseTypeView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    choseSInfoView  = [[CustomView  alloc]init];
    choseSInfoView.NameLabel.text = @"备注";
    choseSInfoView.NameTextField.placeholder = @"请填写备注";
    choseSInfoView.NameTextField.delegate = self;
    [self.view addSubview:choseSInfoView];
    [choseSInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self->choseSpaceView.mas_bottom).offset(1);
        make.height.mas_equalTo(60);
    }];
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 10.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->choseSInfoView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
    
}
- (void)choseSpaceClick{
    [self HideKeyBoardClick];
    UIExPickerView *pView = [[UIExPickerView alloc ] initWithFrame:CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width, 200) arr:spacearray ];
    pView.delegate = self;
    [self.view addSubview:pView];
  
}
- (void)choseAdressClick{
    HDSelecterViewController *vc = [[HDSelecterViewController alloc]initWithDefualtProvince:self.defualtProvince city:self.defualtCity districts:self.defualtDistricts];
    vc.MyArray = myArray;
    vc.MyFirstStr = @"categoryName";//
    vc.MySecondStr = @"children";//
    vc.MyThirdStr = @"categoryName";//
    vc.MyFourStr = @"children";//
    vc.MyFiveStr =@"categoryName";
    vc.categoryId = @"categoryId";
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
        self->categoryId = provincecategoryId;
        self->myCategordID = districtscategoryId;
        self->choseTypeView.ChooseLabel.text = [NSString stringWithFormat:@"%@%@%@",province,city,districts];
        [weakSelf dismissViewControllerAnimated:true completion:nil];
    }];
    [self HideKeyBoardClick];
    [self presentViewController:vc animated:true completion:nil];
}
- (void)kehuClick{
    [self HideKeyBoardClick];
    YJCustomerViewController *vc = [[YJCustomerViewController   alloc]init];
    vc.type = @"1";
    [vc setChoseCustomerBlock:^(NSString * _Nonnull string, NSString * _Nonnull custonerid) {
        self->name = string;
        self->choseNameView.ChooseLabel.text = self->name;
        self->customerID = custonerid;
    }];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)nextBtn{
    if (_defualtProvince.length) {
        
        if ([customerID  integerValue]) {
            if ([choseSpaceView.ChooseLabel.text isEqualToString:@"请选择空间"]) {
                [AnimationView showString:@"请选择空间"];
            }else{
                [self postClick];
            }
            
        }else{
            [AnimationView showString:@"请选择客户"];
        }
    }else{
       [AnimationView showString:@"请选择类别"];
       
    }
    
   
}
- (void)postClick{
    NSString *tokenID = NSuserUse(@"token");
    if ([_defualtProvince isEqualToString:@"门类"]) {
        //
        mydic =@{@"name":choseShopTitleView.NameTextField.text,
                 @"categoryName":choseTypeView.ChooseLabel.text,
                 @"spaceName":choseSpaceView.ChooseLabel.text,
                 @"remark":choseSInfoView.NameTextField.text,
                 @"customerId":[NSNumber numberWithInteger:[customerID integerValue]],
                 @"categoryId":[NSNumber numberWithInteger:[myCategordID integerValue]]
                 };
        YJUserSetFirstViewController *user = [[YJUserSetFirstViewController alloc]init];
        user.dic = mydic;
        user.categoryId = myCategordID;
        [self.navigationController pushViewController:user animated:NO];
        
    }else{
     
            NSDictionary *dic = @{@"name":choseShopTitleView.NameTextField.text,
                                  @"categoryName":choseTypeView.ChooseLabel.text,
                                  @"spaceName":choseSpaceView.ChooseLabel.text,
                                  @"remark":choseSInfoView.NameTextField.text,
                                  @"customerId":[NSNumber numberWithInteger:[customerID integerValue]],
                                  @"categoryId":[NSNumber numberWithInteger:[myCategordID integerValue]]
                                  };
            
            
            NSString *url = [NSString stringWithFormat:@"%@/diy/add",BASE_URL];
            [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                if ([[result objectForKey:@"code"]integerValue] == 200) {
                    [AnimationView showString:@"定制成功"];
                    [self.navigationController popToRootViewControllerAnimated:NO];
                }else{
                    [AnimationView showString:[result objectForKey:@"errmsg"]];
                }
            }];
            
        
    }
    
}
- (void)selectIndex:(NSInteger)index{
    choseSpaceView.ChooseLabel.text = [spacearray objectAtIndex:index];
    NSLog(@"index ==  %ld",(long)index);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
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
