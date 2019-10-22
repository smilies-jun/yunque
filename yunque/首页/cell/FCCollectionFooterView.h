//
//  FCCollectionFooterView.h
//  FCUICollectionView
//
//  Created by FanChuan on 2019/6/17.
//  Copyright © 2019 fc. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FCCollectionFooterView : UICollectionReusableView
@property (strong, nonatomic) UILabel *textLabel;
//底部视图的缓存池标示
+ (NSString *)footerViewIdentifier;
//获取底部视图对象
+ (instancetype)footerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
@end


