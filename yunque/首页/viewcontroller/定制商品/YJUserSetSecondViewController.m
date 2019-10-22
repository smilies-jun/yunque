//
//  YJUserSetSecondViewController.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserSetSecondViewController.h"
#import "CustomView.h"
#import "YJUserSetFirstViewController.h"

#import "YJUserSetThirdViewController.h"
#import "PhotoModel.h"
#import "CollectionViewCell.h"
#import "LFBPhotoPickerService.h"
#import "TFPopup.h"
#import "FCCollectionHeaderView.h"
#import "FCCollectionFooterView.h"
#import "YJPhoneImageCollectionViewCell.h"
#import "AliyunOSSHelper.h"

#define contentViewBgColor [UIColor colorWithRed:44.0f/255.0f green:106.0f/255.0f blue:152.0f/255.0 alpha:1]
#define viewBgColor [UIColor colorWithRed:235.0f/255.0f green:235.0f/255.0f blue:233.0f/255.0 alpha:1]

@interface YJUserSetSecondViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
    UIImageView *typeImageView;
    
    CustomView *choseHeightView;
    CustomView *choseWidthiew;
    
    CustomView *choseDongHeightView;
    CustomView *choseDongWidthView;
    
     UIView *choseView;//弹出视图
    UIScrollView *scrollView;
     NSMutableArray *myArray;
    NSArray *StyleImageArray;
    
}
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) UICollectionView *TypeCollectionView;//容器视图
@property (nonatomic, strong) NSMutableArray<PhotoModel *> *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YJUserSetSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.TopView.hidden = NO;
    self.TopTitleLabel.text= @"定制商品";
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetUserChose) name:@"chose" object:nil];
    myArray = [[NSMutableArray alloc]init];
    StyleImageArray = [[NSArray alloc]init];
    [self reoadDate];
    [self setUI];
}
- (void)reoadDate{
    NSString *tokenID = NSuserUse(@"token");
    NSString *url = [NSString stringWithFormat:@"%@/diy/selStyleImg?categoryId=%@",BASE_URL,_categoryId];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        self->StyleImageArray = [[result objectForKey:@"data"]objectForKey:@"doorImgs"];
    }];
    
}
- (void)setUI{
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    scrollView.frame = CGRectMake(0, StatusBarHeight+64, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
   

    [self.view addSubview:scrollView];
    
    typeImageView = [[UIImageView alloc]init];
    typeImageView.image = [UIImage imageNamed:@"导航2"];
    [scrollView addSubview:typeImageView];
    [typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(77);
    }];
    choseHeightView = [[CustomView alloc]init];
    choseHeightView.NameLabel.text = @"门型";
    choseHeightView.NameTextField.delegate = self;
    choseHeightView.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseHeightView];
    [choseHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->typeImageView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseWidthiew = [[CustomView alloc]init];
    choseWidthiew.NameTextField.delegate = self;

    choseWidthiew.NameLabel.text = @"颜色";
     choseWidthiew.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseWidthiew];
    [choseWidthiew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    
    choseDongHeightView = [[CustomView alloc]init];
    choseDongHeightView.NameTextField.delegate = self;

    choseDongHeightView.NameLabel.text = @"材料";
     choseDongHeightView.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseDongHeightView];
    [choseDongHeightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseWidthiew.mas_bottom).offset(60);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    choseDongWidthView = [[CustomView alloc]init];
    choseDongWidthView.NameTextField.delegate = self;

    choseDongWidthView.NameLabel.text = @"开门方式";
     choseDongWidthView.NameTextField.placeholder = @"选填";
    [scrollView addSubview:choseDongWidthView];
    [choseDongWidthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongHeightView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60);
    }];
    UIView *phoneBackView = [[UIView alloc]init];
    phoneBackView.backgroundColor = [UIColor whiteColor];
    phoneBackView.userInteractionEnabled = YES;
    [scrollView addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self->choseDongWidthView.mas_bottom).offset(1);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(120);
    }];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 100) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView setShowsVerticalScrollIndicator:NO];
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.tag = 101;
    [phoneBackView addSubview:_collectionView];
    
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitle:@"下一步" forState:UIControlStateNormal];
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
        make.top.mas_equalTo(phoneBackView.mas_bottom).offset(40);
        make.height.mas_equalTo(40);
    }];
}

- (UIView *)getChoseView{
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
    self.TypeCollectionView = collectionView;
    
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
         return [StyleImageArray count]/2;
    }else{
         return 1;
    }
   
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 100) {
        return 2;
    }else{
        return [self.dataSource count];
    }
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==100) {
        //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
        YJPhoneImageCollectionViewCell *cell=[YJPhoneImageCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
        cell.contentView.backgroundColor=[UIColor whiteColor];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[StyleImageArray objectAtIndex:indexPath.row]]];
        return cell;
    }else{
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class]) forIndexPath:indexPath];
        [cell photoModel:self.dataSource[indexPath.row]];
        typeof(self) __weak weakSelf = self;
        [cell photoCloseHandler:^(PhotoModel *model) {
            if ([weakSelf.dataSource containsObject:model]) {
                [weakSelf.dataSource removeObject:model];
                [weakSelf.collectionView reloadData];
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
        CGFloat width = SCREEN_WIDTH/2-20;
        CGFloat height = 160;
        return CGSizeMake(width, height);
    }else{
        CGFloat itemWidth = SCREEN_WIDTH/3-40;
        CGFloat itemHeight = itemWidth;
        return CGSizeMake(itemWidth, itemHeight);
    }
    
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 100) {
         return UIEdgeInsetsMake(20, 20, 20, 0);
    }else {
        return UIEdgeInsetsMake(10, 10, 0, 10);
    }
   
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 100) {
        [choseView tf_hide];
        myArray = nil;
        self.dataSource = nil;
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[StyleImageArray objectAtIndex:indexPath.row]]]];
        PhotoModel *addPhoto = [[self.dataSource lastObject] copy];
        [self.dataSource removeLastObject];
        self->myArray = [NSMutableArray new];
            PhotoModel *photo = [PhotoModel new];
            photo.isImage = YES;
            photo.image = image;
            [self->myArray addObject:image];
            [self.dataSource addObject:photo];
            [self.dataSource addObject:addPhoto];
            [self.collectionView reloadData];
        //网络数据  indexpath。row
    }else{
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
                self->myArray = [NSMutableArray new];
                [pics enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL * _Nonnull stop) {
                    PhotoModel *photo = [PhotoModel new];
                    photo.isImage = YES;
                    photo.image = image;
                    [self->myArray addObject:image];
                    [weakSelf.dataSource addObject:photo];
                }];
                [weakSelf.dataSource addObject:addPhoto];
                [weakSelf.collectionView reloadData];
            }];
        }
        
    }
    
}
- (void)GetUserChose{
   TFPopupParam *param = [TFPopupParam new];
   param.disuseBackgroundTouchHide = NO;
   param.popupSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, SCREEN_HEIGHT - 200);//设置弹框的尺寸
   param.offset = CGPointZero;//在计算好的位置上偏移
   self->choseView = [self getChoseView];
    [self->choseView tf_showSlide:self.view direction:PopupDirectionBottom popupParam:param];
}

//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
- (void)nextBtn{
    if (myArray.count) {
        NSMutableArray* arrayObj = @[].mutableCopy;
        AliyunOSSHelper* aliyun = [AliyunOSSHelper sharedInstance];
        
        for (UIImage * image in myArray) {
            NSData *data =UIImageJPEGRepresentation(image, 0.5);
            [arrayObj addObject:data];
        }
        
        aliyun.uploadImageType = 1;
        
        aliyun.arrayObjGet = arrayObj;
        [aliyun setupEnvironment];
        
        @autoreleasepool {
            [aliyun uploadObjectAsync];
        }
        [AnimationView showString:@"正在上传！请稍后。"];
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
            [self postClick:nil ];
        });
    }
    
   
}
- (void)postClick:(NSMutableArray *)array{
    NSString *imageStr;
    imageStr = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
    if (imageStr.length) {
       
    }else{
         imageStr = nil ;
    }
    
    NSDictionary *mydic = @{@"doorType":[NSString stringWithFormat:@"%@",choseHeightView.NameTextField.text] ,
                            @"doorColor":choseWidthiew.NameTextField.text,
                            @"material":choseDongHeightView.NameTextField.text,
                            @"style":imageStr,
                            @"openingDirection":choseDongWidthView.NameTextField.text,
                            };
    YJUserSetThirdViewController *vc = [[YJUserSetThirdViewController alloc]init];
    vc.firstDic = _firstDic;
    vc.secondDic = _secondDic;
    vc.thirdDic = mydic;
    vc.categoryId = _categoryId;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJUserSetFirstViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
