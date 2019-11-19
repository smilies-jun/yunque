//
//  YJProViewController.m
//  maike
//
//  Created by Apple on 2019/9/4.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJProViewController.h"
#import <WebKit/WebKit.h>
#import "YJAuthenticationViewController.h"
#import "YJLoginAndReginViewController.h"
#import "YJUserSetViewController.h"


@interface YJProViewController ()<WKUIDelegate,WKNavigationDelegate>{
    WKWebView *ActivityWebView;
    MBProgressHUD *hud;
    UILabel *SaleLbel;
    NSDictionary *MyDIC;
    NSDictionary *ShareDic;
    
}

@end

@implementation YJProViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"注册协议";
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.RightFirstButton addTarget:self action:@selector(showShareSdk) forControlEvents:UIControlEventTouchUpInside];
//    [self.RightFirstButton setImage:[UIImage imageNamed:@"分享转发"] forState:UIControlStateNormal];
    
    ActivityWebView  = [[WKWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-64-40);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
    [self.view addSubview:ActivityWebView];
    // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];
}
- (void)showShareSdk{
    
}
- (void)HotListBackClick{
    if ([_type isEqualToString:@"1"]) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
               if ([controller isKindOfClass:[YJAuthenticationViewController class]]) {
                   [self.navigationController popToViewController:controller animated:YES];
               }
           }
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
                  if ([controller isKindOfClass:[YJLoginAndReginViewController class]]) {
                      [self.navigationController popToViewController:controller animated:YES];
                  }
              }
           for (UIViewController *controller in self.navigationController.viewControllers) {
               if ([controller isKindOfClass:[YJUserSetViewController  class]]) {
                   [self.navigationController popToViewController:controller animated:YES];
               }
           }
        
    }
   
   
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"REQUEST.URL = %@",request.URL);
    NSString *urlStr = [NSString stringWithFormat:@"%@",request.URL];
    NSString *strRegin = @"https://weixin.milibanking.com/weixin/weixin/login/toRegister";
    NSString *strSale1 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=1";
    NSString *strSale2 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=2";
    NSString *strSale3 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=3";
    
    NSString *strSale4 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=4";
    
    NSString *strSale5 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=5";
    
    NSString *strSale6 = @"https://weixin.milibanking.com/weixin/weixin/product/productList?productId=6";
    
    //    if ([urlStr containsString:strRegin]) {
    //        ActivityRefinViewController *reVC= [[ActivityRefinViewController alloc]init];
    //        reVC.type = @"1";
    //        [self.navigationController pushViewController:reVC animated:NO];
    //    }else if ([urlStr containsString:strSale1]){
    //        NSuserSave(@"2", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }else if ([urlStr containsString:strSale2]){
    //        NSuserSave(@"5", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }else if ([urlStr containsString:strSale3]){
    //        NSuserSave(@"1", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }else if ([urlStr containsString:strSale4]){
    //        NSuserSave(@"4", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }else if ([urlStr containsString:strSale5]){
    //        NSuserSave(@"3", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }else if ([urlStr containsString:strSale6]){
    //        NSuserSave(@"6", @"qiye");
    //        [self.navigationController popToRootViewControllerAnimated:YES];
    //        [self.rdv_tabBarController setSelectedIndex:0];
    //        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    //    }
    
    return YES;
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"22222");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"22222");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"22222");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"22222");
}


// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"允许跳转1%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSLog(@"允许跳转允许跳转允许跳转允许跳转允许跳转允许跳转允许跳转允许跳转");
    NSLog(@"允许跳转2%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
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
