//
//  YJHotShopViewController.h
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"
#import "EVNCustomSearchBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJHotShopViewController : YJBaseViewController<EVNCustomSearchBarDelegate>
@property (strong, nonatomic) EVNCustomSearchBar *searchBar;
@property(nonatomic,strong)NSString *TypeStr;

@end

NS_ASSUME_NONNULL_END
