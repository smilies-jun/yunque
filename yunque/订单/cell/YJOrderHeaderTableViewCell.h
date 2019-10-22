//
//  YJOrderHeaderTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJOrderHeaderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderMoneyLabel;

@property (nonatomic, strong) UILabel *NoPayLabel;

@property (nonatomic, strong) UILabel *PayLabel;

@property (nonatomic, strong) UILabel *NameLabel;

@property (nonatomic, strong) UILabel *AdressLabel;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
