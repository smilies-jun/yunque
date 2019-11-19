//
//  AppDelegate.m
//  maike
//
//  Created by amin on 2019/7/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "AppDelegate.h"
#import "YJHomeViewController.h"
#import "YJShopViewController.h"
#import "YJUserViewController.h"
#import "YJMyOrderViewController.h"
#import "YJSeconryViewController.h"
#import "YJLoginAndReginViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "KSGuaidViewManager.h"
#import "YJPinPaiViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self setupViewControllers];
    //启动动画延迟时间

    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        //微信
        [platformsRegister setupWeChatWithAppId:@"wx7577b52b6457ea15" appSecret:@"11a930225faaad89b8e81abba48345d6"];
        
        //新浪
        [platformsRegister setupSinaWeiboWithAppkey:@"2901917311" appSecret:@"ce3fa69a9e9edc5607cb96549eae4529" redirectUrl:@"http://www.yzyunque.com"];

    }];
   // [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
   // [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
  //  int i = 7;
    //判断是否登陆，服务器获取
//    if ( i >= 5) {
//        YJLoginAndReginViewController *loginVC = [[YJLoginAndReginViewController alloc]init];
//        self.window.rootViewController = loginVC;
//          [self.window makeKeyAndVisible];
//        NSLog(@"木有登陆");
//    }else{
        NSLog(@"已经登陆");
        [self.window setRootViewController:self.viewController];
        [self.window makeKeyAndVisible];
        KSGuaidManager.images = @[[UIImage imageNamed:@"导购平台"],
                              [UIImage imageNamed:@"量身定制"],
                                  [UIImage imageNamed:@"店铺管理"]];
                             
    
    KSGuaidManager.shouldDismissWhenDragging = YES;
    
    [KSGuaidManager begin];
        [NSThread sleepForTimeInterval:2.0];
        [self customizeInterface];
  //  }
    return YES;
}
#pragma mark - Methods

- (void)setupViewControllers {
    UIViewController *firstViewController = [[YJHomeViewController alloc]init];
    UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[YJPinPaiViewController alloc] init];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[YJUserViewController alloc] init];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    UIViewController *FourViewController = [[YJMyOrderViewController alloc] init];
    UIViewController *FourNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:FourViewController];
    UIViewController *fiveViewController = [[YJSeconryViewController alloc] init];
    UIViewController *fiveNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:fiveViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController,secondNavigationController,
                                           thirdNavigationController,FourNavigationController,fiveNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
}

- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbarbg_normal"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbarbg_normal"];
    NSArray *tabBarItemImages = @[@"ShouYe", @"XinPing", @"GongZuoTai",@"DingDan",@"WoDe"];
    NSArray *tabBarItemNames = @[@"首页", @"发现", @"工作台",@"订单",@"我的"];
    NSInteger index = 0;
    [[tabBarController tabBar] setBackgroundColor:[UIColor whiteColor]];
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        [item setBackgroundColor:[UIColor whiteColor]];
        
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_Select",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_unSelect",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        [item setTitle:[tabBarItemNames objectAtIndex:index]];
        NSDictionary *tabBarTitleUnselectedDic = @{NSForegroundColorAttributeName:colorWithRGB(0.53, 0.53, 0.53),NSFontAttributeName:[UIFont systemFontOfSize:10]};
        NSDictionary *tabBarTitleSelectedDic = @{NSForegroundColorAttributeName:font_main_color,NSFontAttributeName:[UIFont systemFontOfSize:10]};
        
        //修改tabberItem的title颜色
        item.selectedTitleAttributes = tabBarTitleSelectedDic;
        item.unselectedTitleAttributes = tabBarTitleUnselectedDic;
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        item.backgroundColor = [UIColor whiteColor];
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        NSLog(@"6.9");
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:15],
                           NSForegroundColorAttributeName: [UIColor redColor],
                           };
    } else {
        NSLog(@"7.9");
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:15],
                           UITextAttributeTextColor: colorWithRGB(0.76, 0.65, 0.36),
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    NSLog(@"8.9");
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
