
//
//  YJCustomViewController.m
//  maike
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJCustomViewController.h"
#import "CustomView.h"

@interface YJCustomViewController (){
    CustomView *bankCustomView;
    CustomView *bankAdressCustomView;
    CustomView *banKNameCustomView;
     UIButton *sureBtn;
}

@end

@implementation YJCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"开户行认证";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);

    [self.BackButton addTarget:self action:@selector(AuthenticationBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self InitUI];
}
- (void)AuthenticationBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)InitUI{
    bankCustomView = [[CustomView alloc]init];
    bankCustomView.NameLabel.text = @"银行卡号";
    [self.view addSubview:bankCustomView];
    [bankCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    bankAdressCustomView = [[CustomView alloc]init];
    bankAdressCustomView.NameLabel.text = @"开户行";
    [self.view addSubview:bankAdressCustomView];
    [bankAdressCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->bankCustomView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    banKNameCustomView = [[CustomView alloc]init];
    banKNameCustomView.NameLabel.text = @"账户名称";
    [self.view addSubview:banKNameCustomView];
    [banKNameCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->bankAdressCustomView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.view.left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(postBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->banKNameCustomView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
}
-(void)postBtn{
    NSString *tokenID = NSuserUse(@"token");
    if (bankCustomView.NameTextField.text.length) {
        if (bankAdressCustomView.NameTextField.text.length) {
            if (banKNameCustomView.NameTextField.text.length) {
                NSDictionary *dic = @{@"agreeAgreement":@"1",
                                      @"appealShopId":_shopId,
                                      @"appealBank":bankAdressCustomView.NameTextField.text,
                                      @"appealBankAccount":bankCustomView.NameTextField.text,
                                      @"appealBankName":banKNameCustomView.NameTextField.text,
                                      @"bankAccount":[_dic objectForKey:@"bankAccount"],
                                      @"bankNumber":[_dic objectForKey:@"bankNumber"],
                                      @"shopName":[_dic objectForKey:@"shopName"],
                                      @"shopShortName":[_dic objectForKey:@"shopShortName"],
                                      @"province":[_dic objectForKey:@"province"],
                                      @"city":[_dic objectForKey:@"city"],
                                      @"bank":[_dic objectForKey:@"bank"],
                                      @"otherSettlementAccountType":[_dic objectForKey:@"otherSettlementAccountType"],
                                      @"typeJoinId":[_dic objectForKey:@"typeJoinId"],
                                      @"brandIds":[_dic objectForKey:@"brandIds"],
                                      @"areasonAppeal":_str,
                                      @"state":@"0",
                                      @"type":@"1"
                                      };
                
                NSString *url = [NSString stringWithFormat:@"%@/shop/shopfirm",BASE_URL];
                [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
                    if ([[result objectForKey:@"code"]integerValue] == 200) {
                        [AnimationView showString:@"正在审核"];
                        [self.navigationController popToRootViewControllerAnimated:NO];
                        
                    }else{
                        [AnimationView showString:[result objectForKey:@"errmsg"]];

                    }
                }];
            }else{
                [AnimationView showString:@"开户行"];

            }
        }else{
            [AnimationView showString:@"账号"];

        }
    }else{
        [AnimationView showString:@"账户"];

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
