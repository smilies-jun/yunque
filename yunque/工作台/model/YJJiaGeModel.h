//
//  YJJiaGeModel.h
//  maike
//
//  Created by Apple on 2019/8/27.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJJiaGeModel : NSObject
@property(nonatomic,strong)NSArray *category;
@property(nonatomic,strong)NSString *ruleName;
@property(nonatomic,strong)NSString *updateDate;
@property (nonatomic)NSInteger profitMargin;
@property (nonatomic)NSInteger userId;
@end

NS_ASSUME_NONNULL_END
