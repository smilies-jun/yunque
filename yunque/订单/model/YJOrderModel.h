//
//  YJOrderModel.h
//  maike
//
//  Created by Apple on 2019/7/21.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJOrderModel : NSObject
@property(nonatomic,strong)NSString *suborderSn;
@property(nonatomic,strong)NSString *orderId;

@property(nonatomic,strong)NSString *orderSn;

@property(nonatomic,strong)NSString *receiverPhone;

@property(nonatomic,strong)NSString *buyer;
@property(nonatomic,strong)NSString *cod;
@property(nonatomic,strong)NSString *orderStatus;

@property(nonatomic,strong)NSString *receiverAddress;

@property(nonatomic,strong)NSString *street;

@property(nonatomic,strong)NSString *province;

@property(nonatomic,strong)NSString *commodityType;

@property(nonatomic,strong)NSString *city;

@property(nonatomic,strong)NSString *area;

@property(nonatomic,strong)NSString *address;

@property(nonatomic,strong)NSString *remarks;

@property(nonatomic,strong)NSString *actualAmount;

@property(nonatomic,strong)NSArray *orderDetailVOS;

@property(nonatomic,strong)NSString *productTotalAmount;

@property(nonatomic,strong)NSString *orderTotalAmount;
@property(nonatomic,strong)NSString *noPaidAmount;
@property(nonatomic,strong)NSString *paidAmount;

@property(nonatomic,strong)NSString *categoryPrice;

@property(nonatomic,strong)NSString *number;

@property(nonatomic,strong)NSString *orderImgUrl;

@property(nonatomic,strong)NSString *orderProductPayPrice;
@property(nonatomic,strong)NSString *sellerName;

@property(nonatomic,strong)NSString *orderProductTitle;

@property(nonatomic,strong)NSString *createDate;

@property(nonatomic,strong)NSString *payType;

@property(nonatomic,strong)NSString *transactionDate;
@property(nonatomic,strong)NSString *updateDate;

@property(nonatomic,strong)NSString *transaction;
@end

NS_ASSUME_NONNULL_END
