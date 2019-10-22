//
//  YJPayTopTableViewCell.h
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJPayTopTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *NameLabel;

@property (nonatomic, strong) UITextField *AdressTextField;




- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
