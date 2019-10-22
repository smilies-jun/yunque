//
//  YJUserShopSetViewController.m
//  maike
//
//  Created by Apple on 2019/7/26.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserShopSetViewController.h"
#import "YJUserShopTableViewCell.h"


#import "YJShopDetailViewController.h"
#import "YJShopSetDetailViewController.h"
#import "YJUpShopViewController.h"
#import "YJUserSetDetailViewController.h"
#import "YJHotShopModel.h"

#import "YBImageBrowser.h"
#import "ItemModel.h"
#import "MenuAction.h"
#import "DropMenuBar.h"


@interface YJUserShopSetViewController ()<UITableViewDataSource,UITableViewDelegate,DropMenuBarDelegate>{
    UITableView *shopListTableview;
    NSArray *imageArray;
    NSMutableArray *imageViewArray;
    NSInteger currentIndex;
    NSMutableArray *DataArray;
    NSInteger createTimeDesc;
    NSInteger sellingPriceDesc;
    NSString *categoryIds;
    NSString *keyWordStr;
    int page;
    
}
@property (nonatomic, strong) NSMutableArray *threeuList;
@property (nonatomic, strong) DropMenuBar *menuScreeningView;  //条件选择器
@end

@implementation YJUserShopSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text = @"定制商品";
    self.YJsearchBar.delegate = self;
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-15);
        make.top.mas_equalTo(self.TopView.mas_top).offset(25);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
     DataArray = [[NSMutableArray alloc]init];
    self.threeuList = [NSMutableArray arrayWithCapacity:0];
    page = 1;
    createTimeDesc = 0;
    sellingPriceDesc = 0;
    categoryIds = @"";
    keyWordStr  = @"";
    [self creatData];
   
    imageViewArray = [[NSMutableArray alloc]init];
   
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
- (void)rightClick{
    YJShopSetDetailViewController *vc = [[YJShopSetDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64+44, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64-44-40);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
    __weak __typeof(self) weakSelf = self;
     [self getNetworkData:YES];
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
    
   
    MenuAction *one = [MenuAction actionWithTitle:@"销售价格" style:MenuActionTypeCustom];
    one.tag = 100;
     MenuAction *two = [MenuAction actionWithTitle:@"创建时间" style:MenuActionTypeCustom];
    two.tag = 101;
    MenuAction *three = [MenuAction actionWithTitle:@"全部分类" style:MenuActionTypeList];
    
    three.ListDataSource = self.threeuList;
    three.didSelectedMenuResult = ^(NSInteger index, ItemModel *selecModel) {
        if ([selecModel.currentID integerValue]) {
             self->categoryIds = selecModel.currentID;
        }else{
            self->categoryIds = @"";
        }
       

 
        [self getNetworkData:YES];
    };
    self.menuScreeningView = [[DropMenuBar alloc] initWithAction:@[one,two,three]];
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
    NSString *tokenID = NSuserUse(@"token");
    
    NSString *url;
    if (isRefresh) {
        page = 1;
    }else{
        page++;
    }
    if (page ==1) {
        [DataArray removeAllObjects];
    }
    url = [NSString stringWithFormat:@"%@/diy/appDiyProductlist",BASE_URL];
    NSDictionary *dic =[[NSDictionary alloc]init];
    if (categoryIds.length) {
        dic = @{@"page":[NSNumber numberWithInteger:page],
                @"pageSize":[NSNumber numberWithInteger:10],
                @"createTimeDesc":[NSNumber numberWithInteger:createTimeDesc],
                @"sellingPriceDesc":[NSNumber numberWithInteger:sellingPriceDesc],
                @"categoryIds":categoryIds
                };
    }else{
        if (keyWordStr.length) {
            dic = @{@"page":[NSNumber numberWithInteger:page],
                    @"pageSize":[NSNumber numberWithInteger:10],
                    @"createTimeDesc":[NSNumber numberWithInteger:createTimeDesc],
                    @"sellingPriceDesc":[NSNumber numberWithInteger:sellingPriceDesc],
                    @"keyWord":keyWordStr
                    };
        }else{
            dic = @{@"page":[NSNumber numberWithInteger:page],
                    @"pageSize":[NSNumber numberWithInteger:10],
                    @"createTimeDesc":[NSNumber numberWithInteger:createTimeDesc],
                    @"sellingPriceDesc":[NSNumber numberWithInteger:sellingPriceDesc]
                    };
        }
    }
    [[DateSource sharedInstance]requestHomeWithParameters:dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                YJHotShopModel *model = [[YJHotShopModel alloc]init];
                model.dataDictionary = mydic;
                [self->DataArray addObject:model];
            }
            if ([[dic objectForKey:@"content"] count]) {
                [self->shopListTableview endFooterRefresh];;
               
            }else{
                [self->shopListTableview endFooterNoMoreData];
            }
             [self->shopListTableview reloadData];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
        
    }];
    
}
#pragma mark - DropMenuBarDelegate

- (void)dropMenuViewWillAppear:(DropMenuBar *)view selectAction:(MenuAction *)action {
    if (action.actionStyle == MenuActionTypeCustom) {
        if (action.tag == 100) {
            sellingPriceDesc = 0;
        }else{
            createTimeDesc = 0;
        }
        
        
    }
    [self getNetworkData:YES];

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
        if (action.tag == 100) {
            sellingPriceDesc = 1;
        }else{
            createTimeDesc = 1;
        }
    }
     [self getNetworkData:YES];

    
}

- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (DataArray.count) {
        return DataArray.count;
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
    if (DataArray.count) {
         return [YJUserShopTableViewCell whc_CellHeightForIndexPath:indexPath shopModel:[DataArray objectAtIndex:indexPath.row]];
    }else{
        return SCREEN_HEIGHT - 60;
    }
   
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     if (DataArray.count) {
    static NSString *identifier = @"showUserSetyshopTopProidentifier";
    
    YJUserShopTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJUserShopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
//    cell.UserSetFirstImageView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *firstTap = [[UITapGestureRecognizer  alloc]initWithTarget:self action:@selector(ImageClick)];
//    [cell.UserSetFirstImageView addGestureRecognizer:firstTap];
//    cell.backgroundColor = [UIColor whiteColor];
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (DataArray.count) {
        YJHotShopModel *model = [DataArray objectAtIndex:indexPath.row];
        cell.shopModel = model;
    }
    


    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([DataArray count]) {
        YJUserSetDetailViewController *vc = [[YJUserSetDetailViewController alloc]init];
        YJHotShopModel *model = [DataArray objectAtIndex:indexPath.row];
        vc.diyModelId = model.diyModelId;
        vc.Type = model.pcategory;
        [self.navigationController pushViewController:vc animated:NO];
    }
   
}

//图片点击放大
- (void)ImageClick{
    NSMutableArray *datas = [NSMutableArray array];

    [imageArray enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YBIBImageData *data = [YBIBImageData new];
            data.imageURL = [NSURL URLWithString:obj];
            //data.projectiveView = [self viewAtIndex:idx];
            [datas addObject:data];

    }];
    YBImageBrowser *browser = [YBImageBrowser new];
    browser.dataSourceArray = datas;
    browser.currentPage = 0;
    [browser show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self setStatusBarBackgroundColor:[UIColor whiteColor]];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
