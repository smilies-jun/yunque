//
//  YJGouWuCheTableViewCell.h
//  maike
//
//  Created by Apple on 2019/9/10.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSCartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJGouWuCheTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *ShopImageView;


@property (nonatomic, strong) UILabel *ShopNameLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property (nonatomic, strong) UILabel *ShopNumberLabel;

@property (nonatomic, strong) UILabel *ShopTagFirstLabel;
@property (nonatomic, strong) UILabel *ShopTagSecondLabel;
@property (nonatomic, strong) UILabel *ShopTagThirdLabel;

@property(nonatomic,strong)JSCartModel *model;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setModel:(JSCartModel * _Nonnull)model;

@end

NS_ASSUME_NONNULL_END
