//
//  YJUpShopTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUpShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUpShopTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *ShopNameLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property(nonatomic, retain)YJUpShopModel *UpShopModel;

- (void)configUI:(NSIndexPath *)indexPath;

- (void)setUpShopModel:(YJUpShopModel * _Nonnull)UpShopModel;

@end

NS_ASSUME_NONNULL_END
