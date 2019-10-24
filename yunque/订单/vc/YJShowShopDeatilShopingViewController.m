//
//  YJShowShopDeatilShopingViewController.m
//  maike
//
//  Created by Apple on 2019/9/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShowShopDeatilShopingViewController.h"
#import <WebKit/WebKit.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "YJHtmlShopDetailViewController.h"
#import "YJSectionDetailViewController.h"

@interface YJShowShopDeatilShopingViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>{
    WKWebView *ActivityWebView;
    MBProgressHUD *hud;
    UILabel *SaleLbel;
    NSDictionary *MyDIC;
    NSDictionary *ShareDic;
    NSString *titleStr;
    NSString *imageStr;
    NSString *productIdStr;
    NSArray *shopArray;
    
}
@property (nonatomic, strong) CIContext *jsContext;

@end

@implementation YJShowShopDeatilShopingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    if (_TitleStr.length) {
         self.TopTitleLabel.text = _TitleStr;
    }else{
         self.TopTitleLabel.text = @"商品详情";
    }
   
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.RightFirstButton addTarget:self action:@selector(showShareSdk) forControlEvents:UIControlEventTouchUpInside];
    [self.RightFirstButton setImage:[UIImage imageNamed:@"分享转发"] forState:UIControlStateNormal];
    if ([_TypeStr isEqualToString:@"1"]) {
        self.RightFirstButton.hidden = YES;
    }else{
        self.RightFirstButton.hidden = NO;

    }
    shopArray = [[NSArray alloc]init];
    NSLog(@"web === %@",_WebStr);
    ActivityWebView  = [[WKWebView alloc]init];
    ActivityWebView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-64-StatusBarHeight);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_WebStr]]];
    ActivityWebView.navigationDelegate = self;
    WKUserContentController* userCC = ActivityWebView.configuration.userContentController;

    [userCC addScriptMessageHandler: self
                               name: @"attendanceShare"];
    
    [self.view addSubview:ActivityWebView];
    // ActivityWebView.scalesPageToFit  = YES;
    [ActivityWebView loadRequest:request];
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");

    NSString *UserInfourl = [NSString stringWithFormat:@"%@/product/addFootPrint?userId=%@&productId=%@",BASE_URL,userID,_ShopIDStr];
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:UserInfourl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        //self->userDic =[result objectForKey:@"data"];
        //[self SetUi];
    }];
}

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString: @"attendanceShare"]) {
        NSLog(@"MessageBody: %@", message.body);
        NSString *price = [NSString stringWithFormat:@"%ld",(long)[[message.body objectForKey:@"price"]integerValue] ];
        productIdStr = [NSString stringWithFormat:@"%ld",(long)[[message.body objectForKey:@"productAttributesId"]integerValue] ];
        titleStr = [message.body objectForKey:@"title"];
        imageStr = [message.body objectForKey:@"imgurl"];
        shopArray = [message.body objectForKey:@"skuList"];
        [self postPrice:price];
        // async return value
        [ActivityWebView evaluateJavaScript: @"response2JS('Hello return')"
                       completionHandler:^(id response, NSError * error) {
                           NSLog(@"response: %@, \nerror: %@", response, error);
                       }];
    }
}
-(void)postPrice:(NSString *)price{
    YJHtmlShopDetailViewController   *vc = [[YJHtmlShopDetailViewController alloc]init];
    vc.ShopIdStr = _ShopIDStr;
    vc.shopMoneyStr = price;
    vc.ProductIdStr = productIdStr;
    vc.ProductTitleStr = titleStr;
    vc.ProductImageStr = imageStr;
    vc.ProductArray = shopArray;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)showShareSdk{
    NSArray* imageArray = @[[UIImage imageNamed:@"logo.jpg"]];
    //（注意：图片可以是UIImage对象，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"迈克家的分享"
                                     images:imageArray
                                        url:[NSURL URLWithString:@"http://www.maikehome.cn"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    [ShareSDK showShareActionSheet:nil
                       customItems:nil
                       shareParams:shareParams
                sheetConfiguration:nil
                    onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                        switch (state) {
                            case SSDKResponseStateSuccess:
                            {
                                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                    message:nil
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil];
                                [alertView show];
                                break;
                            }
                            case SSDKResponseStateFail:
                            {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                message:[NSString stringWithFormat:@"%@",error]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"OK"
                                                                      otherButtonTitles:nil, nil];
                                [alert show];
                                break;
                            }
                            default:
                                break;
                        }
                    }];
    
  
}
- (void)HotListBackClick{
    [self.navigationController   popToRootViewControllerAnimated:NO];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"REQUEST.URL = %@",request.URL);
    NSString *urlStr = [NSString stringWithFormat:@"%@",request.URL];

    
    
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
   // self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
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
