//
//  YJNewShopCollectionViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJNewShopCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *shopImageView;
//方块视图的缓存池标示
+ (NSString *)cellIdentifier;
// 获取方块视图对象
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END
