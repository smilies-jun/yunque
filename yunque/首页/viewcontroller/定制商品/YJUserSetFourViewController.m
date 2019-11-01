//
//  YJUserSetFourViewController.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetFourViewController.h"
#import "CustomView.h"
#import "YJUserSetSecondViewController.h"
#import "YJUserSetDetailViewController.h"
#import "PhotoModel.h"
#import "CollectionViewCell.h"
#import "LFBPhotoPickerService.h"
#import "TFPopup.h"
#import "FCCollectionHeaderView.h"
#import "FCCollectionFooterView.h"
#import "YJPhoneImageCollectionViewCell.h"
#import "AliyunOSSHelper.h"
#import "YJUserSetThirdViewController.h"


@interface YJUserSetFourViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>{
    UIImageView *typeImageView;
    CustomView *choseHeightView;
    CustomView *choseWidthiew;
    
    CustomView *choseDongHeightView;
    CustomView *choseDongWidthView;
    
    CustomView *choseQiangView;
    CustomView *choseMenView;
    UIScrollView *scrollView;
    UIView *choseView;//弹出视图
    NSMutableArray *myArrayFirst;
    UIView *MenZhuView;//弹出视图
    NSMutableArray *myArraySecond;
    NSArray *MenTouArray;
    NSArray *MenZhuArray;
    
    
    
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;

@property (nonatomic, strong) NSMutableArray<PhotoModel *> *dataSource;

@property (nonatomic, strong) NSMutableArray<PhotoModel *> *dataSourceSecond;


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionView *collectionView2;


@end

@implementation YJUserSetFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetUserChose) name:@"chose" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetMenZhuChose) name:@"choseMen" object:nil];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    MenTouArray = [[NSArray alloc]init];
    MenZhuArray = [[NSArray alloc]init];
    [self reoadDate];
    [self setUI];
}
//
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/diy/selStyleImg?categoryId=%@",BASE_URL,_categoryId];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->MenTouArray = [[result objectForKey:@"data"]objectForKey:@"doorHeadImgs"];
        self->MenZhuArray = [[result objectForKey:@"data"]objectForKey:@"doorColumnImgs"];
        
    }];
    
}
- (void)setUI{
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:scrollView];
    
    typeImageView = [[UIImageView alloc]init];
    typeImageView.image = [UIImage imageNamed:@"导航4"];
    [scrollView addSubview:typeImageView];
    [typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80);
    }];
    choseHeightView = [[CustomView alloc]init];
    choseHeightView.NameLabel.text = @"门头高";
    
    choseHeightView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    choseHeightView.NameTextField.delegate = self;
    [scrollView addSubview:choseHeightView];
    [choseHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->typeImageView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseWidthiew = [[CustomView alloc]init];
    choseWidthiew.NameLabel.text = @"门头宽";
    choseWidthiew.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    choseWidthiew.NameTextField.delegate = self;
    [scrollView addSubview:choseWidthiew];
    [choseWidthiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseDongHeightView = [[CustomView alloc]init];
    choseDongHeightView.NameLabel.text = @"颜色";
    choseDongHeightView.NameTextField.delegate = self;
      choseDongHeightView.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseDongHeightView];
    [choseDongHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseWidthiew.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIView *phoneBackView = [[UIView alloc]init];
    phoneBackView.backgroundColor = [UIColor grayColor];
    phoneBackView.userInteractionEnabled = YES;
    [scrollView addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(120);
    }];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView setShowsVerticalScrollIndicator:NO];
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.tag = 101;
    [phoneBackView addSubview:_collectionView];
    
    choseDongWidthView = [[CustomView alloc]init];
    choseDongWidthView.NameLabel.text = @"门株高";
    choseDongWidthView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    choseDongWidthView.NameTextField.delegate = self;
    [scrollView addSubview:choseDongWidthView];
    [choseDongWidthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(phoneBackView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseQiangView = [[CustomView alloc]init];
    choseQiangView.NameLabel.text = @"门柱宽";
    choseQiangView.NameTextField.keyboardType = UIKeyboardTypeNumberPad;
    choseQiangView.NameTextField.delegate = self;
    [scrollView addSubview:choseQiangView];
    [choseQiangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongWidthView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseMenView = [[CustomView alloc]init];
    choseMenView.NameLabel.text = @"颜色";
    choseMenView.NameTextField.delegate = self;
    choseMenView.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseMenView];
    [choseMenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseQiangView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIView *phoneBackViewType = [[UIView alloc]init];
    phoneBackViewType.backgroundColor = [UIColor grayColor];
    phoneBackViewType.userInteractionEnabled = YES;
    [scrollView addSubview:phoneBackViewType];
    [phoneBackViewType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseMenView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(120);
    }];
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc]init];
    _collectionView2 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120) collectionViewLayout:flowLayout1];
    [_collectionView2 registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [_collectionView2 setBackgroundColor:[UIColor whiteColor]];
    [_collectionView2 setShowsVerticalScrollIndicator:NO];
    [_collectionView2 setShowsHorizontalScrollIndicator:NO];
    [_collectionView2 setDataSource:self];
    [_collectionView2 setDelegate:self];
    _collectionView2.tag = 102;
    [phoneBackViewType addSubview:_collectionView2];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(nextBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(phoneBackViewType.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}

- (void)nextBtn{
    NSArray *imageArray = [[NSArray alloc]init];
    
    if (myArrayFirst.count) {
        imageArray = [imageArray arrayByAddingObjectsFromArray:myArrayFirst];
    }
    if (myArraySecond.count) {
        imageArray = [imageArray arrayByAddingObjectsFromArray:myArraySecond];
    }
    if (imageArray.count) {
        NSMutableArray* arrayObj = @[].mutableCopy;
        AliyunOSSHelper* aliyun = [AliyunOSSHelper sharedInstance];
        
        for (UIImage * image in imageArray) {
            NSData *data =UIImageJPEGRepresentation(image, 0.5);
            [arrayObj addObject:data];
        }
        
        aliyun.uploadImageType = 1;
        
        aliyun.arrayObjGet = arrayObj;
        [aliyun setupEnvironment];
        
        @autoreleasepool {
            [aliyun uploadObjectAsync];
        }
        aliyun.AliyunBlock = ^(NSMutableArray* arrayObj){
            if (arrayObj.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self postClick:arrayObj];
                });
               
            }else{
                [AnimationView showString:@"图片上传失败"];
            }
            
        };
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postClick:nil];
        });    }
   
    
   
}
-(void)postClick:(NSArray *)array{
    NSString *tokenID = NSuserUse(@"token");

  
   
    NSString *firstStr;
    NSString *secondStr;
    
    for (int i =0; i <array.count; i++) {
        if (i == 0) {
            firstStr = [array objectAtIndex:0];
        }else{
            secondStr = [array objectAtIndex:1];
            
        }
        
    }
    if (!firstStr.length) {
        firstStr = @"";
    }
    if (!secondStr) {
        secondStr = @"";
    }
    NSDictionary *mydic = @{@"doorHeadHigh":choseHeightView.NameTextField.text,
                            @"doorHeadWidth":choseWidthiew.NameTextField.text,
                            @"doorHeadColor":choseDongHeightView.NameTextField.text,
                            @"doorColumnHigh":choseDongWidthView.NameTextField.text,
                            @"doorColumnWidth":choseQiangView.NameTextField.text,
                            @"doorColumnColor":choseMenView.NameTextField.text,
                            @"doorHeadStyle":firstStr,
                            @"doorColumnStyle":secondStr
                            };
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic addEntriesFromDictionary:mydic];
    [dic addEntriesFromDictionary:_firstDic];
    [dic addEntriesFromDictionary:_secondDic];
    [dic addEntriesFromDictionary:_thirdDic];
    [dic addEntriesFromDictionary:_fourDic];
    NSString *url = [NSString stringWithFormat:@"%@/diy/add",BASE_URL];
    [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            [self.navigationController popToRootViewControllerAnimated:NO];
            
            
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
    }];
   
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserSetThirdViewController class]]) {
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

- (UIView *)getChoseView{
    NSLog(@"1111111122");
    UIView *TypeView= [[UIView alloc]init];
    TypeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100);
    TypeView.backgroundColor = [UIColor whiteColor];
    CGFloat x=0;
    CGFloat y=0;
    CGFloat width=SCREEN_WIDTH;
    CGFloat height=SCREEN_HEIGHT - 100;
    //创建布局对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //创建容器视图
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
    collectionView.delegate=self;//设置代理
    collectionView.tag = 100;
    collectionView.dataSource=self;//设置数据源
    collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
    //添加到主视图
    [TypeView addSubview:collectionView];
    
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
    return TypeView;
}
- (UIView *)getMenZhuView{
    NSLog(@"2222222");
    UIView *TypeView= [[UIView alloc]init];
    TypeView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 100);
    TypeView.backgroundColor = [UIColor whiteColor];
    CGFloat x=0;
    CGFloat y=0;
    CGFloat width=SCREEN_WIDTH;
    CGFloat height=SCREEN_HEIGHT - 100;
    //创建布局对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //创建容器视图
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(x, y, width, height) collectionViewLayout:layout];
    collectionView.delegate=self;//设置代理
    collectionView.tag = 200;
    collectionView.dataSource=self;//设置数据源
    collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
    //添加到主视图
    [TypeView addSubview:collectionView];
    
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
    return TypeView;
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView.tag == 100) {
        return [MenTouArray count]/2;
    }else if (collectionView.tag == 200){
        return [MenZhuArray count]/2;
    }else{
        return 1;
    }
    
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 100) {
        return 2;
    }else if (collectionView.tag == 200){
        return 2;
    }else if (collectionView.tag == 101){
        return 1;
    }else{
        return 1;
    }
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==100) {
        //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
        YJPhoneImageCollectionViewCell *cell=[YJPhoneImageCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        //cell.textLabel.text = [NSString stringWithFormat:@"Cell %2ld",indexPath.row];
         [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[MenTouArray objectAtIndex:indexPath.row]]];
        return cell;
    }else if (collectionView.tag == 200){
        YJPhoneImageCollectionViewCell *cell=[YJPhoneImageCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
         [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[MenZhuArray objectAtIndex:indexPath.row]]];
        //cell.textLabel.text = [NSString stringWithFormat:@"Cell %2ld",indexPath.row];
        return cell;
    }else if (collectionView.tag == 101){
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
        [cell photoModel:self.dataSource[indexPath.row]];
        typeof(self) __weak weakSelf = self;
        [cell photoCloseHandler:^(PhotoModel *model) {
            if ([weakSelf.dataSource containsObject:model]) {
                [weakSelf.dataSource removeObject:model];
                [self->myArrayFirst removeAllObjects];
                [weakSelf.collectionView reloadData];
            }
        }];
        return cell;
    }else{
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
        [cell photoModel:self.dataSourceSecond[indexPath.row]];
        typeof(self) __weak weakSelf = self;
        [cell photoCloseHandler:^(PhotoModel *model) {
            if ([weakSelf.dataSourceSecond containsObject:model]) {
                [weakSelf.dataSourceSecond removeObject:model];
                [self->myArraySecond removeAllObjects];
                [weakSelf.collectionView2 reloadData];
            }
        }];
        return cell;
    }
    
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 100) {
        return CGSizeMake(160, 160);
    }else if (collectionView.tag == 200){
         return CGSizeMake(160, 160);
    }else{
        CGFloat itemWidth = SCREEN_WIDTH/3-40;
        CGFloat itemHeight = itemWidth;
        return CGSizeMake(itemWidth, itemHeight);
    }
    
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 100) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }else {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
    
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"collec ==== %ld",(long)collectionView.tag);
    if (collectionView.tag == 100) {
        [choseView tf_hide];
        myArrayFirst = nil;
        self.dataSource = nil;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[MenTouArray objectAtIndex:indexPath.row]]]];
        PhotoModel *addPhoto = [[self.dataSource lastObject] copy];
        [self.dataSource removeLastObject];
        self->myArrayFirst = [NSMutableArray new];
        PhotoModel *photo = [PhotoModel new];
        photo.isImage = YES;
        photo.image = image;
        [self->myArrayFirst addObject:image];
        [self.dataSource addObject:photo];
        [self.dataSource addObject:addPhoto];
        [self.collectionView reloadData];
        //网络数据  indexpath。row
    }else if (collectionView.tag == 200){
        NSLog(@"20000000000");
        [MenZhuView tf_hide];
        myArraySecond = nil;
        self.dataSourceSecond = nil;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[MenZhuArray objectAtIndex:indexPath.row]]]];
        PhotoModel *addPhoto = [[self.dataSource lastObject] copy];
        [self.dataSourceSecond removeLastObject];
        self->myArraySecond = [NSMutableArray new];
        PhotoModel *photo = [PhotoModel new];
        photo.isImage = YES;
        photo.image = image;
        [self->myArraySecond addObject:image];
        [self.dataSourceSecond addObject:photo];
        [self.dataSourceSecond addObject:addPhoto];
        [self.collectionView2 reloadData];
    }else if (collectionView.tag == 101){
        NSuserSave(@"0", @"Mystate");
        LFBPhotoPickerService *manager = [LFBPhotoPickerService shareInstance];
        [manager lfb_SetPhotoPickerStyle:LFBPhotoPickerStyleAllDevice];
        if (indexPath.row < [self.dataSource count] -1) {
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:^(NSArray *pics) {
                PhotoModel *photoReplace = [self.dataSource objectAtIndex:indexPath.row];
                photoReplace.image = [pics lastObject];
                [weakSelf.collectionView reloadData];
            }];
        }else{
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:nil maxCount:1 callBack:^(NSArray *pics) {
                PhotoModel *addPhoto = [[self.dataSource lastObject] copy];
                [weakSelf.dataSource removeLastObject];
                self->myArrayFirst = [NSMutableArray new];
                [pics enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
                    PhotoModel *photo = [PhotoModel new];
                    photo.isImage = YES;
                    photo.image = image;
                    [self->myArrayFirst addObject:image];
                    [weakSelf.dataSource addObject:photo];
                }];
                [weakSelf.dataSource addObject:addPhoto];
                [weakSelf.collectionView reloadData];
            }];
        }
    }else{
        LFBPhotoPickerService *manager = [LFBPhotoPickerService shareInstance];
        [manager lfb_SetPhotoPickerStyle:LFBPhotoPickerStyleAllDevice];
        NSuserSave(@"1", @"Mystate");
        if (indexPath.row < [self.dataSourceSecond count] -1) {
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:^(NSArray *pics) {
                PhotoModel *photoReplace = [self.dataSourceSecond objectAtIndex:indexPath.row];
                photoReplace.image = [pics lastObject];
                [weakSelf.collectionView2 reloadData];
            }];
        }else{
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:nil maxCount:1 callBack:^(NSArray *pics) {
                PhotoModel *addPhoto = [[self.dataSourceSecond lastObject] copy];
                [weakSelf.dataSourceSecond removeLastObject];
                 self->myArraySecond = [NSMutableArray new];
                [pics enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
                    PhotoModel *photo = [PhotoModel new];
                    photo.isImage = YES;
                    photo.image = image;
                    [self->myArraySecond addObject:image];
                    [weakSelf.dataSourceSecond addObject:photo];
                }];
                [weakSelf.dataSourceSecond addObject:addPhoto];
                [weakSelf.collectionView2 reloadData];
            }];
        }
        
    }
    
}
- (NSMutableArray<PhotoModel *> *)dataSource {
    return _dataSource?:({
        _dataSource = [NSMutableArray array];
        {
            PhotoModel *photo = [PhotoModel new];
            photo.addImg = [UIImage imageNamed:@"添加图片"];
            [_dataSource addObject:photo];
        }
        _dataSource;
    });
}
- (NSMutableArray<PhotoModel *> *)dataSourceSecond {
    return _dataSourceSecond?:({
        _dataSourceSecond = [NSMutableArray array];
        {
            PhotoModel *photo = [PhotoModel new];
            photo.addImg = [UIImage imageNamed:@"添加图片"];
            [_dataSourceSecond addObject:photo];
        }
        _dataSourceSecond;
    });
}
- (void)GetUserChose{
    TFPopupParam *param = [TFPopupParam new];
    param.disuseBackgroundTouchHide = NO;
    param.popupSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT - 200);//设置弹框的尺寸
    param.offset = CGPointZero;//在计算好的位置上偏移
    self->choseView = [self getChoseView];
    [self->choseView tf_showSlide:self.view direction:PopupDirectionBottom popupParam:param];
}
- (void)GetMenZhuChose{
    TFPopupParam *param = [TFPopupParam new];
    param.disuseBackgroundTouchHide = NO;
    param.popupSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT - 200);//设置弹框的尺寸
    param.offset = CGPointZero;//在计算好的位置上偏移
    self->MenZhuView = [self getMenZhuView];
    [self->MenZhuView tf_showSlide:self.view direction:PopupDirectionBottom popupParam:param];
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    if (collectionView.tag ==101) {
        
    }else{
        
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
