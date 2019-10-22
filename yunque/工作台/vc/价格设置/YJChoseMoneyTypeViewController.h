//
//  YJChoseMoneyTypeViewController.h
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"
typedef void(^SubToMainBlock)(NSString *textStr,NSString *cataIdStr);
NS_ASSUME_NONNULL_BEGIN

@interface YJChoseMoneyTypeViewController : YJBaseViewController

@property(copy,nonatomic)SubToMainBlock mydata;
@property(copy,nonatomic)NSMutableArray * data;
@end

NS_ASSUME_NONNULL_END
