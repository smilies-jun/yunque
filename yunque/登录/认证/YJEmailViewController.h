//
//  YJEmailViewController.h
//  maike
//
//  Created by Apple on 2019/8/9.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJEmailViewController : YJBaseViewController
@property (nonatomic,strong) NSTimer *securityCodeTimer; //验证码倒计时
@property (nonatomic,strong) UIButton *GetCode;//验证码
@property (nonatomic,strong) NSString *codeStr;
@property (nonatomic,strong)NSString *shopId;

@end

NS_ASSUME_NONNULL_END
