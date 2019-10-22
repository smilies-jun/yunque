//
//  YJUserShouCangViewController.h
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"
#import "EVNCustomSearchBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJUserShouCangViewController : YJBaseViewController<EVNCustomSearchBarDelegate>
@property (strong, nonatomic) EVNCustomSearchBar *mysearchBar;

@end

NS_ASSUME_NONNULL_END
