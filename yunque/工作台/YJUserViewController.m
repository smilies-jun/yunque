//
//  YJUserViewController.m
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserViewController.h"
#import "YJKeHuViewController.h"
#import "YJCustomerViewController.h"
#import "YJAllShopViewController.h"
#import "YJUpShopViewController.h"
#import "YJHotShopViewController.h"
#import "YJTongJiViewController.h"
#import "YJUSerShouKuangViewController.h"
#import "JSCartViewController.h"


@interface YJUserViewController (){
    NSString *xiaoshouStr;
    NSString *shoukuangStr;
    NSString *daishoukuangStr;
}
@property(nonatomic,strong)UIImageView*XiaoShouImageView;

@property(nonatomic,strong)UIImageView*ShouKuangImageView;


@property(nonatomic,strong)UIButton *kehuBtn;

@property(nonatomic,strong)UIButton *ShopBtn;

@property(nonatomic,strong)UIButton *HotBtn;

@property(nonatomic,strong)UIButton *AnLiBtn;



@property(nonatomic,strong)UIButton *shouBtn;

@property(nonatomic,strong)UIButton *ShangYangBtn;

@property(nonatomic,strong)UIButton *YuanGongBtn;


@property(nonatomic,strong)UIButton *xiaoshouBtn;

@property(nonatomic,strong)UIButton *shoukuangBtn;

@property(nonatomic,strong)UIButton *xiaoshouliangBtn;

@property(nonatomic,strong)UIButton *kehuliangBtn;


@property(nonatomic,strong)UILabel *adressLabel;
@end

@implementation YJUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.BackButton.hidden = YES;
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
    
    UILabel *title = [[UILabel alloc]init];
    title.text = @"服务台";
    title.font = [UIFont systemFontOfSize:23];
    [self.TopView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.TopView.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(10);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _adressLabel = [[UILabel alloc]init];
    NSString *shopName = NSuserUse(@"shopName");
    _adressLabel.text = shopName;
    _adressLabel.font = [UIFont systemFontOfSize:13];
    [self.TopView addSubview:_adressLabel];
    [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.TopView.mas_left).offset(20);
        make.top.mas_equalTo(title.mas_bottom).offset(1);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *Userimage = [[UIImageView alloc]init];
    Userimage.image = [UIImage imageNamed:@"默认头像"];
    [self.TopView addSubview:Userimage];
    [Userimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.TopView.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self reoadDate];
    
    
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");

    NSString *url = [NSString stringWithFormat:@"%@/account/financialOverview",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        //self->myArray = [result objectForKey:@"data"];
        self->xiaoshouStr = [[result objectForKey:@"data"]objectForKey:@"grossSales"];
        self->shoukuangStr =[[result objectForKey:@"data"]objectForKey:@"totalReceipt"];
        self->daishoukuangStr =[[result objectForKey:@"data"]objectForKey:@"receivable"];
        [self setTopUI];
        [self setJingYingUI];
        [self setGuanLiUI];
        
    }];
    
}
- (void)setTopUI{
    _XiaoShouImageView = [[UIImageView alloc]init];
    _XiaoShouImageView.image = [UIImage imageNamed:@"卡片"];
    _XiaoShouImageView.layer.masksToBounds = YES;
    _XiaoShouImageView.layer.cornerRadius = 5.0f;
    [self.view addSubview:_XiaoShouImageView];
    [_XiaoShouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(10);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-20);
        make.height.mas_equalTo(180);
    }];
    
    UILabel *xiaoshouLabelNumber = [[UILabel alloc]init];

     if ([shoukuangStr integerValue]) {
         xiaoshouLabelNumber.text = xiaoshouStr;
     }else{
         xiaoshouLabelNumber.text = @"0.00";
     }
    xiaoshouLabelNumber.textAlignment = NSTextAlignmentCenter;
    xiaoshouLabelNumber.font = [UIFont boldSystemFontOfSize:24];
     xiaoshouLabelNumber.textColor = [UIColor blackColor];
     [_XiaoShouImageView addSubview:xiaoshouLabelNumber];
     [xiaoshouLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_XiaoShouImageView.mas_left).offset(10);
        make.top.mas_equalTo(_XiaoShouImageView.mas_top).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
     }];

    UILabel *xiaoshouLabel = [[UILabel alloc]init];
    xiaoshouLabel.text = @"销售额(元)";
    xiaoshouLabel.font = [UIFont systemFontOfSize:12];
    xiaoshouLabel.textAlignment = NSTextAlignmentCenter;
    xiaoshouLabel.textColor = [UIColor blackColor];
    [_XiaoShouImageView addSubview:xiaoshouLabel];
    [xiaoshouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_XiaoShouImageView.mas_left).offset(10);
        make.top.mas_equalTo(xiaoshouLabelNumber.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    
    
    
    UILabel *shouNumber = [[UILabel alloc]init];

      if (daishoukuangStr.length) {
            shouNumber.text = daishoukuangStr;
      }else{
          shouNumber.text = @"0.00";
      }
    shouNumber.textAlignment = NSTextAlignmentCenter;
    shouNumber.font = [UIFont boldSystemFontOfSize:24];
    shouNumber.textColor = [UIColor blackColor];
      [_XiaoShouImageView addSubview:shouNumber];
      [shouNumber mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(_XiaoShouImageView.mas_left).offset(10);
          make.top.mas_equalTo(xiaoshouLabel.mas_bottom).offset(30);
          make.width.mas_equalTo(120);
          make.height.mas_equalTo(20);
      }];
    UILabel *shoukLabel = [[UILabel alloc]init];
    shoukLabel.text = @"代收额(元)";
    shoukLabel.font = [UIFont systemFontOfSize:12];
    shoukLabel.textAlignment = NSTextAlignmentCenter;
    shoukLabel.textColor = [UIColor blackColor];
    [_XiaoShouImageView addSubview:shoukLabel];
    [shoukLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_XiaoShouImageView.mas_left).offset(10);
        make.top.mas_equalTo(shouNumber.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    UILabel *shouLabelNumber = [[UILabel alloc]init];
     if ([shoukuangStr integerValue]) {
         shouLabelNumber.text = xiaoshouStr;
     }else{
         shouLabelNumber.text = @"0.00";
     }
    shouLabelNumber.textAlignment = NSTextAlignmentCenter;
    shouLabelNumber.font = [UIFont boldSystemFontOfSize:24];
     shouLabelNumber.textColor = [UIColor blackColor];
     [_XiaoShouImageView addSubview:shouLabelNumber];
     [shouLabelNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_XiaoShouImageView.mas_right).offset(-10);
        make.top.mas_equalTo(xiaoshouLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
     }];

    UILabel *shouLabel = [[UILabel alloc]init];
    shouLabel.text = @"收款额(元)";
    shouLabel.font = [UIFont systemFontOfSize:12];

    shouLabel.textAlignment = NSTextAlignmentCenter;
    shouLabel.textColor = [UIColor blackColor];
    [_XiaoShouImageView addSubview:shouLabel];
    [shouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shouLabelNumber.mas_left);
        make.top.mas_equalTo(shouLabelNumber.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)setJingYingUI{
    _kehuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_kehuBtn addTarget:self action:@selector(kehuClick) forControlEvents:UIControlEventTouchUpInside];
    [_kehuBtn setBackgroundImage:[UIImage imageNamed:@"客户管理"] forState:UIControlStateNormal];
    [self.view addSubview:_kehuBtn];
    [_kehuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(_XiaoShouImageView.mas_bottom).offset(30);
         if (iPhoneXAndXS) {
                   make.width.mas_equalTo(164);
                   make.height.mas_equalTo(110);
         }else if (iPhoneXRAndXSMAX){
             make.width.mas_equalTo(180);
             make.height.mas_equalTo(120);
         }else{
                   make.width.mas_equalTo(164-10);
                   make.height.mas_equalTo(110-5);
               }
    }];

    _ShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       [_ShopBtn addTarget:self action:@selector(yuangongClick) forControlEvents:UIControlEventTouchUpInside];
    [_ShopBtn setBackgroundImage:[UIImage imageNamed:@"员工管理"] forState:UIControlStateNormal];
    [self.view addSubview:_ShopBtn];
    [_ShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_kehuBtn.mas_right).offset(20);
        make.top.mas_equalTo(_XiaoShouImageView.mas_bottom).offset(30);
        if (iPhoneXAndXS) {
            make.width.mas_equalTo(164);
            make.height.mas_equalTo(110);
        }else if (iPhoneXRAndXSMAX){
            make.width.mas_equalTo(180);
            make.height.mas_equalTo(120);
        }else{
             make.width.mas_equalTo(164-10);
                               make.height.mas_equalTo(110-5);
        }
      
    }];
   
}
- (void)setGuanLiUI{
    _ShangYangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ShangYangBtn addTarget:self action:@selector(shangyangClick) forControlEvents:UIControlEventTouchUpInside];
    [_ShangYangBtn setBackgroundImage:[UIImage imageNamed:@"价格设置"] forState:UIControlStateNormal];

    //_ShangYangBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_ShangYangBtn];
    [_ShangYangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(self.view.mas_left).offset(20);
              make.top.mas_equalTo(_kehuBtn.mas_bottom).offset(20);
              if (iPhoneXAndXS) {
                    make.width.mas_equalTo(164);
                    make.height.mas_equalTo(110);
                }else if (iPhoneXRAndXSMAX){
                    make.width.mas_equalTo(180);
                    make.height.mas_equalTo(120);
                }else{
                    make.width.mas_equalTo(164-10);
                                       make.height.mas_equalTo(110-5);
                     }
    }];

    _YuanGongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_YuanGongBtn addTarget:self action:@selector(tongjiBtn) forControlEvents:UIControlEventTouchUpInside];
    [_YuanGongBtn setBackgroundImage:[UIImage imageNamed:@"数据统计"] forState:UIControlStateNormal];
    [self.view addSubview:_YuanGongBtn];
    [_YuanGongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShangYangBtn.mas_right).offset(20);
        make.top.mas_equalTo(_kehuBtn.mas_bottom).offset(20);
        if (iPhoneXAndXS) {
                   make.width.mas_equalTo(164);
                   make.height.mas_equalTo(110);
               }else if (iPhoneXRAndXSMAX){
                   make.width.mas_equalTo(180);
                   make.height.mas_equalTo(120);
               }else{
                   make.width.mas_equalTo(164-10);
                                     make.height.mas_equalTo(110-5);
               }
    }];

}

- (void)shoukClick{
    YJUSerShouKuangViewController    *vc = [[YJUSerShouKuangViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)kehuClick{
    YJCustomerViewController *vc = [[YJCustomerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)hotClick{
    YJHotShopViewController *vc = [[YJHotShopViewController alloc]init];
    NSString *type = NSuserUse(@"type");
    vc.TypeStr = type;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)yuangongClick{
    YJKeHuViewController *vc = [[YJKeHuViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)shangyangClick{
    YJUpShopViewController *vc = [[YJUpShopViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)tongjiBtn{
    YJTongJiViewController *vc = [[YJTongJiViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)ShopClick{
    JSCartViewController *vc = [[JSCartViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
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
