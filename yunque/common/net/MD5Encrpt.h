//
//  MD5Encrpt.h
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encrpt : NSObject

+ (MD5Encrpt *)sharedInstance;

- (void)MD5WithDicStr:(NSString *)dicStr success:(void (^)(NSString *))success;

- (NSString *)getMd5_32Bit_String:(NSString *)srcString;

@end
