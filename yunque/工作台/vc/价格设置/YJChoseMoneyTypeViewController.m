//
//  YJChoseMoneyTypeViewController.m
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJChoseMoneyTypeViewController.h"
#import "RATreeView.h"
#import "RADataObject.h"
#import "YJChoseMoneyTypeTableViewCell.h"
#import "RATableViewCell.h"
#import "YJChoseShopView.h"
#import "YJModifyMoneyViewController.h"

@interface YJChoseMoneyTypeViewController ()<RATreeViewDelegate, RATreeViewDataSource>{
    NSArray *myArray;
    NSMutableArray *mySelecArray1;
    NSMutableArray *mySelecArray2;
    NSMutableArray *mySelecArray3;
    NSInteger currdex;
    YJChoseShopView *allShopView;
     YJChoseShopView *percentShopView;
    NSMutableArray *dataArray;
    NSString *backStr;
    
    
    
}
@property (nonatomic , assign) NSInteger currentIndex;
@property (weak, nonatomic) RATreeView *treeView;

@property (strong, nonatomic) UIBarButtonItem *editButton;
@end

@implementation YJChoseMoneyTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"选择分类";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(HotListBackClick) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    backStr = @"全部商品";
    _currentIndex = 1;
    [self reoadDate];
    myArray = [[NSArray alloc]init];
    mySelecArray1 = [[NSMutableArray alloc]init];
    mySelecArray2 = [[NSMutableArray alloc]init];
    mySelecArray3 = [[NSMutableArray alloc]init];
    self.data = [[NSMutableArray alloc]init];
    dataArray = [[NSMutableArray alloc]init];
    [mySelecArray1 removeAllObjects];
    [mySelecArray2 removeAllObjects];
    [mySelecArray3 removeAllObjects];
  
    
    [self SetUi];
}
- (void)reoadDate{
    NSString *url = [NSString stringWithFormat:@"%@/essentialData/classManagment/findClass",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        self->myArray = [result objectForKey:@"data"];
        [self->myArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RADataObject *firstModel = [RADataObject dataObjectWithName:obj];
            [self->dataArray addObject:firstModel];
            
            NSArray *secondArray = [obj objectForKey:@"children"];
            NSMutableArray *addArray = [NSMutableArray arrayWithCapacity:0];
            [secondArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RADataObject *secondModel = [RADataObject dataObjectWithName:obj];
                [addArray addObject:secondModel];
                firstModel.children = addArray;
               
                NSArray *moreAddArray = [obj objectForKey:@"children"];
                NSMutableArray *thirdArray = [NSMutableArray array];
                [moreAddArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    RADataObject *MoreModel = [RADataObject dataObjectWithName:obj];
                    [thirdArray addObject:MoreModel];
                    secondModel.children = thirdArray;
                }];
            }];

                      //  NSLog(@"sec == %@",secondArray);
            
        }];
        [self.treeView reloadData];
    }];
}
- (void)SetUi{
    allShopView = [[YJChoseShopView alloc]init];
    allShopView.NameLabel.text = @"全部商品";
    allShopView.userInteractionEnabled = YES;
    allShopView.iconImageView.hidden = NO;
    allShopView.tag = 200;
    UITapGestureRecognizer *allShop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allClick:)];
    [allShopView addGestureRecognizer:allShop];
    [self.view addSubview:allShopView];
    [allShopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    percentShopView = [[YJChoseShopView alloc]init];
    percentShopView.userInteractionEnabled   = YES;
    percentShopView.tag = 201;
    percentShopView.iconImageView.hidden = YES;
    UITapGestureRecognizer *perShop = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(perClick:)];
    [percentShopView addGestureRecognizer:perShop];
    percentShopView.NameLabel.text = @"部分商品";
    [self.view addSubview:percentShopView];
    [percentShopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->allShopView.mas_bottom).offset(15);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    RATreeView *treeView = [[RATreeView alloc] init];
    treeView.hidden = YES;
    treeView.delegate = self;
    treeView.dataSource = self;
    treeView.treeFooterView = [UIView new];
    treeView.separatorStyle = RATreeViewCellSeparatorStyleSingleLine;

    
    self.treeView = treeView;
    [self.view addSubview:self.treeView];
    [treeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->percentShopView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-120-15-64-StatusBarHeight);
    }];

  
    
}
- (void)allClick:(UIView *)view{
    backStr = @"全部商品";
   self.treeView.hidden = YES;
   allShopView.iconImageView.hidden = NO;
   percentShopView.iconImageView.hidden = YES;
    
}
- (void)perClick:(UIView *)view{
    backStr = @"";
    if (percentShopView.iconImageView.hidden) {
        percentShopView.iconImageView.hidden = NO;
         self.treeView.hidden = NO;
    }else{
        percentShopView.iconImageView.hidden = YES;
         self.treeView.hidden = YES;
    }
   
    allShopView.iconImageView.hidden = YES;
  //  percentShopView.iconImageView.hidden = NO;
}
//cell的点击方法

- (void)treeView:(RATreeView *)treeView didSelectRowForItem:(id)item{
     allShopView.iconImageView.hidden = YES;
    
    
}

#pragma mark TreeView Delegate methods

- (CGFloat)treeView:(RATreeView *)treeView heightForRowForItem:(id)item
{
    return 44;
}

//- (BOOL)treeView:(RATreeView *)treeView canEditRowForItem:(id)item
//{
//    return YES;
//}

- (void)treeView:(RATreeView *)treeView willExpandRowForItem:(id)item
{
    YJChoseMoneyTypeTableViewCell *cell = (YJChoseMoneyTypeTableViewCell *)[treeView cellForItem:item];
     RADataObject *dataObject = item;

    dataObject.Dataselect = YES;
    [cell setAdditionButtonHidden:NO animated:YES];
}

- (void)treeView:(RATreeView *)treeView willCollapseRowForItem:(id)item
{
    YJChoseMoneyTypeTableViewCell *cell = (YJChoseMoneyTypeTableViewCell *)[treeView cellForItem:item];

    RADataObject *dataObject = item;
    dataObject.Dataselect = NO;
    [cell setAdditionButtonHidden:YES animated:YES];
}


#pragma mark TreeView Data Source

- (UITableViewCell *)treeView:(RATreeView *)treeView cellForItem:(id)item
{
    RADataObject *dataObject = item;
    
    NSInteger level = [self.treeView levelForCellForItem:item];
    NSInteger numberOfChildren = [dataObject.children count];
   YJChoseMoneyTypeTableViewCell *cell = [YJChoseMoneyTypeTableViewCell treeViewCellWith:treeView arrayCourse:nil];
  
   
    [cell setCellValuesInfoWith:dataObject.name level:level children:numberOfChildren additionButtonHidden:YES];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/**
 
 *  必须实现
 
 *
 
 *  @param treeView treeView
 
 *  @param item    节点对应的item
 
 *
 
 *  @return  每一节点对应的个数
 
 */
- (NSInteger)treeView:(RATreeView *)treeView numberOfChildrenOfItem:(id)item
{
    if (item == nil) {
        return [dataArray count];
    }
    
    RADataObject *data = item;
    return [data.children count];
}
/**
 
 *必须实现的dataSource方法
 
 *
 
 *  @param treeView treeView
 
 *  @param index    子节点的索引
 
 *  @param item     子节点索引对应的item
 
 *
 
 *  @return 返回 节点对应的item
 
 */
- (id)treeView:(RATreeView *)treeView child:(NSInteger)index ofItem:(id)item
{
    RADataObject *data = item;
    if (item == nil) {
        return [dataArray objectAtIndex:index];
    }
    
    return data.children[index];
}
#pragma mark - Helpers

- (void)loadData
{
//    RADataObject *phone1 = [RADataObject dataObjectWithName:@"Phone 1" children:nil];
//    RADataObject *phone2 = [RADataObject dataObjectWithName:@"Phone 2" children:nil];
//    RADataObject *phone3 = [RADataObject dataObjectWithName:@"Phone 3" children:nil];
//    RADataObject *phone4 = [RADataObject dataObjectWithName:@"Phone 4" children:nil];
//
//    RADataObject *phone = [RADataObject dataObjectWithName:@"Phones"
//                                                  children:[NSArray arrayWithObjects:phone1, phone2, phone3, phone4, nil]];
//
//    RADataObject *notebook1 = [RADataObject dataObjectWithName:@"Notebook 1" children:nil];
//    RADataObject *notebook2 = [RADataObject dataObjectWithName:@"Notebook 2" children:nil];
//
//    RADataObject *computer1 = [RADataObject dataObjectWithName:@"Computer 1"
//                                                      children:[NSArray arrayWithObjects:notebook1, notebook2, nil]];
//    RADataObject *computer2 = [RADataObject dataObjectWithName:@"Computer 2" children:nil];
//    RADataObject *computer3 = [RADataObject dataObjectWithName:@"Computer 3" children:nil];
//
//    RADataObject *computer = [RADataObject dataObjectWithName:@"Computers"
//                                                     children:[NSArray arrayWithObjects:computer1, computer2, computer3, nil]];
//    RADataObject *car = [RADataObject dataObjectWithName:@"Cars" children:nil];
//    RADataObject *bike = [RADataObject dataObjectWithName:@"Bikes" children:nil];
//    RADataObject *house = [RADataObject dataObjectWithName:@"Houses" children:nil];
//   // return [self.addressDatas[lastSelecter[0].index][_MySecondStr] count];
//   // return [[self.addressDatas[lastSelecter[0].index][_MySecondStr] objectAtIndex:lastSelecter[1].index][_MyFourStr] count]
//
//    self.data = [NSArray arrayWithObjects:phone, computer, car, bike, house, nil];
   
    
}
- (void)HotListBackClick{
    
    NSString *mystr = [[NSString alloc]init];
    NSString *mystrId = [[NSString alloc]init];
    mystr = @"";
    mystrId = @"";
    for (int i =0; i< dataArray.count; i++) {
         RADataObject *model = [dataArray objectAtIndex:i];
        
        if (model.Dataselect) {
             NSString *str = [NSString stringWithFormat:@"%@",[model.name objectForKey:@"categoryName"]];
             NSString *strid = [NSString stringWithFormat:@"%@",[model.name objectForKey:@"categoryId"]];
            mystr = [mystr stringByAppendingString:[NSString stringWithFormat:@";%@",str]];
            mystrId = [mystrId stringByAppendingString:[NSString stringWithFormat:@",%@",strid]];
            for (int j =0; j< model.children.count; j++) {

                 RADataObject *Secondmodel = [model.children objectAtIndex:j];
                if (Secondmodel.Dataselect) {
                    NSString *secondstr = [NSString stringWithFormat:@"%@",[Secondmodel.name objectForKey:@"categoryName"]];
                     mystr = [mystr stringByAppendingString:[NSString stringWithFormat:@"/%@",secondstr]];
                    NSString *secondstrid = [NSString stringWithFormat:@"%@",[Secondmodel.name objectForKey:@"categoryId"]];
                    mystrId = [mystrId stringByAppendingString:[NSString stringWithFormat:@",%@",secondstrid]];
                    for (int k = 0; k < Secondmodel.children.count; k++) {
                         RADataObject *thirdmodel = [Secondmodel.children objectAtIndex:k];
                        if (thirdmodel.Dataselect) {
                            NSString *thirdstr = [NSString stringWithFormat:@"%@",[thirdmodel.name objectForKey:@"categoryName"]];
                            mystr = [mystr stringByAppendingString:[NSString stringWithFormat:@"/%@",thirdstr]];
                            NSString *thirdstrid = [NSString stringWithFormat:@"%@",[thirdmodel.name objectForKey:@"categoryId"]];
                            mystrId = [mystrId stringByAppendingString:[NSString stringWithFormat:@",%@",thirdstrid]];
                            
                        }
                        
                        
                    }
                    
                    
                
                }

            }
            
        }
    }
    if ([backStr isEqualToString:@"全部商品"]) {
        mystr= backStr;
    }else{
        mystr = mystr;
    }
   
    _mydata(mystr,mystrId);
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJModifyMoneyViewController  class]]) {
            
            [self.navigationController popToViewController:controller animated:YES];
            
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
