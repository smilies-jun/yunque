//
//  YJNewShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJNewShopTableViewCell.h"
#import "FCCollectionHeaderView.h"
#import "FCCollectionFooterView.h"
#import "YJNewShopCollectionViewCell.h"

@interface YJNewShopTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@end

@implementation YJNewShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _dataLabel = [[UILabel alloc]init];
    _dataLabel.text = @"铜门界的新品111111";
    _dataLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_dataLabel];
    [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    _dataNumberLabel = [[UILabel alloc]init];
    _dataNumberLabel.text = [NSString stringWithFormat:@"时间%ld",(long)indexPath.row];
    _dataNumberLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_dataNumberLabel];
    [_dataNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self->_dataLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
    }];
    //创建布局对象
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    //创建容器视图
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 65, SCREEN_WIDTH,  230) collectionViewLayout:layout];
    collectionView.delegate=self;//设置代理
    collectionView.dataSource=self;//设置数据源
    collectionView.backgroundColor = [UIColor whiteColor];//设置背景，默认为黑色
    //添加到主视图
    [self addSubview:collectionView];
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
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_dataAry count];
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    YJNewShopCollectionViewCell *cell=[YJNewShopCollectionViewCell cellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.contentView.backgroundColor=colorWithRGB(0.96, 0.96, 0.96);
    cell.textLabel.text = [[_dataAry objectAtIndex:indexPath.row]objectForKey:@"productDes"];
    [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[[_dataAry objectAtIndex:indexPath.row]objectForKey:@"productImg"]] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
    
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
    CGFloat width = 140;
    CGFloat height = 156;
    return CGSizeMake(width, height);
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 15, 10);
    
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    // [choseView tf_hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:[NSString stringWithFormat:@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row]];
    }
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}

@end
