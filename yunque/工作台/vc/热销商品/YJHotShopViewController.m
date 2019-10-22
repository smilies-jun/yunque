//
//  YJHotShopViewController.m
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJHotShopViewController.h"
#import "WSDropMenuView.h"
#import "YJSetHotShopTableViewCell.h"
#import "TFPopup.h"
#import "DropMenuBar.h"
#import "ItemModel.h"
#import "MenuAction.h"
#import "YJHotShopModel.h"
#import "YJShowShopTableViewCell.h"
#import "YJShopUserPostTableViewCell.h"

@interface YJHotShopViewController ()<UITableViewDataSource,UITableViewDelegate,DropMenuBarDelegate>{
    UITableView *shophotListTableview;
    UIButton *moneyBtn;
    UIButton *allBtn;
    UIView *moneyView;
    UIView *allView;
    int page;
    NSInteger sort;
    NSInteger xiaoLiangNumber;
    NSString *cataID;

    NSMutableArray *dataArray;
    
}
@property (nonatomic, strong) NSMutableArray *threeuList;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;  //条件选择器
@end

@implementation YJHotShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
//    UIButton *rightBtn = [[UIButton alloc]init];
//    rightBtn.backgroundColor = [UIColor whiteColor];
//    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//
//    [self.TopView addSubview:rightBtn];
//    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
//        make.top.mas_equalTo(self.TopView.mas_top).offset(20);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(20);
//    }];
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"热销设置";
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.threeuList = [NSMutableArray arrayWithCapacity:0];
    page = 1;
    sort = 2;
    xiaoLiangNumber = 2;
    cataID = 0;
    dataArray = [[NSMutableArray alloc]init];
     [self creatData];
    
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
//- (void)rightClick:(UIButton *)btn{
//    btn.selected = !btn.selected;
//    if (btn.selected) {
//        //点击编辑的时候清空删除数组
//       // [self.deleteArray removeAllObjects];
//        [btn setTitle:@"完成" forState:UIControlStateNormal];
//       // _isInsertEdit = YES;//这个时候是全选模式
//        [shophotListTableview setEditing:YES animated:YES];
//
//        //如果在全选状态下，点击完成，再次进来的时候需要改变按钮的文字和点击状态
////        if (_bottom_view.allBtn.selected) {
////            _bottom_view.allBtn.selected = !_bottom_view.allBtn.selected;
////            [_bottom_view.allBtn setTitle:@"全选" forState:UIControlStateNormal];
////        }
//
//        //添加底部视图
////        CGRect frame = self.bottom_view.frame;
////        frame.origin.y -= 50;
////        [UIView animateWithDuration:0.5 animations:^{
////            self.bottom_view.frame = frame;
////            [self.view addSubview:self.bottom_view];
////        }];
//
//
//
//    }else{
//        [btn setTitle:@"编辑" forState:UIControlStateNormal];
//       // _isInsertEdit = NO;
//        [shophotListTableview setEditing:NO animated:YES];
//
////        [UIView animateWithDuration:0.5 animations:^{
////            CGPoint point = self.bottom_view.center;
////            point.y      += 50;
////            self.bottom_view.center   = point;
////
////        } completion:^(BOOL finished) {
////            [self.bottom_view removeFromSuperview];
////        }];
//    }
//
//}
- (void)SetUi{
//     _searchBar= [[EVNCustomSearchBar alloc] initWithFrame:CGRectMake(20, StatusBarHeight+64, SCREEN_WIDTH-40, 44)];
//    _searchBar.backgroundColor = [UIColor clearColor]; // 清空searchBar的背景色
//    //_YJsearchBar.iconImage = [UIImage imageNamed:@"SouSuo"];
//     _searchBar.iconImage = [UIImage imageNamed:@"搜索"];
//    _searchBar.iconAlign = EVNCustomSearchBarIconAlignLeft;
//    [_searchBar setPlaceholder:@"请输入关键字"];  // 搜索框的占位符
//    //_YJsearchBar.placeholderColor = TextGrayColor;
//    _searchBar.delegate = self; // 设置代理
//    _searchBar.isHiddenCancelButton = YES;
//
//    [_searchBar sizeToFit];
//    [self.view addSubview:_searchBar];
//
    shophotListTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, StatusBarHeight+64+44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64-44) style:UITableViewStylePlain];;
    shophotListTableview.delegate = self;
    shophotListTableview.dataSource = self;
   // shophotListTableview.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:shophotListTableview];
    __weak __typeof(self) weakSelf = self;
    [shophotListTableview addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:YES];
    }];
    
    [shophotListTableview addFooterWithWithHeaderWithAutomaticallyRefresh:NO loadMoreBlock:^(NSInteger pageIndex) {
        NSLog(@"pageIndex:%zd",pageIndex);
        //weakSelf.page = pageIndex;
        [weakSelf getNetworkData:NO];
    }];
    
    [self getNetworkData:YES];
    
    
    MenuAction *one = [MenuAction actionWithTitle:@"市场价" style:MenuActionTypeCustom];


    MenuAction *three = [MenuAction actionWithTitle:@"全部分类" style:MenuActionTypeList];

    three.ListDataSource = self.threeuList;
    three.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        NSLog(@"3333 ==== %@", selecModel.currentID);
        self->sort = 2;
        self->xiaoLiangNumber = 2;
        self->cataID = selecModel.currentID;
        [self getNetworkData:YES];
    };
    self.menuScreeningView = [[DropMenuBar alloc] initWithAction:@[one,three]];
    self.menuScreeningView.delegate = self;
    self.menuScreeningView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, 40);
    self.menuScreeningView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuScreeningView];
    
   // WSDropMenuView *dropMenu = [[WSDropMenuView alloc] initWithFrame:CGRectMake(0, StatusBarHeight+64+44, SCREEN_WIDTH, 40)];
    
    
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
    [shophotListTableview.mj_header endRefreshing];
    [shophotListTableview.mj_footer endRefreshing];
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
    NSString *url;
    NSString *userID = NSuserUse(@"userId");

    NSString *tokenID = NSuserUse(@"token");

    if ([cataID integerValue]) {
         url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pirceSort=%ld&pageNum=%d&pageSize=20&shelfSort=2&shelf=1&categoryId=%@&salesVolumeSort=%ld&userId=%@&shelf=1",BASE_URL,(long)sort,page,cataID,(long)xiaoLiangNumber,userID];
    }else{
         url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?pirceSort=%ld&pageNum=%d&pageSize=20&shelfSort=2&shelf=1&salesVolumeSort=%ld&userId=%@&shelf=1",BASE_URL,(long)sort,page,(long)xiaoLiangNumber,userID];
    }
    NSLog(@"url = %@",url);
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
                [self->shophotListTableview endFooterRefresh];;
                [self->shophotListTableview reloadData];
            }else{
                [self->shophotListTableview endFooterNoMoreData];
            }
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
}
#pragma mark - DropMenuBarDelegate

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action {
    if (action.actionStyle == MenuActionTypeCustom) {
        NSLog(@"即将显示");
    
        sort = 1;
        xiaoLiangNumber = 2;
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
       
            sort = 0;
            xiaoLiangNumber = 2;
            
        [self getNetworkData:YES];
    }else{
        
    }
    
}
}




#pragma mark - WSDropMenuView Delegate -

- (void)dropMenuView:(WSDropMenuView *)dropMenuView didSelectWithIndexPath:(WSIndexPath *)indexPath{
    
    
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArray.count) {
        return dataArray.count;
    }
    return 1;
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
    if ([_TypeStr integerValue] ==5) {
        return 140;
    }else{
        return 140 + 70;
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
        if ([_TypeStr integerValue] == 5) {
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
            static NSString *identifier = @"showUPTopProidentifier";
            
            YJShopUserPostTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[YJShopUserPostTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell configUI:indexPath];
            }
            if (dataArray.count) {
                YJHotShopModel *model = [dataArray objectAtIndex:indexPath.row];
                cell.model = model;
                if ([model.isHot integerValue]) {
                    [cell.UpShopButton setTitle:@"取消热销" forState:UIControlStateNormal];
                    [cell.UpShopButton setBackgroundColor:font_main_color];
                }else{
                    [cell.UpShopButton setBackgroundColor:font_main_color];
                    [cell.UpShopButton setTitle:@"设置热销" forState:UIControlStateNormal];
                }
            }
            cell.UpShopButton.tag = 100 +indexPath.row;
            [cell.UpShopButton addTarget:self action:@selector(ShopBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.backgroundColor = [UIColor whiteColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }
    }else{
        static NSString *identifier = @"NodatHotListBundproductidentifier";
        
        NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            [cell configUI:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.NameLabel.text = @"暂时没有物品";
            cell.ImageView.image = [UIImage imageNamed:@"搜索列表为空"];
            // cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
            
        }
        
        //  cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
   
}
- (void)ShopBtnClick:(UIButton *)btn{
    if (dataArray.count) {
        YJHotShopModel *model = [dataArray objectAtIndex:btn.tag -100];
        NSString *tokenID = NSuserUse(@"token");
        NSString *userID = NSuserUse(@"userId");
        NSString *upStr = [NSString stringWithFormat:@"热销"];
        NSString *url = [NSString stringWithFormat:@"%@/product/setHotOrLoad",BASE_URL];
        NSString *type;
        if ([btn.titleLabel.text isEqualToString:@"设置热销"]) {
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
            //  NSLog(@"re == %@",result);
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
 
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//}
//-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return @"删除";
//}
//
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//     return UITableViewCellEditingStyleDelete;
//}

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
