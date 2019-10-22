//
//  YJSectionShopViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJSectionShopViewController.h"
#import "FCCollectionHeaderView.h"
#import "FCCollectionFooterView.h"
#import "YJPhoneImageCollectionViewCell.h"
#import "ALLBtnTableViewCell.h"
#import "YJSectionDetailViewController.h"
#import "YJShopListViewController.h"

@interface YJSectionShopViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>{
    UITableView *allShopTableview;
    NSInteger indexRow;
    NSString *cataID;
    NSArray *dataArray;
    NSString *cataIdStr;

   
    

}
@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@end

@implementation YJSectionShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //注册通知(接收,监听,一个通知)
    self.TopView.hidden = NO;
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text = _titleStr;
    self.YJsearchBar.iconImage = [UIImage imageNamed:@"搜索"];
    indexRow = 0;
    dataArray = [[NSArray alloc]init];
    [self reoadDate:[_cataIDArray objectAtIndex:0]];
    [self SetUI];
}
- (void)reoadDate:(NSString *)cataIDStr{
   NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass?categoryId=%@",BASE_URL,cataIDStr];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->dataArray = [result objectForKey:@"data"];
        [self->_collectionView reloadData];
    }];
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)SetUI{
    
    allShopTableview = [[UITableView alloc]init];
    allShopTableview.delegate = self;
    allShopTableview.dataSource = self;
    allShopTableview.backgroundColor = colorWithRGB(0.93, 0.93,0.93 );
    allShopTableview.frame = CGRectMake(0, StatusBarHeight+64, 80, SCREEN_HEIGHT-StatusBarHeight - 64);
    [self.view addSubview:allShopTableview];
    //创建布局对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //创建容器视图
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(80, StatusBarHeight+64, SCREEN_WIDTH-80, SCREEN_HEIGHT - 80) collectionViewLayout:layout];
    collectionView.delegate=self;//设置代理
    collectionView.dataSource=self;//设置数据源
    collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
    //添加到主视图
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    //注册容器视图中显示的方块视图
    [collectionView registerClass:[YJPhoneImageCollectionViewCell class] forCellWithReuseIdentifier:[YJPhoneImageCollectionViewCell cellIdentifier]];
    
    //注册容器视图中显示的顶部视图
    [collectionView registerClass:[FCCollectionHeaderView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:[FCCollectionHeaderView headerViewIdentifier]];
    
    //注册容器视图中显示的底部视图
    [collectionView registerClass:[FCCollectionFooterView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
              withReuseIdentifier:[FCCollectionFooterView footerViewIdentifier]];
}
//实现方法
-(void)notification2:(NSNotification *)noti{
    
    //使用object处理消息
    NSString *info = [noti object];
    NSLog(@"接收 object传递的消息：%@",info);
    
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [dataArray count];
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    YJPhoneImageCollectionViewCell *cell=[YJPhoneImageCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.contentView.backgroundColor=[UIColor whiteColor];
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];
    NSString *urlStr = [dic objectForKey:@"categoryImage"];
    [cell.shopImageView  sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
    cell.textLabel.text = [dic objectForKey:@"categoryName"];
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
    CGFloat height = 110;
    return CGSizeMake(width, height);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
//    YJSectionDetailViewController *vc = [[YJSectionDetailViewController alloc]init];
//    NSString *type = NSuserUse(@"type");
//    vc.TypeStr = type;
//
//    vc.cataIdStr =[dic objectForKey:@"categoryId"];
//    vc.TitleStr =[dic objectForKey:@"categoryName"];
//    [self.navigationController pushViewController:vc animated:NO];
//    // [choseView tf_hide];
    NSDictionary *dic = [dataArray objectAtIndex:indexPath.row];

    YJShopListViewController *vc = [[YJShopListViewController alloc]init];
      NSString *type = NSuserUse(@"type");
      vc.TypeStr = type;
      vc.cataIdStr =[dic objectForKey:@"categoryId"];
      vc.TitleStr =[dic objectForKey:@"categoryName"];
      [self.navigationController pushViewController:vc animated:NO];
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
    
    return 60;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"YJbtnuProidentifier";
    
    ALLBtnTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ALLBtnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    cell.btnLabel.text = [_titleArray objectAtIndex:indexPath.row];
    if (indexPath.row == indexRow) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.btnLabel.textColor  = font_main_color;

        cell.lineImageView.hidden = NO;
    }else{
        cell.lineImageView.hidden = YES;
        cell.btnLabel.textColor  = [UIColor blackColor];

        cell.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //  [cell.EditBtn addTarget:self action:@selector(editTableview) forControlEvents:UIControlEventTouchUpInside];
    //cell.backgroundColor = [UIColor whiteColor];
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    indexRow = indexPath.row;
    cataID = [_cataIDArray objectAtIndex:indexPath.row];
    [self reoadDate:cataID];
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
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
