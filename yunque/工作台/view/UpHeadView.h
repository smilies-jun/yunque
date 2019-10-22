//
//  UpHeadView.h
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUpShopModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HeaderViewDelegate <NSObject>

- (void)selAnSection:(NSInteger)section;

@end
@interface UpHeadView : UIView
@property (nonatomic, strong) UIImageView *ShopImageView;


@property (nonatomic, strong) UILabel *ShopNameLabel;

@property (nonatomic, strong) UILabel *ShopMoneyLabel;

@property (nonatomic, strong) UILabel *ShopNumberBtn;
@property (nonatomic, strong) UIImageView *ShopNumberBtnImageView;
@property (nonatomic,assign) NSInteger section;

@property (nonatomic, strong) UILabel *ShopTagFirstLabel;
@property (nonatomic, strong) UILabel *ShopTagSecondLabel;
@property (nonatomic, strong) UILabel *ShopTagThirdLabel;
@property (nonatomic, strong) UIView *ShopBagView;

@property (nonatomic, weak) id < HeaderViewDelegate> delegate;


@property(nonatomic, retain)YJUpShopModel *UpShopModel;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setUpShopModel:(YJUpShopModel * _Nonnull)UpShopModel;
@end

NS_ASSUME_NONNULL_END
