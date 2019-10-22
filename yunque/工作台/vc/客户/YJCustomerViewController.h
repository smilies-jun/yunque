//
//  YJCustomerViewController.h
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJCustomerViewController : YJBaseViewController

@property (nonatomic, copy) void(^ChoseCustomerBlock) (NSString * string,NSString *custonerid);
@property (nonatomic, copy) void(^ChoseShopBlock) (NSString * string,NSString *adress,NSString *custonerid);
@property (nonatomic,strong)NSString *type;
@end

NS_ASSUME_NONNULL_END
