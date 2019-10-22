//
//  YJAutherTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJAutherTableViewCell : UITableViewCell
@property (nonatomic , retain) UILabel  *AutherTitleLabel;//
@property (nonatomic , retain) UITextField *choseTextField;//
@property (nonatomic , retain) UIButton *AutherButton;//

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
