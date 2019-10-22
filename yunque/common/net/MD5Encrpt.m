//
//  MD5Encrpt.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "MD5Encrpt.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Encrpt
+(MD5Encrpt *)sharedInstance{
    static MD5Encrpt *sharedIntance = nil;
    @synchronized(self)
    {
        if (!sharedIntance) {
            sharedIntance = [[self alloc] init];
        }
        return sharedIntance;
    }
    
}

- (void)MD5WithDicStr:(NSString *)dicStr success:(void (^)(NSString *))success{
    NSString *resultStr = [self getMd5_32Bit_String:dicStr];
    success(resultStr);
}

//16位MD5加密方式
- (NSString *)getMd5_16Bit_String:(NSString *)srcString{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[self getMd5_32Bit_String:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}
//32位MD5加密方式
- (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    NSLog(@"scr=== %s",cStr);
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    //NSLog(@"re == %@",result);
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}
@end
