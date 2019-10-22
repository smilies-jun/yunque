//
//  YJModifyMoneyTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJModifyMoneyTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *NameLabel;

@property (nonatomic,strong)UITextField *NameTextField;

- (void)configUI:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
