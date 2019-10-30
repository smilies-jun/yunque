//
//  YJHomeViewController.m
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJShowShopTableViewCell.h"
#import "YJLoginAndReginViewController.h"
#import "YJShopListViewController.h"
#import "YJUserShopSetViewController.h"
#import "YJAllShopViewController.h"
#import "YJShopSetDetailViewController.h"
#import "YJSectionShopViewController.h"
#import "PYSearch.h"
#import "YJSearchResultViewController.h"
#import "YJShopDetailViewController.h"
#import "YJHotShopModel.h"
#import "JSCartViewController.h"
#import "YJShowShopDeatilShopingViewController.h"
#import "SDCycleScrollView.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface YJHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate,EVNCustomSearchBarDelegate,PYSearchViewControllerDelegate,SDCycleScrollViewDelegate>{
    PYSearchViewController *searchViewController;
    NSMutableArray *DataArray;
    NSMutableArray *cateIDArray;
    NSMutableArray *titleArray;
    NSMutableArray *cateIDArray2;
    NSMutableArray *titleArray2;
    NSMutableArray *cateIDArray3;
    NSMutableArray *titleArray3;
    NSMutableArray *cateIDArray4;
    NSMutableArray *titleArray4;
    NSMutableArray *cateIDArray5;
    NSMutableArray *titleArray5;
    
    NSString *shopNameStr;
    int page;
    
    NSMutableArray *imageMuArray;
    NSMutableArray *urlArray ;
}
//shop列表N
@property (nonatomic,strong)UITableView *ShopTableView;

@property (nonatomic, copy) NSArray *imagesURLs;

//九宫格
@property(nonatomic,strong) UIView *ShopTopView;

@property(nonatomic,strong) UILabel *AdressLabel;
@end

@implementation YJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"迈克杭州总店";
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                                    //  NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    self.view.backgroundColor = [UIColor whiteColor];
    self.TopView.hidden = NO;
    self.TopView.backgroundColor = [UIColor whiteColor];
    self.BackButton.hidden = YES;
    self.RightSecondButton.hidden = NO;
    [self.RightFirstButton setBackgroundImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
    [self.RightFirstButton addTarget:self action:@selector(ShopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.RightSecondButton setBackgroundImage:[UIImage imageNamed:@"sousuoing"] forState:UIControlStateNormal];
    self.RightSecondButton.hidden = YES;
    [self.RightSecondButton addTarget:self action:@selector(SouSuoClick) forControlEvents:UIControlEventTouchUpInside];
    self.YJsearchBar.hidden = YES;
    self.YJsearchBar.iconImage = [UIImage imageNamed:@"SouSuo"];
  
    self.YJsearchBar.textFieldColor = colorWithRGB(0.4, 0.46, 1);
    self.YJsearchBar.textColor = [UIColor whiteColor];
    [self.YJsearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.RightFirstButton.mas_left);
        make.top.mas_equalTo(self.TopView.mas_top).offset(10);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(80);
    }];
    UILabel *MyHomeLabel = [[UILabel alloc]init];
    MyHomeLabel.text = @"云鹊";
    MyHomeLabel.textColor = [UIColor blackColor];
    MyHomeLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.TopView addSubview:MyHomeLabel];
    [MyHomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.TopView.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    
   imageMuArray = [[NSMutableArray alloc]init];
    urlArray = [[NSMutableArray alloc]init];
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/banner/applist",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            NSArray *myarray = [result objectForKey:@"data"];
            for (NSDictionary *mydic in myarray) {
                [self->imageMuArray addObject:[mydic objectForKey:@"imgUrl"]];
                [self->urlArray addObject:[mydic objectForKey:@"url"]];
    }
    [self refreshUserData];
    }];
    cateIDArray = [[NSMutableArray alloc]init];
    titleArray = [[NSMutableArray alloc]init];
    cateIDArray2 = [[NSMutableArray alloc]init];
    titleArray2 = [[NSMutableArray alloc]init];
    cateIDArray3 = [[NSMutableArray alloc]init];
    titleArray3 = [[NSMutableArray alloc]init];
    cateIDArray4 = [[NSMutableArray alloc]init];
    titleArray4 = [[NSMutableArray alloc]init];
    cateIDArray5 = [[NSMutableArray alloc]init];
    titleArray5 = [[NSMutableArray alloc]init];
  
   
    DataArray = [[NSMutableArray alloc]init];
    page = 1;
  
}
- (void)refreshUserData{
     [self reoadDate];
      
}
#pragma mark - Getter and Setter
- (NSArray *)imagesURLs {
   // if (!_imagesURLs) {
     
        
        
       
   // }
    return imageMuArray;
}
- (void)reoadDate{
   
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        NSArray *myarray = [result objectForKey:@"data"];
            for (int i =0; i < myarray.count; i++) {
                NSMutableArray *childArray = [NSMutableArray new];
                childArray = [[myarray objectAtIndex:i]objectForKey:@"children"];
                if (i==0) {
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==1){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray2 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray2 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==2){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray3 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray3 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }else if (i==3){
                    for (int j =0; j < childArray.count; j++) {
                        [self->cateIDArray4 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
                        [self->titleArray4 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
                    }
                }
//                }else{
//                    for (int j =0; j < childArray.count; j++) {
//                        [self->cateIDArray5 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryId"]];
//                        [self->titleArray5 addObject:[[childArray objectAtIndex:j] objectForKey:@"categoryName"]];
//                    }
//                }
            }
         
           

        [self refreshUI];

    }];
}

- (void)refreshUI{
    NSString *tokenID = NSuserUse(@"token");
    
    NSString *UserInfourl = [NSString stringWithFormat:@"%@/client/userInfo",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:UserInfourl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        //self->userDic =[result objectForKey:@"data"];
        //[self SetUi];
        self->shopNameStr = [[result objectForKey:@"data"]objectForKey:@"shopName"];
        NSuserSave([[result objectForKey:@"data"]objectForKey:@"status"], @"status");
        [self SetUI];
    }];
}
- (void)ShopClick{
    JSCartViewController *vc = [[JSCartViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)SouSuoClick{
    NSArray *hotSeaches = @[@"同门", @"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门"];
    // 2. Create a search view controller
    searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"搜索门类", @"搜索搜索门类") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [self dismissViewControllerAnimated:NO completion:^{
            YJShopListViewController *vc = [[YJShopListViewController alloc]init];
            vc.resultStr = @"1";
            NSString *type = NSuserUse(@"type");
            vc.TypeStr = type;
            [self.navigationController pushViewController:vc animated:NO];
        }];
        
        // [searchViewController.navigationController pushViewController:[[YJShopListViewController alloc] init] animated:YES];
    }];
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
    searchViewController.delegate = self;
    [searchViewController.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchViewController.cancelButton setTintColor:colorWithRGB(0.91, 0.91, 0.91)];
    searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowDefault;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}
#pragma mark - 懒加载
//九宫格
- (UIView *)ShopTopView{
    if (!_ShopTopView) {
        _ShopTopView = [[UIView alloc]init];
        _ShopTopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
        _ShopTopView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
      
       
        UIButton *DoorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [DoorBtn setBackgroundImage:[UIImage imageNamed:@"门类"] forState:UIControlStateNormal];
        DoorBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        DoorBtn.tag = 100;
        [DoorBtn addTarget:self action:@selector(DoorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ShopTopView addSubview:DoorBtn];
        [DoorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iPhoneXAndXS) {
                make.left.mas_equalTo(_ShopTopView.mas_left).offset(35);
            }else if (iPhoneXRAndXSMAX){
                  make.left.mas_equalTo(_ShopTopView.mas_left).offset(35);
            }else{
                make.left.mas_equalTo(_ShopTopView.mas_left).offset(25);
            }
            make.top.mas_equalTo(_ShopTopView.mas_top).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        UILabel * dorLabel = [[UILabel alloc]init];
        dorLabel.text = @"门类";
        dorLabel.textAlignment = NSTextAlignmentCenter;
        dorLabel.font = [UIFont systemFontOfSize:13];
        [_ShopTopView addSubview:dorLabel];
        [dorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(DoorBtn.mas_centerX);
            make.top.mas_equalTo(DoorBtn.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        
        
        UIButton *Door1Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Door1Btn setBackgroundImage:[UIImage imageNamed:@"锁具"] forState:UIControlStateNormal];
        Door1Btn.titleLabel.font = [UIFont systemFontOfSize:16];
        Door1Btn.tag = 101;
        [Door1Btn addTarget:self action:@selector(DoorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ShopTopView addSubview:Door1Btn];
        [Door1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iPhoneXAndXS) {
                           make.left.mas_equalTo(DoorBtn.mas_right).offset(25);

            }else if (iPhoneXRAndXSMAX){
                  make.left.mas_equalTo(DoorBtn.mas_right).offset(35);
            }
            else{
                  make.left.mas_equalTo(DoorBtn.mas_right).offset(25);

              }
            make.top.mas_equalTo(_ShopTopView.mas_top).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        UILabel * dor1Label = [[UILabel alloc]init];
        dor1Label.text = @"锁具";
        dor1Label.textAlignment = NSTextAlignmentCenter;
        dor1Label.font = [UIFont systemFontOfSize:13];
        [_ShopTopView addSubview:dor1Label];
        [dor1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(Door1Btn.mas_centerX);
            make.top.mas_equalTo(Door1Btn.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        UIButton *Door2Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Door2Btn setBackgroundImage:[UIImage imageNamed:@"工艺品"] forState:UIControlStateNormal];
        Door2Btn.titleLabel.font = [UIFont systemFontOfSize:16];
        Door2Btn.tag = 102;
        [Door2Btn addTarget:self action:@selector(DoorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_ShopTopView addSubview:Door2Btn];
        [Door2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
             if (iPhoneXAndXS) {
                           make.left.mas_equalTo(Door1Btn.mas_right).offset(25);

                       }else if (iPhoneXRAndXSMAX){
                             make.left.mas_equalTo(Door1Btn.mas_right).offset(35);
                       }else{
                           make.left.mas_equalTo(Door1Btn.mas_right).offset(25);

                       }
            make.top.mas_equalTo(_ShopTopView.mas_top).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        UILabel * dor2Label = [[UILabel alloc]init];
        dor2Label.text = @"工艺品";
        dor2Label.textAlignment = NSTextAlignmentCenter;
        dor2Label.font = [UIFont systemFontOfSize:13];
        [_ShopTopView addSubview:dor2Label];
        [dor2Label mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(Door2Btn.mas_centerX);
            make.top.mas_equalTo(Door2Btn.mas_bottom).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
        UIButton *Door3Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Door3Btn setBackgroundImage:[UIImage imageNamed:@"全部分类"] forState:UIControlStateNormal];
        Door3Btn.titleLabel.font = [UIFont systemFontOfSize:16];
        Door3Btn.tag = 103;
        [Door3Btn addTarget:self action:@selector(allShopClick) forControlEvents:UIControlEventTouchUpInside];
        [_ShopTopView addSubview:Door3Btn];
        [Door3Btn mas_makeConstraints:^(MASConstraintMaker *make) {
             if (iPhoneXAndXS) {
                           make.left.mas_equalTo(Door2Btn.mas_right).offset(25);

                       }else if (iPhoneXRAndXSMAX){
                             make.left.mas_equalTo(Door2Btn.mas_right).offset(35);
                       }else{
                           make.left.mas_equalTo(Door2Btn.mas_right).offset(25);

                       }
            make.top.mas_equalTo(_ShopTopView.mas_top).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        UILabel * dor3Label = [[UILabel alloc]init];
        dor3Label.text = @"全部分类";
        dor3Label.textAlignment = NSTextAlignmentCenter;
        dor3Label.font = [UIFont systemFontOfSize:13];
        [_ShopTopView addSubview:dor3Label];
        [dor3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(Door3Btn.mas_centerX);
            make.top.mas_equalTo(Door3Btn.mas_bottom).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
            }];
        
        
        UIButton *allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       [allBtn setBackgroundImage:[UIImage imageNamed:@"邀请好友卡片"] forState:UIControlStateNormal];
       [allBtn addTarget:self action:@selector(shareMyShop) forControlEvents:UIControlEventTouchUpInside];
       [_ShopTopView addSubview:allBtn];
       [allBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(_ShopTopView.mas_left).offset(25);
           make.top.mas_equalTo(dor3Label.mas_bottom).offset(20);
             if (iPhoneXAndXS) {
                make.width.mas_equalTo(218/2);
                make.height.mas_equalTo(132/2);
             }else if (iPhoneXRAndXSMAX){
                 make.width.mas_equalTo(230/2);
                 make.height.mas_equalTo(140/2);
             }else{
                  make.width.mas_equalTo(218/2-10);
                make.height.mas_equalTo(132/2-10);
                        }
          

       }];
        UIButton *dingzhiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           [dingzhiBtn setBackgroundImage:[UIImage imageNamed:@"量身定制卡片"] forState:UIControlStateNormal];
           [dingzhiBtn addTarget:self action:@selector(SetShopClick) forControlEvents:UIControlEventTouchUpInside];
           [_ShopTopView addSubview:dingzhiBtn];
           [dingzhiBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(allBtn.mas_right).offset(10);
               make.top.mas_equalTo(dor3Label.mas_bottom).offset(20);
                if (iPhoneXAndXS) {
                                           make.width.mas_equalTo(218/2);
                                          make.height.mas_equalTo(132/2);
                                      }else if (iPhoneXRAndXSMAX){
                                          make.width.mas_equalTo(230/2);
                                          make.height.mas_equalTo(140/2);
                                      }else{
                                           make.width.mas_equalTo(218/2-10);
                                           make.height.mas_equalTo(132/2-10);
                                      }

           }];
        UIButton *qidaiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
           [qidaiBtn setBackgroundImage:[UIImage imageNamed:@"敬请期待卡片"] forState:UIControlStateNormal];
           [qidaiBtn addTarget:self action:@selector(noMoreClick) forControlEvents:UIControlEventTouchUpInside];
           [_ShopTopView addSubview:qidaiBtn];
           [qidaiBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(dingzhiBtn.mas_right).offset(10);
               make.top.mas_equalTo(dor3Label.mas_bottom).offset(20);
                 if (iPhoneXAndXS) {
                                            make.width.mas_equalTo(218/2);
                                           make.height.mas_equalTo(132/2);
                                       }else if (iPhoneXRAndXSMAX){
                                        make.width.mas_equalTo(230/2);
                                        make.height.mas_equalTo(140/2);
                                       }else{
                                            make.width.mas_equalTo(218/2-10);
                                            make.height.mas_equalTo(132/2-10);
                                       }

           }];
       UILabel *HotLabel = [[UILabel alloc]init];
       HotLabel.text = @"云鹊甄选";
       HotLabel.textAlignment = NSTextAlignmentLeft;
       HotLabel.font = [UIFont systemFontOfSize:18];
       [_ShopTopView addSubview:HotLabel];
       [HotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(_ShopTopView.mas_left).offset(20);
           make.top.mas_equalTo(allBtn.mas_bottom).offset(20);
           make.width.mas_equalTo(160);
           make.height.mas_equalTo(20);
       }];



    }
    
    return _ShopTopView;
    
}
- (void)shareMyShop{
      [AnimationView showString:@"邀请好友功能"];
//    NSArray* imageArray = @[[UIImage imageNamed:@"logo.jpg"]];
//       //（注意：图片可以是UIImage对象，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//       NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//       [shareParams SSDKSetupShareParamsByText:@"云鹊的分享"
//                                        images:imageArray
//                                           url:[NSURL URLWithString:@"http://baidu.com"]
//                                         title:@"分享标题"
//                                          type:SSDKContentTypeAuto];
//       [ShareSDK showShareActionSheet:nil
//                          customItems:nil
//                          shareParams:shareParams
//                   sheetConfiguration:nil
//                       onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                           switch (state) {
//                               case SSDKResponseStateSuccess:
//                               {
//                                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                       message:nil
//                                                                                      delegate:nil
//                                                                             cancelButtonTitle:@"确定"
//                                                                             otherButtonTitles:nil];
//                                   [alertView show];
//                                   break;
//                               }
//                               case SSDKResponseStateFail:
//                               {
//                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                                   message:[NSString stringWithFormat:@"%@",error]
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"OK"
//                                                                         otherButtonTitles:nil, nil];
//                                   [alert show];
//                                   break;
//                               }
//                               default:
//                                   break;
//                           }
//                       }];
       
}
- (void)noMoreClick{
    [AnimationView showString:@"敬请期待"];
}
- (UIView *)ScrollView{
    SDCycleScrollView *autoScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200) imageURLStringsGroup:self.imagesURLs];
    autoScrollView.delegate = self;
    return autoScrollView;
}
- (void)SetUI{
    _ShopTableView = [[UITableView alloc]init];
    _ShopTableView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64-60);
    _ShopTableView.delegate = self;
    _ShopTableView.dataSource = self;
    _ShopTableView.tableFooterView = [UIView new];
    [self.view addSubview:_ShopTableView];
    __weak __typeof(self) weakSelf = self;
    [_ShopTableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:YES];
    }];
    
    [_ShopTableView addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:NO];
    }];
     [self getNetworkData:YES];
  
}
- (void)loadoneNew{
    [self getNetworkData:YES];
    
}
- (void)loadoneMore{
    [self getNetworkData:NO];
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [_ShopTableView.mj_header endRefreshing];
    [_ShopTableView.mj_footer endRefreshing];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    if (page ==1) {
        [DataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *hotStr = [NSString stringWithFormat:@"热销"];
    NSString *url = [NSString stringWithFormat:@"%@/product/groupProdcutQury",BASE_URL];
    NSDictionary *dic;
    if ([userID integerValue]) {
        dic = @{@"pageNum":[NSNumber numberWithInteger:page],
                              @"pageSize":[NSNumber numberWithInteger:10],
                              @"userId":userID,
                              @"groupName":hotStr,
                              };

        [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                NSDictionary *dic = [result objectForKey:@"data"];
                for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                    YJHotShopModel *model = [[YJHotShopModel alloc]init];
                    model.dataDictionary = mydic;
                    [self->DataArray addObject:model];
                }
                if ([[dic objectForKey:@"content"] count]) {
                    [self->_ShopTableView endFooterRefresh];;
                    [self->_ShopTableView reloadData];
                }else{
                    [self->_ShopTableView endFooterNoMoreData];
                }
                
            }else{
                [AnimationView showString:[result objectForKey:@"errmsg"]];
            }
            
            
        }];
    }
    //  NSString *hotStrPOST = [hotStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
 
   
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
             return [self ScrollView];
             break;
        case 1:
            return self.ShopTopView;
            break;
        default:
            return nil;
            break;
    }
    
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        if (DataArray.count) {
            return DataArray.count;
        }
        return 0;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
         return 240;
    }else if (section == 0){
        return 200;
    }else{
         return 0;
    }
   
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return 140;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        static NSString *identifier = @"YetTopProidentifier";
        
        YJShowShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[YJShowShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell configUI:indexPath];
        }
    if ([DataArray count]) {
        YJHotShopModel *Model =[DataArray objectAtIndex:indexPath.row];
        cell.model = Model;
    }
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
        return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (DataArray.count) {
        YJHotShopModel *Model =[DataArray objectAtIndex:indexPath.row];
        NSString *tokenID = NSuserUse(@"token");
        NSString *userID = NSuserUse(@"userId");
        YJShowShopDeatilShopingViewController *vc= [[YJShowShopDeatilShopingViewController alloc]init];
        vc.WebStr = [NSString stringWithFormat:@"http://h5.yzyunque.com/?token=%@&productid=%@&userid=%@",tokenID,Model.commodityId,userID];
        vc.ShopIDStr = Model.commodityId;
        [self.navigationController   pushViewController:vc animated:NO];
    }
    
    
   
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)allShopClick{
    YJAllShopViewController *vc = [[YJAllShopViewController alloc]init];
    vc.titleArray = titleArray;
    vc.cataIDArray = cateIDArray;
    
    vc.titleArray2 = titleArray2;
    vc.cataIDArray2 = cateIDArray2;
    vc.titleArray3 = titleArray3;
    vc.cataIDArray3 = cateIDArray3;
    vc.titleArray4 = titleArray4;
    vc.cataIDArray4 = cateIDArray4;
//    vc.titleArray5 = titleArray5;
//    vc.cataIDArray5 = cateIDArray5;
    
    [self.navigationController   pushViewController:vc animated:NO];
}
- (void)SetShopClick{
    YJUserShopSetViewController *vc= [[YJUserShopSetViewController alloc]init];
    [self.navigationController   pushViewController:vc animated:NO];
}
- (void)DoorBtnClick:(UIButton *)btn{
    YJSectionShopViewController *vc = [[YJSectionShopViewController alloc]init];
    if (btn.tag - 100 == 0) {
        vc.cataIDArray = cateIDArray;
        vc.titleArray = titleArray;
        vc.titleStr = @"门类";
    }else if (btn.tag- 100 == 1){
        vc.cataIDArray = cateIDArray2;
        vc.titleArray = titleArray2;
        vc.titleStr = @"锁具";
    }else if (btn.tag- 100 == 2){
        vc.cataIDArray = cateIDArray3;
        vc.titleArray = titleArray3;
        vc.titleStr = @"工艺品";
    }else if (btn.tag- 100 == 3){
        vc.cataIDArray = cateIDArray4;
        vc.titleArray = titleArray4;
        vc.titleStr = @"其他";
        
    }
//    }else{
//        vc.cataIDArray = cateIDArray5;
//        vc.titleArray = titleArray5;
//        vc.titleStr = @"工艺品";
//    }
    [self.navigationController pushViewController:vc animated:NO];
   
}
#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
        
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self HideKeyBoardClick];
    //[self getNetworkData:YES];
    //searchViewController.hidesBottomBarWhenPushed = YES;
   //[self setStatusBarBackgroundColor:colorWithRGB(0.25, 0.33, 1.0)];
    NSString *tokenID = NSuserUse(@"token");
    NSString *Status = NSuserUse(@"status");
    NSString *UserInfourl = [NSString stringWithFormat:@"%@/client/userInfo",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:nil withUrl:UserInfourl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        //self->userDic =[result objectForKey:@"data"];
        //[self SetUi];
        if ([[result objectForKey:@"code"] integerValue]==200) {
            self->shopNameStr = [[result objectForKey:@"data"]objectForKey:@"shopName"];
                 //  NSuserSave([[result objectForKey:@"data"]objectForKey:@"shopName"], @"shopName");
                   NSuserSave([[result objectForKey:@"data"]objectForKey:@"status"], @"status");
        }
       
    }];
   
    if (tokenID.length) {
        if ([Status integerValue]==1) {
            if ([self.navigationController.topViewController isMemberOfClass:[self class]]) {
                YJLoginAndReginViewController *loginVC = [[YJLoginAndReginViewController alloc] init];
                UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
                loginNagition.navigationBarHidden = YES;
               loginNagition.modalPresentationStyle = 0;
                [self presentViewController:loginNagition animated:NO completion:nil];
            }
           
        }else{
            
        }
    }else{
        if ([self.navigationController.topViewController isMemberOfClass:[self class]]) {
            YJLoginAndReginViewController *loginVC = [[YJLoginAndReginViewController alloc] init];
            UINavigationController *loginNagition = [[UINavigationController alloc]initWithRootViewController:loginVC];
            loginNagition.navigationBarHidden = YES;
            loginNagition.modalPresentationStyle = 0;
            [self presentViewController:loginNagition animated:NO completion:nil];
        }
      
    }
}
- (BOOL)dismissAllKeyBoard:(UIView *)view{
    
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
}

#pragma mark: EVNCustomSearchBar delegate method
- (BOOL)searchBarShouldBeginEditing:(EVNCustomSearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(EVNCustomSearchBar *)searchBar
{
    NSArray *hotSeaches = @[@"同门", @"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门",@"同门"];
    // 2. Create a search view controller
    searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"搜索门类", @"搜索搜索r门类") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [self dismissViewControllerAnimated:NO completion:^{
            YJShopListViewController *vc = [[YJShopListViewController alloc]init];
            vc.resultStr = @"1";
            NSString *type = NSuserUse(@"type");
            vc.TypeStr = type;
            [self.navigationController pushViewController:vc animated:NO];
        }];
       
       // [searchViewController.navigationController pushViewController:[[YJShopListViewController alloc] init] animated:YES];
    }];
     searchViewController.searchHistoryStyle = PYSearchHistoryStyleBorderTag;
     searchViewController.delegate = self;
    [searchViewController.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [searchViewController.cancelButton setTintColor:colorWithRGB(0.91, 0.91, 0.91)];
     searchViewController.searchViewControllerShowMode = PYSearchViewControllerShowDefault;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
//    if (searchText.length) {
//        // Simulate a send request to get a search suggestions
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
//            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
//                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
//                [searchSuggestionsM addObject:searchSuggestion];
//            }
//            // Refresh and display the search suggustions
//            searchViewController.searchSuggestions = searchSuggestionsM;
//        });
//    }
}


- (BOOL)searchBarShouldEndEditing:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
    return YES;
}

- (void)searchBarTextDidEndEditing:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)searchBar:(EVNCustomSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (BOOL)searchBar:(EVNCustomSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
    return YES;
}

- (void)searchBarSearchButtonClicked:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)searchBarCancelButtonClicked:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.YJsearchBar resignFirstResponder];
}

#pragma mark: UISearchResultsUpdating Method
#pragma mark 监听者搜索框中的值的变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 1. 获取输入的值
    //self.inputText = self.searchBar.text;
    //    [self afn1];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    YJShowShopDeatilShopingViewController *vc= [[YJShowShopDeatilShopingViewController alloc]init];
    vc.WebStr = [NSString stringWithFormat:@"%@",[urlArray objectAtIndex:index]];
    vc.TitleStr = @"活动页面";
    vc.TypeStr = @"1";
    [self.navigationController   pushViewController:vc animated:NO];
}

@end
