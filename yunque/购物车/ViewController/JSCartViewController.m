//
//  JSCartViewController.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartViewController.h"
#import "JSCartUIService.h"
#import "JSCartViewModel.h"
#import "JSCartBar.h"
#import "YJHomeViewController.h"
#import "JSCartModel.h"
#import "YJOrderModel.h"
#import "YJShopDetailViewController.h"
#import "YJShopListViewController.h"
#import "YJUserViewController.h"

@interface JSCartViewController ()
{
    BOOL _isIdit;
    UIBarButtonItem *_editItem;
    UIBarButtonItem *_makeDataItem;
    NSString *priceStr;
    NSArray *shopArray;
    NSString *shopId;
}
@property (nonatomic, strong) JSCartUIService *service;

@property (nonatomic, strong) JSCartViewModel *viewModel;

@property (nonatomic, strong) UITableView     *cartTableView;

@property (nonatomic, strong) JSCartBar       *cartBar;



@end

@implementation JSCartViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    /*setting up*/
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"购物车";
    self.TopTitleLabel.text = @"购物车";
    self.TopView.hidden = NO;
    /*eidit button*/
    shopArray    = [[NSArray alloc]init];
    _isIdit = NO;
     [self getNewData];
   UIButton * rightBtn = [[UIButton alloc]init];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];

    [self.TopView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.TopView.mas_right).offset(-20);
        make.top.mas_equalTo(self.TopView.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];

    /*add view*/
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.cartBar];
    
    /* RAC  */
    //全选
    [[self.cartBar.selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    //删除
    [[self.cartBar.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        [self modefiyGouWuChe];
        [self.viewModel deleteGoodsBySelect];
    }];
    //结算
    [[self.cartBar.balanceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
       // NSLog(@"x==%@",self->priceStr);
        YJShopDetailViewController  *vc = [[YJShopDetailViewController alloc]init];
        vc.shopArray = self.viewModel.cartData[0];
        self->shopArray = self.viewModel.cartData[0];
        vc.shopMoneyStr = self->priceStr;
        vc.ShopIdStr = self->shopId;
       // [self modefiyGouWuChe];
        [self.navigationController pushViewController:vc animated:NO];
    }];
    /* 观察价格属性 */
    WEAK
    [RACObserve(self.viewModel, allPrices) subscribeNext:^(NSNumber *x) {
        STRONG
        self.cartBar.money = x.floatValue;
        self->priceStr = [NSString stringWithFormat:@"%.2f",x.floatValue];
    }];
    [RACObserve(self.viewModel, deleteShopId) subscribeNext:^(NSString *x) {
       STRONG
        if ([x integerValue]){
            [self deleShop:x];
        }
       
       // self->shopArray = x;
       // NSLog(@"x = %@",x);
    }];
    /* 全选 状态 */
    RAC(self.cartBar.selectAllButton,selected) = RACObserve(self.viewModel, isSelectAll);
    
    /* 购物车数量 */
    [RACObserve(self.viewModel, cartGoodsCount) subscribeNext:^(NSNumber *x) {
       STRONG
        if(x.integerValue == 0){
            self.title = [NSString stringWithFormat:@"购物车"];
        } else {
            self.title = [NSString stringWithFormat:@"购物车(%@)",x];
        }
        
    }];
    
    
    
}
- (void)deleShop:(NSString *)str{
    NSString *userID = NSuserUse(@"userId");

    NSString *tokenID = NSuserUse(@"token");
    NSArray *MYshopArray = [[NSArray alloc]initWithObjects:str, nil];
    
    NSDictionary *dic = @{@"cartDetailIdList":MYshopArray,
                          @"userId":userID,
                          };

    NSString *url = [NSString stringWithFormat:@"%@/app/shopCart/del",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
}
- (void)modefiyGouWuChe{
    NSMutableArray *buyArray = [[NSMutableArray alloc]init];
    for (int i =0; i < shopArray.count; i++) {
        JSCartModel *model = [shopArray objectAtIndex:i];
        if (model.isSelect) {
            [buyArray addObject:model];
        }
    }
    NSMutableArray *modifyshopArray = [[NSMutableArray alloc]init];
    for (int i =0 ; i< [buyArray count]; i++) {
        JSCartModel *model = [buyArray objectAtIndex:i];
        [modifyshopArray addObject:model.p_product_id];
        
    }
    NSString *userID = NSuserUse(@"userId");
    NSString *tokenID = NSuserUse(@"token");
    NSDictionary *dic = @{@"cartDetailIdList":modifyshopArray,
                          @"userId":userID,
                        };
    NSString *url = [NSString stringWithFormat:@"%@/app/shopCart/del",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {

        if ([[result objectForKey:@"code"]integerValue] == 200) {
          
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
#pragma mark - lazy load

- (JSCartViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[JSCartViewModel alloc] init];
        _viewModel.cartVC = self;
        _viewModel.cartTableView  = self.cartTableView;
    }
    return _viewModel;
}


- (JSCartUIService *)service{
    
    if (!_service) {
        _service = [[JSCartUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}


- (UITableView *)cartTableView{
    
    if (!_cartTableView) {
        
        _cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight + 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)
                                                      style:UITableViewStyleGrouped];
        [_cartTableView registerNib:[UINib nibWithNibName:@"JSCartCell" bundle:nil]
             forCellReuseIdentifier:@"JSCartCell"];
        [_cartTableView registerClass:NSClassFromString(@"JSCartFooterView") forHeaderFooterViewReuseIdentifier:@"JSCartFooterView"];
        [_cartTableView registerClass:NSClassFromString(@"JSCartHeaderView") forHeaderFooterViewReuseIdentifier:@"JSCartHeaderView"];
        _cartTableView.dataSource = self.service;
        _cartTableView.delegate   = self.service;
        _cartTableView.backgroundColor = XNColor(240, 240, 240, 1);
        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XNWindowWidth, 50)];
    }
    return _cartTableView;
}

- (JSCartBar *)cartBar{
    
    if (!_cartBar) {
        _cartBar = [[JSCartBar alloc] initWithFrame:CGRectMake(0, XNWindowHeight-50, XNWindowWidth, 50)];
        _cartBar.isNormalState = YES;
    }
    return _cartBar;
}

#pragma mark - method

- (void)getNewData{
    /**
     *  获取数据
//     */
    NSString *userID = NSuserUse(@"userId");
    NSString *url = [NSString stringWithFormat:@"%@/app/shopCart/queryShoppingCart?userId=%@",BASE_URL,userID];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->shopId = [[result objectForKey:@"data"]objectForKey:@"cartId"];
        self.viewModel.DataArray =[[result objectForKey:@"data"]objectForKey:@"cartDetailVOS"];
        [self.viewModel getData];
        [self.cartTableView reloadData];
    }];
  
}

- (void)rightClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected) {
        //点击编辑的时候清空删除数组
        [btn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    _isIdit = !_isIdit;
   // NSString *itemTitle = _isIdit == YES?@"完成":@"编辑";
   // _editItem.title = itemTitle;
    self.cartBar.isNormalState = !_isIdit;
}

- (void)makeNewData:(UIBarButtonItem *)item{
    
    [self getNewData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   //  [self getNewData];
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

@end
