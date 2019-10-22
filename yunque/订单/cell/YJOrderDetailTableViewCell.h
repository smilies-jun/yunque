//
//  YJOrderDetailTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJOrderDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *NameLabel;

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UILabel *orderNumberDetailLabel;

@property (nonatomic, strong) UILabel *OrderTimeLabel;
@property (nonatomic, strong) UILabel *OrderTimeDetailLabel;

@property (nonatomic, strong) UILabel *OrderCreateLabel;
@property (nonatomic, strong) UILabel *OrderCreateDetailLabel;

@property (nonatomic, strong) UILabel *OrderFirstPayLabel;
@property (nonatomic, strong) UILabel *OrderFirstPayDetailLabel;

@property (nonatomic, strong) UILabel *OrderPayComplyLabel;
@property (nonatomic, strong) UILabel *OrderPayComplyDetailLabel;

@property (nonatomic, strong) UILabel *OrderReceiveLabel;
@property (nonatomic, strong) UILabel *OrderReceiveDetailLabel;


@property (nonatomic, strong) UILabel *PayNameLabel;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
