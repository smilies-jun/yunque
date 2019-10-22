//
//  YJUserShopTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/25.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHotShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUserShopTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *UserImageView;

@property (nonatomic, strong) UILabel *UserNameLabel;

@property (nonatomic, strong) UILabel *UserPhoneLabel;

@property (nonatomic, strong) UILabel *UserStateLabel;

@property (nonatomic, strong) UIImageView *UserSetFirstImageView;

@property (nonatomic, strong) UIImageView *UserSetSecondImageView;

@property (nonatomic, strong) UIImageView *UserSetThirdImageView;

@property (nonatomic, strong) UILabel *ShopDetailLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property (nonatomic, strong) UILabel *ShopUserLabel;

@property (nonatomic, strong) YJHotShopModel *shopModel;

+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath shopModel:(YJHotShopModel *)model;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setShopModel:(YJHotShopModel * _Nonnull)shopModel;

@end

NS_ASSUME_NONNULL_END
