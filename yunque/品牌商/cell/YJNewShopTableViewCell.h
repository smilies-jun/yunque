//
//  YJNewShopTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class YJNewShopTableViewCell;
@protocol RootCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(YJNewShopTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end
@interface YJNewShopTableViewCell : UITableViewCell

@property (nonatomic, weak) id<RootCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSArray *dataAry;

@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UILabel *dataNumberLabel;

- (void)configUI:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
