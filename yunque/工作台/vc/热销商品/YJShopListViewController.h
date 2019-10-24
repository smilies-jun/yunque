//
//  YJShopListViewController.h
//  maike
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJShopListViewController : YJBaseViewController

@property(nonatomic,strong)NSString *cataIdStr;
@property(nonatomic,strong)NSString *TypeStr;
@property(nonatomic,strong)NSString *TitleStr;
@property(nonatomic,strong)NSString *resultStr;
@property(nonatomic,copy)NSString *distributor;


@end

NS_ASSUME_NONNULL_END
