//
//  YJHtmlShopDetailViewController.h
//  maike
//
//  Created by Apple on 2019/9/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJHtmlShopDetailViewController : YJBaseViewController
@property(nonatomic,strong)NSArray *shopArray;

@property(nonatomic,strong)NSString *shopMoneyStr;

@property(nonatomic,strong)NSString *ShopIdStr;

@property(nonatomic,strong)NSString *ShopIdNumberStr;

@property(nonatomic,strong)NSString *ProductIdStr;

@property(nonatomic,strong)NSString *ProductTitleStr;

@property(nonatomic,strong)NSString *ProductImageStr;
@property(nonatomic,strong)NSArray *ProductArray;
@end

NS_ASSUME_NONNULL_END
