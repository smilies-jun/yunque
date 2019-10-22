//
//  FCCollectionViewCell.h
//  FCUICollectionView
//
//  Created by FanChuan on 2019/6/17.
//  Copyright © 2019 fc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YJPhoneImageCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *shopImageView;
@property (strong, nonatomic) UILabel *textLabel;
//方块视图的缓存池标示
+ (NSString *)cellIdentifier;
// 获取方块视图对象
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end


