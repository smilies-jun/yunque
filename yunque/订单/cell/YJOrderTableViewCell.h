//
//  YJOrderTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/21.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJOrderTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *OrderNumberLabel;//订单号
@property (nonatomic , retain) UILabel *OrderNumberLabelSate;//订单号状态

@property (nonatomic , retain) UILabel *OrderNameLabel;//客户信息
@property (nonatomic , retain) UILabel *OrderNamePhoneLabel;//
@property (nonatomic , retain) UILabel *OrderNameAdresssLabel;//

@property (nonatomic , retain) UILabel *OrderMoneyLabel;//订单金额
@property (nonatomic , retain) UILabel *OrderAllMoneyLabel;//

@property (nonatomic , retain) UILabel *OrderPayMoneyStyleLabel;//订单已支付金额
@property (nonatomic , retain) UILabel *OrderPayMoneyLabel;//

@property (nonatomic , retain) UILabel *OrderNoPayStyleMoneyLabel;//订单未支付金额
@property (nonatomic , retain) UILabel *OrderNoPayMoneyLabel;//


@property (nonatomic , retain) UILabel *OrderUserLabel;//导购员

@property (nonatomic , retain) UIButton *PayMoneyBtn;//

@property (nonatomic , retain) UIButton *SureOverBtn;//

@property (nonatomic, retain)YJOrderModel *orderModel;

- (void)configUI:(NSIndexPath *)indexPath;

-(void)setOrderModel:(YJOrderModel * _Nonnull)orderModel;

@end

NS_ASSUME_NONNULL_END
