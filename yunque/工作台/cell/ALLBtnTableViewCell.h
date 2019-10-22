//
//  ALLBtnTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/1.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALLBtnTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *btnLabel;

@property (nonatomic, strong) UIView *lineImageView;

- (void)configUI:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
