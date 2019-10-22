//
//  YJPinPaiDetailViewController.m
//  yunque
//
//  Created by Apple on 2019/10/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPinPaiDetailViewController.h"
#import "SDCycleScrollView.h"
#import "BaseTableViewVC.h"
#import "BaseCollectionViewVC.h"
#import "YJShopListViewController.h"
#import "UIView+SDAutoLayout.h"

@interface YJPinPaiDetailViewController ()<YNPageViewControllerDataSource, YNPageViewControllerDelegate,SDCycleScrollViewDelegate,SDCycleScrollViewDelegate>{
     
}


@property (nonatomic, copy) NSArray *imagesURLs;

@property (nonatomic, copy) NSArray *cacheKeyArray;
@property (nonatomic,strong)NSString *iconUrl;
@property (nonatomic,strong)NSString *detailTitle;
@property (nonatomic,strong)NSString *nameTitle;

@end

@implementation YJPinPaiDetailViewController

static NSString *braidIDStr;
- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBarHidden = NO;
    //设置导航栏背景图片为一个空的image，这样就透明了
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
       //去掉透明后导航栏下边的黑边
    //[[UINavigationBar appearance] setBarTintColor:colorWithRGB(0.58, 0.45, 0.42)];
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
       self.navigationController.navigationBar.translucent = YES;

       [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                                         NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];

   //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;

}



- (void)backItemClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - Public Function
+ (instancetype)suspendCenterPageVC:(NSString *)braid imageUrl:(NSString *)imageUrl detailTitle:(NSString *)detaiTitle brandTitle:(NSString *)brandTitle {
    
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleSuspensionCenter;
    configration.headerViewCouldScale = YES;
    //    configration.headerViewScaleMode = YNPageHeaderViewScaleModeCenter;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = true;
    configration.showBottomLine = NO;
    configration.lineColor = font_main_color;
    configration.selectedItemColor =font_main_color;
    return [self suspendCenterPageVCWithConfig:configration:braid imageUrl:imageUrl detailTitle:detaiTitle brandTitle:brandTitle];
}

+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config :(NSString *)braid imageUrl:(NSString *)imageUrl detailTitle:(NSString *)detaiTitle brandTitle:(nonnull NSString *)brandTitle{
    braidIDStr = braid;
    
    YJPinPaiDetailViewController *vc = [YJPinPaiDetailViewController pageViewControllerWithControllers:[self getArrayVCs]
                                                                                  titles:[self getArrayTitles]
                                                                                  config:config];
    
    vc.iconUrl = imageUrl;
    vc.detailTitle = detaiTitle;
    vc.nameTitle = brandTitle;
    vc.navigationController.title =brandTitle;
    vc.dataSource = vc;
    vc.delegate = vc;
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headview.backgroundColor = colorWithRGB(0.99, 0.82, 0.29);
    //headview.alpha = 0.8;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius =20.0f;
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[UIImage imageNamed:@"default"]];
    [headview addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headview.mas_left).offset(20);
        make.top.mas_equalTo(headview.mas_top).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = brandTitle;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [headview addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(5);
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    UILabel *detailLabel = [[UILabel alloc]init];
    detailLabel.text = detaiTitle;
    detailLabel.textColor = [UIColor whiteColor];
    detailLabel.font = [UIFont systemFontOfSize:12];
    [headview addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headview.mas_left).offset(20);
        make.top.mas_equalTo(imageView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(140);
    }];
    detailLabel.sd_layout.autoHeightRatio(0);
    vc.headerView = headview;
    /// 指定默认选择index 页面
    vc.pageIndex = 0;
    return vc;
}

+ (NSArray *)getArrayVCs {
    BaseTableViewVC *firstVC = [[BaseTableViewVC alloc] init];
    
    firstVC.cellTitle = @"2";
    firstVC.brandID = braidIDStr;
   
    BaseTableViewVC *secondVC = [[BaseTableViewVC alloc] init];
    secondVC.cellTitle = @"1";
    secondVC.brandID = braidIDStr;

    BaseTableViewVC *thirdVC = [[BaseTableViewVC alloc] init];
    thirdVC.cellTitle =@"15";
    thirdVC.brandID = braidIDStr;
    
    BaseTableViewVC *fourVC = [[BaseTableViewVC alloc] init];
    fourVC.cellTitle = @"23";
    fourVC.brandID = braidIDStr;
    
    BaseTableViewVC *fiveVC = [[BaseTableViewVC alloc] init];
    fiveVC.cellTitle = @"33";
    fiveVC.brandID = braidIDStr;
    
   return @[firstVC, secondVC, thirdVC,fourVC,fiveVC];
}
#pragma mark - Private Function

#pragma mark - Getter and Setter
- (NSArray *)imagesURLs {
    if (!_imagesURLs) {
        _imagesURLs = @[
                        @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                        @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                        @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"];
    }
    return _imagesURLs;
}

- (NSArray *)cacheKeyArray {
    if (!_cacheKeyArray) {
        _cacheKeyArray = @[@"1", @"2", @"3",@"4",@"5"];
    }
    return _cacheKeyArray;
}
+ (NSArray *)getArrayTitles {
    return @[@"推荐", @"门类", @"锁具", @"工艺品", @"其他"];
}
#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    UIViewController *vc = pageViewController.controllersM[index];
    if ([vc isKindOfClass:[BaseTableViewVC class]]) {
        return [(BaseTableViewVC *)vc tableView];
    } else {
        return [(BaseCollectionViewVC *)vc collectionView];
    }
}
#pragma mark - YNPageViewControllerDelegate
- (void)pageViewController:(YNPageViewController *)pageViewController
            contentOffsetY:(CGFloat)contentOffset
                  progress:(CGFloat)progress {
          NSLog(@"--- contentOffset = %f,    progress = %f", contentOffset, progress);
    
    if (progress == 0) {
        self.title= @"";
    }else{
 self.title= _nameTitle;
    }
}

/// 返回列表的高度 默认是控制器的高度大小
//- (CGFloat)pageViewController:(YNPageViewController *)pageViewController heightForScrollViewAtIndex:(NSInteger)index {
//    return 400;
//}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"----click 轮播图 index %ld", index);
}

//- (NSString *)pageViewController:(YNPageViewController *)pageViewController customCacheKeyForIndex:(NSInteger)index {
//    return self.cacheKeyArray[index];
//}

- (void)pageViewController:(YNPageViewController *)pageViewController didScrollMenuItem:(UIButton *)itemButton index:(NSInteger)index {
    NSLog(@"didScrollMenuItem index %ld", index);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  [self setStatusBarBackgroundColor:font_main_color];

   [self.navigationController.navigationBar setBarTintColor:font_main_color];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self setStatusBarBackgroundColor:[UIColor whiteColor]];
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (@available(iOS 13.0, *)) {
        UIView *viewStatusColorBlend = [[UIView alloc]initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
        viewStatusColorBlend.backgroundColor = color;
        [keyWindow addSubview:viewStatusColorBlend];
    } else {
        // Fallback on earlier versions
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
           if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
               statusBar.backgroundColor = color;
           }
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
