//
//  YJPinPaiViewController.m
//  yunque
//
//  Created by Apple on 2019/10/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPinPaiViewController.h"
#import "YJPinPaiDetailViewController.h"
#import "FCCollectionHeaderView.h"
#import "FCCollectionFooterView.h"
#import "YJNewShopCollectionViewCell.h"
#import "YJPinPaiTableViewCell.h"
#import "YJPinPaiModel.h"
#import "UIView+SDAutoLayout.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

@interface YJPinPaiViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>{
    int page;
}
@property (strong, nonatomic) UICollectionView *collectionView;//容器视图
@property (strong, nonatomic) UITableView *ShopTableView;//容器视图
@property (nonatomic, strong) NSMutableArray *modelsArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *listArray;

@property (nonatomic, strong) NSString *brandId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *detailTitle;
@property (nonatomic, strong) NSString *BrandTitle;
@end

@implementation YJPinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.navigationController.navigationBarHidden = NO;
    //设置状态栏与到导航栏都是不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置状态栏与到导航栏背景色都是橙色
    //self.title = @"发现";
    self.view.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);
     UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [returnBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
      [returnBtn setTitle:@"发现" forState:UIControlStateNormal];
      returnBtn.frame = CGRectMake(0, 0, 40, 30);
    //  [returnBtn addTarget:self action:@selector(clickReturnBtn) forControlEvents:UIControlEventTouchUpInside];
      UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc]initWithCustomView:returnBtn];
      self.navigationItem.leftBarButtonItem = itemBtn;
    //[_ShopTableView registerClass:[YJPinPaiTableViewCell class] forCellReuseIdentifier:@"yjpinpaicelll"];
    _dataArray = [[NSMutableArray alloc]init];
    _listArray = [[NSMutableArray alloc]init];
    [self intUI];
}
- (void)intUI{
    //创建布局对象
    UILabel *label = [[UILabel alloc]init];
    label.text = @"推荐品牌";
    label.font =[UIFont boldSystemFontOfSize:14];
    label.frame = CGRectMake(20, 20, 80, 20);
    [self.view addSubview:label];
    
       UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
       //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
       layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
       //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
       layout.headerReferenceSize = CGSizeMake(0, 0);
       layout.footerReferenceSize = CGSizeMake(0, 0);
       //创建容器视图
       UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, StatusBarHeight+40, SCREEN_WIDTH,  100) collectionViewLayout:layout];
       collectionView.delegate=self;//设置代理
       collectionView.dataSource=self;//设置数据源
       collectionView.backgroundColor = colorWithRGB(0.97, 0.97, 0.97);//设置背景，默认为黑色
       //添加到主视图
       [self.view addSubview:collectionView];
       self.collectionView = collectionView;
       
       //注册容器视图中显示的方块视图
       [collectionView registerClass:[YJNewShopCollectionViewCell class] forCellWithReuseIdentifier:[YJNewShopCollectionViewCell cellIdentifier]];
       
       //注册容器视图中显示的顶部视图
       [collectionView registerClass:[FCCollectionHeaderView class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:[FCCollectionHeaderView headerViewIdentifier]];
       
       //注册容器视图中显示的底部视图
       [collectionView registerClass:[FCCollectionFooterView class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                 withReuseIdentifier:[FCCollectionFooterView footerViewIdentifier]];
    
        _ShopTableView = [[UITableView alloc]init];
        _ShopTableView.frame = CGRectMake(0, StatusBarHeight+100+40, SCREEN_WIDTH, SCREEN_HEIGHT-100-StatusBarHeight-40);
       _ShopTableView.delegate = self;
       _ShopTableView.dataSource = self;
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
    [self refreshData];
    
    
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
- (void)refreshData{
    NSString *url;
    NSString *tokenID = NSuserUse(@"token")
    url = [NSString stringWithFormat:@"%@/brand/brandList",BASE_URL];
        [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
           // NSLog(@"re === %@",result);
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                NSDictionary *dic = [result objectForKey:@"data"];
                for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                    YJPinPaiModel *model = [[YJPinPaiModel alloc]init];
                    model.dataDictionary = mydic;
                    [self->_dataArray addObject:model];
                }
                YJPinPaiModel *model = [self->_dataArray objectAtIndex:0];
                self->_brandId = model.brandId;
                self->_imageUrl = model.icon;
                self->_detailTitle = model.brandDescription;
                self->_BrandTitle = model.brandName;
                [self.collectionView reloadData];
                [self getNetworkData:YES];
            }else{
                [AnimationView showString:[result objectForKey:@"errmsg"]];
            }
    
    
        }];
}

-(void)getNetworkData:(BOOL)isRefresh
{
    NSString *tokenID = NSuserUse(@"token");

    NSString *url;
    if (isRefresh) {
        page = 1;
        url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?page=1&pageSize=20&brandId=%@",BASE_URL,_brandId];
    }else{
        page++;
        url = [NSString stringWithFormat:@"%@/product/queryAllBybrandID?page=%d&pageSize=20&brandId=%@",BASE_URL,page,_brandId];
    }
    if (page ==1) {
        [_listArray removeAllObjects];
    }
   
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        // NSLog(@"re === %@",result);
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            NSDictionary *dic = [result objectForKey:@"data"];
            for (NSDictionary *mydic in [dic objectForKey:@"content"]) {
                
                YJPinPaiModel *model = [[YJPinPaiModel alloc]init];
                model.dataDictionary = mydic;
                [self->_listArray addObject:model];
            }
            if ([[dic objectForKey:@"content"] count]) {
                [self->_ShopTableView    endFooterRefresh];;
                [self->_ShopTableView reloadData];
            }else{
                [self->_ShopTableView endFooterNoMoreData];
            }

        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }


    }];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
     普通版也可实现一步设置搞定高度自适应，不再推荐使用此套方法，具体参看“UITableView+SDAutoTableViewCellHeight”头文件
    [self.tableView startAutoCellHeightWithCellClasses:@[[DemoVC7Cell class], [DemoVC7Cell2 class]] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
     */
    if (self.listArray.count) {
        return self.listArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *cellID = @"yjpinpaicelll";
    
    if (self.listArray.count) {
        YJPinPaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
         if (cell == nil) {
               cell = [[YJPinPaiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
         
             }
        
        cell.model = self.listArray[indexPath.row];
         
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.listArray.count) {
        YJPinPaiModel *model = self.listArray[indexPath.row];
          UILabel * _atest = [[UILabel alloc]initWithFrame:CGRectZero];
          _atest.text = model.productAdvanta;
          _atest.font = [UIFont systemFontOfSize:12];
          _atest.numberOfLines = 0;
          _atest.lineBreakMode = NSLineBreakByWordWrapping;
         CGSize baseSize = CGSizeMake(SCREEN_WIDTH - 40, CGFLOAT_MAX);
         CGSize labelsize = [_atest sizeThatFits:baseSize];
        _atest.height = labelsize.height;
          return labelsize.height + 140 + 40 + 20;
    }
    return SCREEN_HEIGHT - 64;
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = nil;
    
      vc = [YJPinPaiDetailViewController suspendCenterPageVC:_brandId imageUrl:_imageUrl detailTitle:_detailTitle brandTitle:_BrandTitle];
       
    
      [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    YJNewShopCollectionViewCell *cell=[YJNewShopCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    YJPinPaiModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.brandName;
    [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.icon]] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
    
    return cell;
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //获取顶部视图
        FCCollectionHeaderView *headerView=[FCCollectionHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
        
        //设置顶部视图属性
        headerView.backgroundColor=[UIColor whiteColor];
        headerView.textLabel.text = [NSString stringWithFormat:@"-Header-%ld-",indexPath.section];
        
        return headerView;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        //获取底部视图
        FCCollectionFooterView *footerView=[FCCollectionFooterView footerViewWithCollectionView:collectionView forIndexPath:indexPath];
        
        //设置底部视图属性
        footerView.backgroundColor=[UIColor whiteColor];
        footerView.textLabel.text = [NSString stringWithFormat:@"-Footer-%ld-",indexPath.section];
        return footerView;
        
    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 80;
    CGFloat height = 100;
    return CGSizeMake(width, height);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    // [choseView tf_hide];
//    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
//        [self.delegate didSelectItemAtIndexPath:indexPath withContent:[NSString stringWithFormat:@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row]];
//    }
    YJPinPaiModel *model = [_dataArray objectAtIndex:indexPath.row];
    _brandId = model.brandId;
    _imageUrl = model.brandIcon;
    _detailTitle = model.brandDescription;
    _BrandTitle = model.brandName;
    [self getNetworkData:YES];
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
- (void)ShopListBackClick{
     
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
     [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}
@end
