//
//  YJHotShopModel.h
//  maike
//
//  Created by amin on 2019/8/23.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJHotShopModel : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *imageUrl;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *diyModelId;
@property(nonatomic,strong)NSString *phoneNumber;

@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *keyWord;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *onSale;

@property(nonatomic,strong)NSString *isHot;
@property(nonatomic,strong)NSString *createUser;

@property(nonatomic,strong)NSString *shoppingGuide;

@property(nonatomic,strong)NSString *doorColumnStyle;
@property(nonatomic,strong)NSString *doorHeadStyle;
@property(nonatomic,strong)NSString *style;

@property(nonatomic,strong)NSString *customerId;
@property(nonatomic,strong)NSString *gender;
@property(nonatomic,strong)NSString *pcategory;

@property(nonatomic,strong)NSString *productAdvanta;
@property(nonatomic,strong)NSString *productImg;
@property(nonatomic,strong)NSString *productDes;
@property(nonatomic,strong)NSString *marketRefrencePrice;
@property(nonatomic,strong)NSString *totalStock;
@property(nonatomic,strong)NSString *commodityId;
@property(nonatomic,strong)NSString *salesVolume;
@property(nonatomic,strong)NSString *title;
//@property (nonatomic)double totalStock;



@property(nonatomic,strong)NSString *chinesePrice;
//@property (nonatomic)double marketRefrencePrice;
@end

NS_ASSUME_NONNULL_END
