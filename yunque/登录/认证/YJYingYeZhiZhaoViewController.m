//
//  YJYingYeZhiZhaoViewController.m
//  maike
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJYingYeZhiZhaoViewController.h"
#import "PhotoModel.h"
#import "CollectionViewCell.h"
#import "LFBPhotoPickerService.h"
#import "AliyunOSSHelper.h"



@interface YJYingYeZhiZhaoViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UIButton *sureBtn;
    NSMutableArray *myArray;
}
@property (nonatomic, strong) NSMutableArray<PhotoModel *> *dataSource;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation YJYingYeZhiZhaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    self.TopTitleLabel.text = @"营业执照认证";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.BackButton addTarget:self action:@selector(AuthenticationBackClick) forControlEvents:UIControlEventTouchUpInside];
    myArray = [[NSMutableArray alloc]init];
    [self InitUI];
}
- (void)AuthenticationBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
}
- (void)InitUI{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    topView.frame = CGRectMake(0, StatusBarHeight + 64, SCREEN_WIDTH, 150);
    [self.view addSubview:topView];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"上传营业执照";
    titleLabel.frame = CGRectMake(20, 10, 200, 20);
    titleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:titleLabel];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, 100) collectionViewLayout:flowLayout];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionViewCell class])];
    [_collectionView setBackgroundColor:[UIColor whiteColor]];
    [_collectionView setShowsVerticalScrollIndicator:NO];
    [_collectionView setShowsHorizontalScrollIndicator:NO];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    _collectionView.tag = 101;
    [topView addSubview:_collectionView];
    sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 5.0f;
    sureBtn.backgroundColor =font_main_color;
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [sureBtn addTarget:self action:@selector(postBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view   addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(topView.mas_bottom).offset(50);
        make.height.mas_equalTo(40);
    }];
    UILabel *bootomLabel = [[UILabel alloc]init];
    bootomLabel.text = @"文件格式：png、jpg大小；小于1M；单次最多上传3张照片；提交后三个工作日完成认证";
    bootomLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    bootomLabel.numberOfLines = 0;
    bootomLabel.frame = CGRectMake(20, 130, SCREEN_WIDTH - 40, 40);
    bootomLabel.font = [UIFont systemFontOfSize:12];
    [topView addSubview:bootomLabel];
}
- (void)postBtn{
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
    aliyun.AliyunBlock = ^(NSMutableArray* arrayObj){
        if (arrayObj.count) {
            [self postClick:arrayObj];
        }else{
            [AnimationView showString:@"图片上传失败"];
        }
    
    };

}
- (void)postClick:(NSMutableArray *)array{
        NSString *tokenID = NSuserUse(@"token");
    NSString *imageStr;
    for (int i =0; i <array.count; i++) {
        if (imageStr.length) {
             imageStr = [imageStr stringByAppendingString:[NSString stringWithFormat:@"%@,",[array objectAtIndex:i]]];
        }else{
            imageStr = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        }
       
    }
        NSDictionary *dic = @{@"agreeAgreement":@"1",
                              @"appealShopId":_shopId,
                              @"businessLicenseImg":imageStr,
                              @"bankAccount":[_dic objectForKey:@"bankAccount"],
                              @"bankNumber":[_dic objectForKey:@"bankNumber"],
                              @"shopName":[_dic objectForKey:@"shopName"],
                              @"shopShortName":[_dic objectForKey:@"shopShortName"],
                              @"province":[_dic objectForKey:@"province"],
                              @"city":[_dic objectForKey:@"city"],
                              @"bank":[_dic objectForKey:@"bank"],
                              @"otherSettlementAccountType":[_dic objectForKey:@"otherSettlementAccountType"],
                              @"typeJoinId":[_dic objectForKey:@"typeJoinId"],
                              @"brandIds":[_dic objectForKey:@"brandIds"],
                              @"areasonAppeal":_str,
                              @"state":@"0",
                              @"type":@"2"
                              };
    
        NSString *url = [NSString stringWithFormat:@"%@/shop/shopfirm",BASE_URL];
        [[DateSource sharedInstance]requestHomeWithParameters:(NSMutableDictionary *)dic withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
            if ([[result objectForKey:@"code"]integerValue] == 200) {
                [self.navigationController popToRootViewControllerAnimated:NO];
    
            }else{
                [AnimationView showString:[result objectForKey:@"errmsg"]];
            }
       }];
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

    
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return [self.dataSource count];

}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

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
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

        CGFloat itemWidth = SCREEN_WIDTH/3-40;
        CGFloat itemHeight = itemWidth;
        return CGSizeMake(itemWidth, itemHeight);

    
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
 
    return UIEdgeInsetsMake(10, 10, 0, 10);

    
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

        LFBPhotoPickerService *manager = [LFBPhotoPickerService shareInstance];
        [manager lfb_SetPhotoPickerStyle:LFBPhotoPickerStyleAllOnlyDevice];
        if (indexPath.row < [self.dataSource count] -1) {
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:^(NSArray *pics) {
                PhotoModel *photoReplace = [self.dataSource objectAtIndex:indexPath.row];
                photoReplace.image = [pics lastObject];
                [weakSelf.collectionView reloadData];
            }];
        }else{
            typeof(self) __weak weakSelf = self;
            [manager lfb_GetPicture:nil maxCount:3 callBack:^(NSArray *pics) {
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


//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}

- (void)ShopListBackClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
