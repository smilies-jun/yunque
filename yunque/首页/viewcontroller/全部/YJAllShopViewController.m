//
//  YJAllShopViewController.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAllShopViewController.h"
#import "DNSPageView_ObjC.h"

#import "YJMenPeiViewController.h"
#import "YJChuanViewController.h"
#import "YJChuanViewController.h"
#import "YJSuoViewController.h"
#import "YJGongYiViewController.h"
#import "YJDoorViewController.h"
#import "ALLBtnTableViewCell.h"



@interface YJAllShopViewController ()<UITableViewDelegate,UITableViewDataSource>{
    DNSPageView *pageView;
    UITableView *allShopTableview;
    NSInteger indexRow;
    DNSPageStyle *style;
}

@end

@implementation YJAllShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.YJsearchBar.hidden = YES;
    self.TopTitleLabel.text=  @"全部商品";
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification1:) name:@"secindex" object:nil];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    indexRow = 0;
    [self CreateUI];
    
}
//实现方法
-(void)notification1:(NSNotification *)noti{
    
    //使用object处理消息
    NSString *info = [noti object];
    NSLog(@"接收 object传递的消息：%@",info);
    [allShopTableview reloadData];
    
}



- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)CreateUI{
    style = [[DNSPageStyle alloc] init];
    style.titleViewScrollEnabled = YES;
    style.titleScaleEnabled = YES;
    style.titleFont = [UIFont systemFontOfSize:14];
    style.titleColor = colorWithRGB(0.56, 0.56, 0.56);
    style.titleSelectedColor = font_main_color;
    style.showBottomLine = YES;
    style.titleMargin = 60;
    style.bottomLineColor = font_main_color;
    
    // 设置标题内容
    NSArray <NSString *>*titles = @[@"门类", @"锁具 ",@"工艺品",@"其他"];
    
  
    YJDoorViewController *door = [[YJDoorViewController alloc] init];
    door.distributor = _distributor ;
    door.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:door];
    
    YJMenPeiViewController *pei = [[YJMenPeiViewController alloc] init];
    pei.view.backgroundColor = [UIColor whiteColor];
    pei.distributor = _distributor ;
    [self addChildViewController:pei];
    
    YJChuanViewController *chuang = [[YJChuanViewController alloc] init];
    chuang.view.backgroundColor = [UIColor whiteColor ];
    chuang.distributor = _distributor ;
    [self addChildViewController:chuang];
    
    YJSuoViewController *suo = [[YJSuoViewController alloc] init];
    suo.view.backgroundColor = [UIColor whiteColor];
    suo.distributor = _distributor ;
    [self addChildViewController:suo];
    
//    YJGongYiViewController   *yi = [[YJGongYiViewController alloc] init];
//    yi.view.backgroundColor = [UIColor whiteColor];
//    [self addChildViewController:yi];
    
    // 创建对应的DNSPageView，并设置它的frame
    pageView = [[DNSPageView alloc] initWithFrame:CGRectMake(0, kGHSafeAreaTopHeight+20, SCREEN_WIDTH, SCREEN_HEIGHT- 64) style:style titles:titles childViewControllers:self.childViewControllers startIndex:0];
    [self.view addSubview:pageView];
    allShopTableview = [[UITableView alloc]init];
    allShopTableview.delegate = self;
    allShopTableview.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    allShopTableview.dataSource = self;
   // NSIndexPath *selectindex = [NSIndexPath indexPathForRow:0 inSection:0];
   // [allShopTableview   selectRowAtIndexPath:selectindex animated:NO scrollPosition:UITableViewScrollPositionNone];
    allShopTableview.tableFooterView = [UIView new];
    allShopTableview.frame = CGRectMake(0, StatusBarHeight+64+44, 80, SCREEN_HEIGHT-StatusBarHeight - 64-44);
    [self.view addSubview:allShopTableview];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger secIndex =pageView.titleView.currentIndex;
    if (secIndex==0) {
        return [_titleArray count];
    }else if (secIndex == 1){
      return   [_titleArray2 count];
    }else if (secIndex == 2){
       return  [_titleArray3 count];
    }else{
      return   [_titleArray4 count];
    }
//    }else{
//       return  [_titleArray5 count];
//    }
    
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
    NSInteger secIndex =pageView.titleView.currentIndex;
    if (secIndex==0) {
        cell.btnLabel.text = [_titleArray objectAtIndex:indexPath.row];
    }else if (secIndex == 1){
         cell.btnLabel.text = [_titleArray2 objectAtIndex:indexPath.row];
    }else if (secIndex == 2){
         cell.btnLabel.text = [_titleArray3 objectAtIndex:indexPath.row];
    }else{
         cell.btnLabel.text = [_titleArray4 objectAtIndex:indexPath.row];
    }
    
    //  [cell.EditBtn addTarget:self action:@selector(editTableview) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == indexRow) {
         cell.backgroundColor = [UIColor whiteColor];
        cell.lineImageView.hidden = NO;
        cell.btnLabel.textColor  = font_main_color;
    }else{
         cell.lineImageView.hidden = YES;
        cell.btnLabel.textColor  = [UIColor blackColor];

         cell.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger secIndex =pageView.titleView.currentIndex;
    if (secIndex==0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"door1" object:[NSString stringWithFormat:@"%@",[_cataIDArray objectAtIndex:indexPath.row]]];
    }else if (secIndex == 1){
         [[NSNotificationCenter defaultCenter] postNotificationName:@"door2" object:[NSString stringWithFormat:@"%@",[_cataIDArray2 objectAtIndex:indexPath.row]]];
    }else if (secIndex == 2){
         [[NSNotificationCenter defaultCenter] postNotificationName:@"door3" object:[NSString stringWithFormat:@"%@",[_cataIDArray3 objectAtIndex:indexPath.row]]];
    }else{
         [[NSNotificationCenter defaultCenter] postNotificationName:@"door4" object:[NSString stringWithFormat:@"%@",[_cataIDArray4 objectAtIndex:indexPath.row]]];
    }
//    else{
//         [[NSNotificationCenter defaultCenter] postNotificationName:@"door5" object:[NSString stringWithFormat:@"%@",[_cataIDArray5 objectAtIndex:indexPath.row]]];
//    }
    indexRow = indexPath.row;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
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
