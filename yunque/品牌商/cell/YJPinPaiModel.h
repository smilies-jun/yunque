//
//  YJPinPaiModel.h
//  yunque
//
//  Created by Apple on 2019/10/15.
//  Copyright © 2019 yj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJPinPaiModel : NSObject
@property (nonatomic, copy) NSString *iconImagePath;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *imagePathsArray;


@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *brandIcon;

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *brandDescription;
@property (nonatomic, copy) NSString *brandId;


@property (nonatomic, copy) NSArray *masterImageUrls;

@property (nonatomic, copy) NSString *productAdvanta;

@property (nonatomic, copy) NSString *productImg;

@property (nonatomic, copy) NSString *productDes;

@end

NS_ASSUME_NONNULL_END
