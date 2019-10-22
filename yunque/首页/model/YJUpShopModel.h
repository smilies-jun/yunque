//
//  YJUpShopModel.h
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJUpShopModel : NSObject
@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSString *commodityImage;

@property(nonatomic,strong)NSString *commodityName;

@property(nonatomic,strong)NSString *commodityDescArray;

@property(nonatomic,strong)NSString *commodityScore;

@property(nonatomic,strong)NSString *commodityType;

@property(nonatomic,strong)NSString *createTime;

@property(nonatomic,strong)NSString *logisticsName;

@property(nonatomic,strong)NSString *oid;

@property(nonatomic,strong)NSString *person;

@property(nonatomic,strong)NSString *phoneNumber;

@property(nonatomic,strong)NSString *promotion;

@property(nonatomic,strong)NSString *state;

@property(nonatomic,strong)NSString *commodityDesc;

@property(nonatomic,strong)NSString *logisticsNumber;

@property(nonatomic,assign)NSInteger showAllL;
@property (nonatomic ,assign) BOOL isAn;//是否展开


@end

NS_ASSUME_NONNULL_END
