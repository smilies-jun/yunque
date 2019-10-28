//
//  YJShopListViewController.m
//  maike
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShopListViewController.h"
#import "YJShowShopTableViewCell.h"
#import "YJShopDetailViewController.h"
#import "YJHomeViewController.h"
#import "DropMenuBar.h"
#import "ItemModel.h"
#import "MenuAction.h"
#import "YJAllShopViewController.h"
#import "YJSectionShopViewController.h"
#import "YJShopUserPostTableViewCell.h"
#import "TFPopup.h"
#import "YJHistoryViewController.h"
#import "YJShouCangViewController.h"
#import "TriangleView.h"
#import "JSCartViewController.h"
#import "YJShowShopDeatilShopingViewController.h"


@interface YJShopListViewController ()<UITableViewDataSource,UITableViewDelegate,DropMenuBarDelegate>{
    UITableView *shopListTableview;
    int page;
    NSMutableArray *dataArray;
    NSInteger sort;
    NSInteger xiaoLiangNumber;
    NSString *cataID;
    UIView *choseView;


    
}
@property (nonatomic, strong) DropMenuBar *menuScreeningView;  //条件选择器
@property (nonatomic, strong) NSMutableArray *threeuList;
@property (strong, nonatomic) TriangleView *triangle;

@end

@implementation YJShopListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.TopView.hidden = NO;
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text = _TitleStr;
    page =1;
    self.threeuList = [NSMutableArray arrayWithCapacity:0];
    sort = 2;
    xiaoLiangNumber = 2;
    cataID = 0;
    [self.RightFirstButton addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [self.RightFirstButton setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    self.RightFirstButton.hidden = YES;
     dataArray = [[NSMutableArray alloc]init];
      [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
      [self creatData];
   
}
- (void)cancelClick{
    [choseView tf_hide];
}
- (void)creatData {
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        // 三级列表
        
        for (int i = 0; i < [[result objectForKey:@"data"] count]+1; i++) {
            ItemModel *model;
            if(i == 0) {
                model = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", i] isSelect:i == 0];
            }else {
                model = [ItemModel modelWithText:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"]objectAtIndex:i-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"]objectAtIndex:i-1][@"categoryId"]] isSelect:i == 0];
                
                
                NSMutableArray *temp = [NSMutableArray array];
                for (int j = 0; j < [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"] count]+1; j++) {
                    ItemModel *layerModel;
                    if (j == 0) {
                        layerModel = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", j] isSelect:j == 0];
                    }else {
                        
                        layerModel = [ItemModel modelWithText:[NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"categoryId"]] isSelect:j == 0];
                        
                        NSMutableArray *temp2 = [NSMutableArray arrayWithCapacity:0];
                        for (int x = 0; x < [[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"] count]+1; x++) {
                            ItemModel *thirdModel;
                            if (x == 0) {
                                thirdModel = [ItemModel modelWithText:[NSString stringWithFormat:@"不限"] currentID:[NSString stringWithFormat:@"%d", x] isSelect:x == 0];
                            }else {
                                thirdModel = [ItemModel modelWithText:[NSString stringWithFormat:@"%@",[[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"]objectAtIndex:x-1][@"categoryName"]] currentID:[NSString stringWithFormat:@"%@",[[[[result objectForKey:@"data"]objectAtIndex:i-1] [@"children"]objectAtIndex:j-1][@"children"]objectAtIndex:x-1][@"categoryId"]] isSelect:x == 0];
                            }
                            [temp2 addObject:thirdModel];
                            
                        }
                        layerModel.dataSource = temp2;
                        
                        
                    }
                    [temp addObject:layerModel];
                    
                    
                }
                
                model.dataSource = temp;
            }
            
            [self.threeuList addObject:model];
            
            
        }
        [self SetUi];
    }];
    
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64+44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64-44);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    shopListTableview.tableFooterView = [UIView new];
    __weak __typeof(self) weakSelf = self;
    [shopListTableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:YES];
    }];
    
    [shopListTableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:NO];
    }];
    
    [self getNetworkData:YES];
    
    
    MenuAction *one = [MenuAction actionWithTitle:@"默认" style:MenuActionTypeCustom];
    one.tag =100;
    MenuAction *two = [MenuAction actionWithTitle:@"市场价格" style:MenuActionTypeCustom];
    two.tag = 101;
    MenuAction *four = [MenuAction actionWithTitle:@"平台销量" style:MenuActionTypeCustom];
    four.tag = 102;
    MenuAction *three = [MenuAction actionWithTitle:@"全部分类" style:MenuActionTypeList];
    three.tag = 103;
    three.ListDataSource = self.threeuList;
    three.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"3333 ==== %@", selecModel.currentID);
        self->sort = 2;
        self->xiaoLiangNumber = 2;
        self->cataID = selecModel.currentID;
        [self getNetworkData:YES];
        
    };
    self.menuScreeningView = [[DropMenuBar alloc] initWithAction:@[one,two,four,three]];
    self.menuScreeningView.delegate = self;
    self.menuScreeningView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, 40);
    self.menuScreeningView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuScreeningView];
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
    [shopListTableview.mj_header endRefreshing];
    [shopListTableview.mj_footer endRefreshing];
}
-(void)getNetworkData:(BOOL)isRefresh
{
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    if (page ==1) {
        [dataArray  removeAllObjects];
    }
    
    NSString *tokenID = NSuserUse(@"token");
    //NSString *userID = NSuserUse(@"userId");
    NSString *distributor;
    if ([cataID integerValue]) {
        
    }else{
        cataID = _cataIdStr;
    }
    if ([_distributor intValue]) {
        distributor = _distributor;
    }else{
        distributor = @"0";
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pirceSort=%ld&pageNum=%d&pageSize=20&categoryId=%@&salesVolumeSort=%ld&distributor=%@",BASE_URL,(long)sort,page,_cataIdStr,(long)xiaoLiangNumber,distributor];
    NSLog(@"ur kl == == = %@",url);
    //NSString *hotStrPOST = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                YJHotShopModel *model = [[YJHotShopModel alloc]init];
             
                model.dataDictionary = mydic;
                [self->dataArray addObject:model];
            }
            if ([[dic objectForKey:@"content"] count]) {
                [self->shopListTableview endFooterRefresh];;
                [self->shopListTableview reloadData];
            }else{
                [self->shopListTableview endFooterNoMoreData];
            }
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
}
- (void)showHistory{
    TFPopupParam *param = [TFPopupParam new];
    param.popupSize = CGSizeMake(120, 100);
    param.offset = CGPointMake(0, 64);
    param.backgroundColorClear = YES;
    choseView = [self getChoseView];
    [choseView tf_showBubble:self.view
                   basePoint:CGPointMake([UIScreen mainScreen].bounds.size.width - 20, 20)
             bubbleDirection:PopupDirectionBottomLeft
                  popupParam:param];
    
    
}
- (void)historyClick{
    YJHistoryViewController *vc = [[YJHistoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)shoucangClick{
    if ([_TypeStr integerValue] == 5) {
        JSCartViewController *vc = [[JSCartViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        
    }else{
        YJShouCangViewController *vc = [[YJShouCangViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
        
    }
   
}
- (UIView *)getChoseView{
    UIView *TypeView= [[UIView alloc]init];
    TypeView.frame = CGRectMake(0, 0, 120, 100);
    TypeView.backgroundColor = [UIColor whiteColor];
    TypeView.layer.masksToBounds = YES;
    TypeView.layer.cornerRadius = 5.0f;
    
    
    self.triangle = ({
        TriangleView *triangle = [[TriangleView alloc] initWithColor:colorWithRGB(0.33, 0.33, 0.33) style:triangleViewIsoscelesTop];
        
        triangle;
    });
    
    [TypeView addSubview:_triangle];
    
    //mas_make
    _triangle.frame =  CGRectMake(85, 0, 25, 20);
    
    
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.backgroundColor = colorWithRGB(0.33, 0.33, 0.33);
    [historyBtn setTitle:@"足迹历史" forState:UIControlStateNormal];
    historyBtn.layer.masksToBounds = YES;
    historyBtn.layer.cornerRadius = 5.0f;
    [historyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(historyClick) forControlEvents:UIControlEventTouchUpInside];
    [TypeView addSubview:historyBtn];
    [historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TypeView.mas_left);
        make.top.mas_equalTo(TypeView.mas_top).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    UIButton *shouCangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shouCangBtn addTarget:self action:@selector(shoucangClick) forControlEvents:UIControlEventTouchUpInside];
    shouCangBtn.backgroundColor = colorWithRGB(0.33, 0.33, 0.33);
    if ([_TypeStr integerValue] == 5) {
        [shouCangBtn setTitle:@"购物车" forState:UIControlStateNormal];

    }else{
        [shouCangBtn setTitle:@"上样历史" forState:UIControlStateNormal];

    }
    shouCangBtn.layer.masksToBounds = YES;
    shouCangBtn.layer.cornerRadius = 5.0f;
    [TypeView addSubview:shouCangBtn];
    [shouCangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TypeView.mas_left);
        make.top.mas_equalTo(historyBtn.mas_bottom).offset(0.5);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(39.5);
    }];
    
    return TypeView;
}
- (void)ShopListBackClick{
    if ([_resultStr integerValue] ==1) {
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJHomeViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }else{
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJAllShopViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
        for (UIViewController *controller in self.navigationController.viewControllers) {
            if ([controller isKindOfClass:[YJSectionShopViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
            }
        }
    }
   
    
    
}
#pragma mark - DropMenuBarDelegate

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action {
    if (action.actionStyle == MenuActionTypeCustom) {
        NSLog(@"即将显示");
        if (action.tag == 100) {
            sort = 2;
            xiaoLiangNumber = 2;
        }else if (action.tag == 101){
            sort = 1;
            xiaoLiangNumber = 0;
        }else{
            sort = 0;
            xiaoLiangNumber = 1;
            
        }
         [self getNetworkData:YES];
    }else{
        
    }
    
    //    if ([action.title isEqualToString:@"one"]) {
    //        // 模拟每次点击时重新获取最新数据   网络请求返回数据
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            action.ListDataSource = self.oneList;
    //            [self.menuScreeningView reloadMenus];
    //
    //        });
    //    }
    
}

- (void)dropMenuViewWillDisAppear:(DropMenuBar *)view selectAction:(MenuAction *)action {
    if (action.actionStyle == MenuActionTypeCustom) {
        NSLog(@"即将消失");
        if (action.tag == 100) {
            sort = 2;
            xiaoLiangNumber = 2;
        }else if (action.tag == 101){
            sort = 1;
            xiaoLiangNumber = 0;
        }else{
            sort = 0;
            xiaoLiangNumber = 1;
            
        }
        [self getNetworkData:YES];
    }else{
        
    }
    
}

//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return [dataArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         return 140;
    
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
            static NSString *identifier = @"showTopProidentifier";
            
            YJShowShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[YJShowShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            if (dataArray.count) {
                YJHotShopModel *model = [dataArray objectAtIndex:indexPath.row];
                cell.model = model;
                
                
            }
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;

        
    }else{
        static NSString *identifier = @"NodatBundproductidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.ImageView.image = [UIImage imageNamed:@"暂无客户"];
            // cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
            
        }
        
        //  cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   
}
- (void)ShopBtnClick:(UIButton *)btn{
    YJHotShopModel *model = [dataArray objectAtIndex:btn.tag -100];
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *upStr = [NSString stringWithFormat:@"上样"];
    NSString *url = [NSString stringWithFormat:@"%@/product/setHotOrLoad",BASE_URL];
    NSString *type;
    if ([btn.titleLabel.text isEqualToString:@"上样"]) {
        type = @"1";
    }else{
        type = @"0";
    }
    NSDictionary *dic = @{@"userId":userID,
                          @"ids":model.commodityId,
                          @"theme":upStr,
                          @"type":type,
                          };
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getNetworkData:YES];
                [AnimationView showString:@"设置成功"];
              
            });
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }


    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
     YJHotShopModel *model = [dataArray objectAtIndex:indexPath.row];
    YJShowShopDeatilShopingViewController *vc = [[YJShowShopDeatilShopingViewController alloc]init];
    vc.WebStr = [NSString stringWithFormat:@"http://h5.yzyunque.com/?token=%@&productid=%@&userid=%@",tokenID,model.commodityId,userID];
    
    vc.ShopIDStr = model.commodityId;
  [self.navigationController pushViewController:vc animated:NO];

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
