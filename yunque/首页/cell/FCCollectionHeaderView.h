//
//  FCCollectionHeaderView.h
//  FCUICollectionView
//
//  Created by FanChuan on 2019/6/17.
//  Copyright © 2019 fc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FCCollectionHeaderView : UICollectionReusableView
@property (strong, nonatomic) UILabel *textLabel;

//顶部视图的缓存池标示
+ (NSString *)headerViewIdentifier;
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end


