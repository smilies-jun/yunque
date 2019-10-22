//
//  YJShouCangTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/5.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJShouCangTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *ShopImageView;


@property (nonatomic, strong) UILabel *ShopNameLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property (nonatomic, strong) UILabel *ShopNumberLabel;

@property (nonatomic, strong) UILabel *ShopTagFirstLabel;
@property (nonatomic, strong) UILabel *ShopTagSecondLabel;
@property (nonatomic, strong) UILabel *ShopTagThirdLabel;


- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
