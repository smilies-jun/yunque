//
//  YJUserDetailTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJUserDetailTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *NameLabel;
@property (nonatomic, strong) UILabel *choseLabel;
@property (nonatomic, strong) UIImageView *NextImageView;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
