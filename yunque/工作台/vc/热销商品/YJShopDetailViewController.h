//
//  YJShopDetailViewController.h
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJShopDetailViewController : YJBaseViewController

@property(nonatomic,strong)NSArray *shopArray;
@property(nonatomic,strong)NSString *shopMoneyStr;

@property(nonatomic,strong)NSString *ShopIdStr;

@property(nonatomic,strong)NSString *ShopIdNumberStr;

@property(nonatomic,strong)NSString *ProductIdStr;
@end

NS_ASSUME_NONNULL_END
