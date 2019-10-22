//
//  YJHeaderUserTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJHeaderUserTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *userImageView;

@property (nonatomic, strong) UILabel *userNameLabel;

@property (nonatomic, strong) UILabel *AdressLabel;


@property (nonatomic, strong) UIImageView *iconImageView;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
