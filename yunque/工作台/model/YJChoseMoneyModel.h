//
//  YJChoseMoneyModel.h
//  maike
//
//  Created by Apple on 2019/8/15.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJChoseMoneyModel : NSObject

@property(nonatomic,strong)NSString *name;
@property (strong, nonatomic) NSArray *children;

@property (nonatomic) NSInteger select;
@end

NS_ASSUME_NONNULL_END
