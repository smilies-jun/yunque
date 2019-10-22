//
//  YJPinPaiDetailViewController.h
//  yunque
//
//  Created by Apple on 2019/10/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"
#import "YNPageConfigration.h"
#import "YNPageViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface YJPinPaiDetailViewController : YNPageViewController
+ (instancetype)suspendCenterPageVC:(NSString *)braid imageUrl:(NSString *)imageUrl detailTitle:(NSString *)detaiTitle brandTitle:(NSString *)brandTitle;

+ (instancetype)suspendCenterPageVCWithConfig:(YNPageConfigration *)config:(NSString *)braid imageUrl:(NSString *)imageUrl detailTitle:(NSString *)detaiTitle brandTitle:(NSString *)brandTitle;



@end

NS_ASSUME_NONNULL_END
