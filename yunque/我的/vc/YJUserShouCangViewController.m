//
//  YJUserShouCangViewController.m
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserShouCangViewController.h"
#import "YJShowShopTableViewCell.h"
#import "UserAdresssTableViewCell.h"
#import "ShopTableViewCell.h"
#import "BottomView.h"

@interface YJUserShouCangViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    int page;
    NSMutableArray *dataArray;
    UIButton *rightBtn;
    
}
@property (nonatomic ,strong) NSMutableArray *deleteArray;//删除的数据
@property (nonatomic ,assign) BOOL isInsertEdit;//tableview编辑方式的判断
@property (nonatomic ,strong) BottomView *bottom_view;//底部视图

@end

@implementation YJUserShouCangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"我的收藏";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    rightBtn = [[UIButton alloc]init];
    rightBtn.backgroundColor = [UIColor whiteColor];
    rightBtn.hidden = YES;
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    page = 1;
    dataArray = [[NSMutableArray alloc]init];
    self.RightFirstButton.hidden = YES;
    [self SetUi];
}
- (NSMutableArray *)deleteArray{
    if (!_deleteArray) {
        self.deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

- (BottomView *)bottom_view{
    if (!_bottom_view) {
        self.bottom_view = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, 50)];
        _bottom_view.backgroundColor = font_main_color;
        [_bottom_view.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
        [_bottom_view.allBtn addTarget:self action:@selector(tapAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom_view;
}
/**
 删除数据方法
 */
- (void)deleteData{
    if (self.deleteArray.count >0) {
        [dataArray removeObjectsInArray:self.deleteArray];
        [shopListTableview reloadData];
    }
    
}
- (void)rightClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        //点击编辑的时候清空删除数组
        [self.deleteArray removeAllObjects];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        _isInsertEdit = YES;//这个时候是全选模式
        [shopListTableview setEditing:YES animated:YES];
        
        //如果在全选状态下，点击完成，再次进来的时候需要改变按钮的文字和点击状态
        if (_bottom_view.allBtn.selected) {
            _bottom_view.allBtn.selected = !_bottom_view.allBtn.selected;
            [_bottom_view.allBtn setTitle:@"全选" forState:UIControlStateNormal];
        }
        
        //添加底部视图
        CGRect frame = self.bottom_view.frame;
        frame.origin.y -= 50;
        [UIView animateWithDuration:0.5 animations:^{
            self.bottom_view.frame = frame;
            [self.view addSubview:self.bottom_view];
        }];
        
        
        
        
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        _isInsertEdit = NO;
        [shopListTableview setEditing:NO animated:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            CGPoint point = self.bottom_view.center;
            point.y      += 50;
            self.bottom_view.center   = point;
            
        } completion:^(BOOL finished) {
            [self.bottom_view removeFromSuperview];
        }];
    }
}
- (void)SetUi{
//    _mysearchBar = [[EVNCustomSearchBar alloc] initWithFrame:CGRectMake(20, StatusBarHeight+64, SCREEN_WIDTH-40, 44)];
//
//    _mysearchBar.backgroundColor = [UIColor clearColor]; // 清空searchBar的背景色
//    //_YJsearchBar.iconImage = [UIImage imageNamed:@"SouSuo"];
//    //        _searchBar.iconImage = [UIImage imageNamed:@"EVNCustomSearchBar.bundle/searchImageTextColor.png"];
//    _mysearchBar.iconAlign = EVNCustomSearchBarIconAlignLeft;
//    [_mysearchBar setPlaceholder:@"请输入关键字"];  // 搜索框的占位符
//    _mysearchBar.iconImage = [UIImage imageNamed:@"搜索"];
//    //_YJsearchBar.placeholderColor = TextGrayColor;
//    _mysearchBar.delegate = self; // 设置代理
//    _mysearchBar.isHiddenCancelButton = YES;
//
//    [_mysearchBar sizeToFit];
//    [self.view addSubview:_mysearchBar];
    
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarHeight-64);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    [self.view addSubview:shopListTableview];
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
    
//    if (isRefresh) {
//        page = 1;
//    }else{
//        page++;
//    }
//    if (page ==1) {
//        [dataArray  removeAllObjects];
//    }
    [dataArray removeAllObjects];
    NSString *tokenID = NSuserUse(@"token");
    NSString *userID = NSuserUse(@"userId");
    NSString *url = [NSString stringWithFormat:@"%@/product/queryFavorite?userId=%@",BASE_URL,userID];
    //  NSString *hotStrPOST = [hotStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            //NSDictionary *dic = [result objectForKey:@"data"];
            NSArray *array = [result objectForKey:@"data"];
            if (array.count) {
                for (NSDictionary *mydic in array) {
                    YJHotShopModel *model = [[YJHotShopModel alloc]init];
                    model.dataDictionary = mydic;
                    [self->dataArray addObject:model];
                }
            }
           
            
            if ([array count]) {
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
- (void)tapAllBtn:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        for (int i = 0; i< dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            //全选实现方法
            [shopListTableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }
        
        //点击全选的时候需要清除deleteArray里面的数据，防止deleteArray里面的数据和列表数据不一致
        if (self.deleteArray.count >0) {
            [self.deleteArray removeAllObjects];
        }
        [self.deleteArray addObjectsFromArray:dataArray];
        
        [btn setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        
        //取消选中
        for (int i = 0; i< dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [shopListTableview deselectRowAtIndexPath:indexPath animated:NO];
            
        }
        
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.deleteArray removeAllObjects];
    }
    
    
    //    NSLog(@"+++++%ld",self.deleteArray.count);
    //    NSLog(@"===%@",self.deleteArray);
    
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
    if (dataArray.count) {
        return 140;
    }
    return SCREEN_HEIGHT - 60;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count) {
    static NSString *identifier = @"shoucangProidentifier";
    
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
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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
    //正常状态下，点击cell进入跳转下一页
    //在编辑模式下点击cell 是选中数据
    if (rightBtn.selected) {
        NSLog(@"选中");
        [self.deleteArray addObject:[dataArray objectAtIndex:indexPath.row]];
        
    }else{
        NSLog(@"跳转下一页");
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (rightBtn.selected) {
        NSLog(@"撤销");
        [self.deleteArray removeObject:[dataArray objectAtIndex:indexPath.row]];
        
    }else{
        NSLog(@"取消跳转");
    }
    
    
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据不同状态返回不同编辑模式
    if (_isInsertEdit) {
        
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
        
    }else{
        
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    //左滑删除数据方法
    //    if (editingStyle == UITableViewCellEditingStyleDelete) {
    //        [self.dataArray removeObjectAtIndex: indexPath.row];
    //        [self.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
    //                              withRowAnimation:UITableViewRowAnimationFade];
    //        [self.tableView reloadData];
    //
    //    }
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
