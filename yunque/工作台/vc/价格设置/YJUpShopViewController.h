//
//  YJUpShopViewController.h
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"
#import "EVNCustomSearchBar.h"
NS_ASSUME_NONNULL_BEGIN

@interface YJUpShopViewController : YJBaseViewController<EVNCustomSearchBarDelegate>
@property (strong, nonatomic) EVNCustomSearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END
