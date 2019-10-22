//
//  YJMessageTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *YJNameLabel;

@property (nonatomic, strong) UITextField *YJTextField;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
