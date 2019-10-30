//
//  YJTongJiViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJTongJiViewController.h"
#import "DNSPageView_ObjC.h"
#import "YJXiaoShouLiangViewController.h"
#import "YJShouKuangViewController.h"
#import "YJXiaoShouEViewController.h"
#import "YJKeHuLiangViewController.h"



@interface YJTongJiViewController (){
      DNSPageView *pageView;
}

@end

@implementation YJTongJiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.TopTitleLabel.text = @"统计";
    self.TopView.hidden = NO;
    [self CreateUI];
    
}
- (void)CreateUI{
    DNSPageStyle *style = [[DNSPageStyle alloc] init];
    style.titleViewScrollEnabled = YES;
    style.titleScaleEnabled = YES;
    style.showBottomLine = YES;
    style.bottomLineColor = font_main_color;
    style.titleSelectedColor = font_main_color;
    style.titleFont = [UIFont systemFontOfSize:13];
    style.titleMargin = 60;
    // 设置标题内容
    NSArray <NSString *>*titles = @[@"销售额", @"收款额",@"客户量"];
    YJXiaoShouLiangViewController *allVC = [[YJXiaoShouLiangViewController alloc] init];
    allVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:allVC];
    
    YJShouKuangViewController *recateVC = [[YJShouKuangViewController alloc] init];
    recateVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:recateVC];
    
    
//    YJXiaoShouEViewController *completeVC = [[YJXiaoShouEViewController alloc] init];
//    completeVC.view.backgroundColor = [UIColor whiteColor];
//    [self addChildViewController:completeVC];
    

    YJKeHuLiangViewController *receivedVC = [[YJKeHuLiangViewController alloc] init];
    receivedVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:receivedVC];
    
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    // 创建对应的DNSPageView，并设置它的frame
    pageView = [[DNSPageView alloc] initWithFrame:CGRectMake(0, kGHSafeAreaTopHeight+20, size.width, size.height) style:style titles:titles childViewControllers:self.childViewControllers startIndex:0];
    [self.view addSubview:pageView];
}
- (void)HotListBackClick{
    [self.navigationController   popToRootViewControllerAnimated:NO];
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
