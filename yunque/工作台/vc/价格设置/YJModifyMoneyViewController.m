//
//  YJModifyMoneyViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJModifyMoneyViewController.h"
#import "CustomChooseView.h"
#import "CustomView.h"
#import "YJChoseMoneyTypeViewController.h"

#import "YJUpShopViewController.h"


@interface YJModifyMoneyViewController ()<UITextFieldDelegate>{
    CustomView *nameView;
    CustomView *MoneyView;
    CustomChooseView *typeView;
    NSString *myChoseStr;
    NSMutableArray *myArray;
    UIButton *sureBtn;
    NSString *cateIdStr;
    NSInteger all;
    
    
}
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation YJModifyMoneyViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"价格设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    myArray  = [[NSMutableArray alloc]init];
    all = 0;
    [self SetUi];
  
}
- (void)SetUi{
    nameView  = [[CustomView alloc]init];
    nameView.NameLabel.text = @"名称";
    nameView.NameTextField.placeholder = @"请输入名称";
    nameView.NameTextField.delegate = self;
    [self.view addSubview:nameView];
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    MoneyView  = [[CustomView alloc]init];
    MoneyView.NameLabel.text = @"利润率";
    MoneyView.NameTextField.placeholder =@"请输入利润率";
    MoneyView.NameTextField.delegate = self;
    MoneyView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:MoneyView];
    [MoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->nameView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    typeView   = [[CustomChooseView alloc]init];
    typeView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choseClick)];
    [typeView addGestureRecognizer:tap];
    typeView.ChooseLabel.font= [UIFont systemFontOfSize:14];
    typeView.ChooseLabel.numberOfLines = 0;
    typeView.NameLabel.text = @"分类";
    
    typeView.ChooseLabel.text = @"请选择分类";
    [self.view addSubview:typeView];
    [typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->MoneyView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"下一步"];
    [typeView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->typeView.mas_right).offset(-20);
        make.top.mas_equalTo(self->typeView.mas_top).offset(20);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
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
        make.top.mas_equalTo(self->typeView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
    
    
}
- (void)LoginNextBtn{
    if (nameView.NameTextField.text.length) {
        if ([MoneyView.NameTextField.text integerValue]) {
            if (myChoseStr.length) {
                [self postClick];
            }else{
                [AnimationView showString:@"请选择分类"];
            }
        }else{
            [AnimationView showString:@"请填写利率字"];

        }
    }else{
         [AnimationView showString:@"请填写名字"];
    }
}
- (void)postClick{
    int allShop;
    if ([typeView.ChooseLabel.text isEqualToString:@"全部商品"]) {
        allShop = 1;
        
    }else{
        allShop = 0;
    }
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/categoryprice/add",BASE_URL];
    NSDictionary *dic;
    if (allShop) {
        dic = @{@"reto":MoneyView.NameTextField.text,
                @"name":nameView.NameTextField.text,
                @"allCategory":@(allShop)
                };
    }else{
        dic = @{@"reto":MoneyView.NameTextField.text,
                @"categoryIds":cateIdStr,
                @"name":nameView.NameTextField.text,
                };
    }
    NSLog(@"dic == %@",dic);
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"] integerValue]== 200) {
             [AnimationView showString:@"新增成功"];
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[YJUpShopViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }

        }else{
            [AnimationView showString:@"新增失败"];
        }
    }];
}
- (void)choseClick{
    YJChoseMoneyTypeViewController *vc = [[YJChoseMoneyTypeViewController  alloc]init];
    [vc setMydata:^(NSString *textStr, NSString *cataIdStr) {
        self->myChoseStr = textStr;
        if ([textStr isEqualToString:@"全部商品"]) {
             self->typeView.ChooseLabel.text = textStr;
        }else{
            if (textStr.length) {
                NSString *str = [textStr substringWithRange:NSMakeRange(1, textStr.length-1)];
                self->typeView.ChooseLabel.text = str;
            }
            if (cataIdStr.length) {
                NSString *str = [cataIdStr substringWithRange:NSMakeRange(1, cataIdStr.length-1)];
                self->cateIdStr = str;
            }
        }
       
       
    }];
    
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)HotListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUpShopViewController class]]) {
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
