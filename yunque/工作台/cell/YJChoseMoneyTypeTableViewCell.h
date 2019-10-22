//
//  YJChoseMoneyTypeTableViewCell.h
//  maike
//
//  Created by Apple on 2019/8/14.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RATreeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJChoseMoneyTypeTableViewCell : UITableViewCell


@property (nonatomic, copy) void (^additionButtonTapAction)(id sender);

@property (nonatomic) BOOL additionButtonHidden;
@property (nonatomic) BOOL select;

- (void)setAdditionButtonHidden:(BOOL)additionButtonHidden animated:(BOOL)animated;

@property (nonatomic, strong) UILabel *choseNameLabel;

@property (nonatomic, strong) UIImageView *choseImageView;

@property (nonatomic, strong) UIImageView *iconImageView;

+ (instancetype)treeViewCellWith:(RATreeView *)treeView arrayCourse:(NSArray *)arrayCourse;

- (void)setCellValuesInfoWith:(NSDictionary *)title level:(NSInteger)level children:(NSInteger )children  additionButtonHidden:(BOOL)additionButtonHidden;

@end

NS_ASSUME_NONNULL_END
