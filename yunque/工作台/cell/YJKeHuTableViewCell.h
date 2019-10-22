//
//  YJKeHuTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJKeHuModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJKeHuTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *KeHuNameLabel;
@property (nonatomic, strong) UILabel *KeHuNametTypeLabel;

@property (nonatomic, strong) UILabel *KeHuNumberLabel;

@property (nonatomic, strong) UILabel *UserNameLabel;

@property (nonatomic, strong) UILabel *UserNumberLabel;

@property (nonatomic, strong) UIButton *EditBtn;

@property (nonatomic,strong)YJKeHuModel *model;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setModel:(YJKeHuModel * _Nonnull)model;

@end

NS_ASSUME_NONNULL_END
