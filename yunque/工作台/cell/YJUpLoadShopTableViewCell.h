//
//  YJUpLoadShopTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJJiaGeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUpLoadShopTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *NameLabel;
@property (nonatomic,strong)UILabel *MoneyLabel;
@property (nonatomic,strong)UILabel *TypeLabel;

@property (nonatomic,strong)YJJiaGeModel *model;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setModel:(YJJiaGeModel * _Nonnull)model;
@end

NS_ASSUME_NONNULL_END
