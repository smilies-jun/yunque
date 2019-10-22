//
//  YJShopShowDetailViewController.m
//  maike
//
//  Created by Apple on 2019/9/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShopShowDetailViewController.h"
#import "YJShopListViewController.h"
#import <WebKit/WebKit.h>
#import "RCDraggableButton.h"

@interface YJShopShowDetailViewController ()<WKUIDelegate,WKNavigationDelegate>{
      WKWebView *ActivityWebView;
}
@property(strong,nonatomic)UIButton *button;


@end

@implementation YJShopShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [[UIButton alloc]init];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-15);
        make.top.mas_equalTo(self.TopView.mas_top).offset(25);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    self.view.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);

    [self initUI];
}
- (void)initUI{
    ActivityWebView  = [[WKWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-64-60);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"HTTP:"]]];
    [self.view addSubview:ActivityWebView];
    ActivityWebView.UIDelegate = self;
    ActivityWebView.navigationDelegate = self;
    // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];
//    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 100, 100)];
//    [avatar setTitle:@"登陆领取" forState:UIControlStateNormal];
//    [avatar setImage:[UIImage imageNamed:@"Icon-60"] forState:UIControlStateNormal];
//    [self.view addSubview:avatar];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJShopListViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
- (void)rightClick{
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
