//
//  YJLoginAndReginViewController.h
//  maike
//
//  Created by Apple on 2019/7/22.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJLoginAndReginViewController : YJBaseViewController
@property (nonatomic,strong) NSTimer *securityCodeTimer; //验证码倒计时
@property (nonatomic,strong) UIButton *GetCode;//验证码
@property (nonatomic,strong) NSString *codeStr;
@end

NS_ASSUME_NONNULL_END
