//
//  YJPinPaiTableViewCell.h
//  yunque
//
//  Created by Apple on 2019/10/15.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJPinPaiModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJPinPaiTableViewCell : UITableViewCell

@property (nonatomic, strong) YJPinPaiModel *model;
- (void)configUI:(NSIndexPath *)indexPath;

- (void)updateTableViewCellHeight:(YJPinPaiTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;

@end
NS_ASSUME_NONNULL_END
