//
//  YJOrderPayDetailTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJOrderPayDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *NameLabel;

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *orderNumberDetailLabel;

@property (nonatomic, strong) UILabel *OrderTimeLabel;
@property (nonatomic, strong) UILabel *OrderTimeDetailLabel;

@property (nonatomic, strong) UILabel *OrderCreateLabel;
@property (nonatomic, strong) UILabel *OrderCreateDetailLabel;


@property (nonatomic, strong) UILabel *OrderMoneyLabel;
@property (nonatomic, strong) UILabel *OrderMoneyDetailLabel;


@property (nonatomic,strong)YJOrderModel *model;

- (void)setModel:(YJOrderModel * _Nonnull)model;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
