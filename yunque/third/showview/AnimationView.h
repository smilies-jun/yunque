//
//  AnimationView.h
//  OneExpress
//
//  Created by Taidy on 14/12/4.
//  Copyright (c) 2014年 YDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIImageView * blackImage;


+ (void)showString:(NSString *)string;

+ (NSString *)getTImeBytimestampString:(NSString *)timstampStr;
+ (NSString *)getTImeBytimestampString:(NSString *)timstampStr dateFormatter:(NSString *)f;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
#ifndef UIColorHex
#define UIColorHex(_hex_)   [AnimationView colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif


@end
