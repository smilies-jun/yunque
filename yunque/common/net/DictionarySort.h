//
//  DictionarySort.h
//  shiyi
//
//  Created by super on 15/7/1.
//  Copyright (c) 2015年 于君. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DictionarySort : NSObject
+(DictionarySort *)sharedInstance;
/**
 *  排序方法 生成MD5所需要的sign字符串，然后再使用
 *
*/
-(NSString *)dictionarySort:(NSMutableDictionary*)mudic;
// 生成的字符串前后分别在加一个字符串
-(NSString *)dictionarySort :(NSMutableDictionary *)mudic :(NSString *)secretStr;
@end
