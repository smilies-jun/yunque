//
//  YJShopUserPostTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJHotShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJShopUserPostTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *ShopImageView;


@property (nonatomic, strong) UILabel *ShopNameLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property (nonatomic, strong) UILabel *ShopNumberLabel;

@property (nonatomic, strong) UILabel *ShopTagFirstLabel;
@property (nonatomic, strong) UILabel *ShopTagSecondLabel;
@property (nonatomic, strong) UILabel *ShopTagThirdLabel;

@property (nonatomic, strong) UIButton *UpShopButton;


@property (nonatomic, strong) YJHotShopModel *model;
- (void)configUI:(NSIndexPath *)indexPath;
- (void)setModel:(YJHotShopModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
