//
//  YJUserSetViewController.m
//  maike
//
//  Created by Apple on 2019/8/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetViewController.h"
#import "YJSetDetailTableViewCell.h"
#import "YJModefiyPassWordViewController.h"
#import "YJPeopleMessageViewController.h"
#import "YJProViewController.h"

@interface YJUserSetViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *shopListTableview;
    UILabel *moneyLabel;
    UIButton *sureBtn;
    
}

@end

@implementation YJUserSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self SetUi];
}
- (void)SetUi{
    shopListTableview = [[UITableView alloc]init];
    shopListTableview.frame = CGRectMake(0, StatusBarHeight+64+1, SCREEN_WIDTH, 240);
    shopListTableview.delegate = self;
    shopListTableview.dataSource = self;
    shopListTableview.tableFooterView = [UIView new];
    [self.view addSubview:shopListTableview];
    
    
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(LoginClearBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self->shopListTableview.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
    
}
/**
 *  清除所有的存储本地的数据
 */
- (void)clearAllUserDefaultsData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (id  key in dic) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
    
}
-(void)LoginClearBtn{
    [AnimationView showString:@"退出登录，请重新登录"];
    [self clearAllUserDefaultsData];
    [self rdv_tabBarController].selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
   
}
- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
    
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
    
    static NSString *identifier = @"detailProidentifier";
    
    YJSetDetailTableViewCell   *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[YJSetDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell configUI:indexPath];
    }
    switch (indexPath.row) {
        case 0:
            cell.NameLabel.text = @"修改密码";
            break;
        case 1:
            cell.NameLabel.text = @"清理缓存";
            break;
        case 2:
            cell.NameLabel.text = @"意见反馈";
            break;
        case 3:
            cell.NameLabel.text = @"关于我们";
            break;
        default:
            break;
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        YJModefiyPassWordViewController *vc = [[YJModefiyPassWordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 2){
        YJPeopleMessageViewController *vc = [[YJPeopleMessageViewController alloc]init];
        [self.navigationController pushViewController:vc animated:NO];
    }else if (indexPath.row == 3){
        YJProViewController *vc = [[YJProViewController alloc]init];
        vc.WebStr = @"http://h5.yzyunque.com/";
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        [self clearAPP];
         [AnimationView showString:@"清理成功"];
    }
   
}
- (void)clearAPP{
    //清理结果的信息
    NSString *message = nil;//提示文字
    BOOL clearSuccess = YES;//是否删除成功
    NSError *error = nil;//错误信息
    
    //构建需要删除的文件或文件夹的路径，这里以Documents为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPathArray)
    {
        //如果是数据库文件，不做操作
        if ([subPath isEqualToString:@"mySql.sqlite"])
        {
            continue;
        }
        
        NSString *filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error)
        {
            message = [NSString stringWithFormat:@"%@这个路径的文件夹删除失败了",filePath];
            clearSuccess = NO;
        }
        else
        {
            message = @"成功了";
            [AnimationView showString:@"清理成功"];
        }
    }
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
