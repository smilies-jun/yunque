//
//  YJKeHuModel.h
//  maike
//
//  Created by Apple on 2019/8/19.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJKeHuModel : NSObject
@property(nonatomic,strong)NSString *phoneNumber;

@property(nonatomic,strong)NSString *phone;

@property(nonatomic,strong)NSString *nickName;

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *actualName;
@property(nonatomic,strong)NSString *userId;

@property(nonatomic,strong)NSString *lastloginDateStr;
@property(nonatomic,strong)NSString *forbidden;
@property(nonatomic,strong)NSArray *roleList;

@property(nonatomic,strong)NSString *customerId;
@property(nonatomic,strong)NSString *gender;

@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSArray *city;

@property(nonatomic,strong)NSString *town;
@property(nonatomic,strong)NSString *province;


@end

NS_ASSUME_NONNULL_END
