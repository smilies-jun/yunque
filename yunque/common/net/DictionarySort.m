//
//  DictionarySort.m
//  shiyi
//
//  Created by super on 15/7/1.
//  Copyright (c) 2015年 于君. All rights reserved.
//

#import "DictionarySort.h"

@implementation DictionarySort

+(DictionarySort *)sharedInstance{
    static DictionarySort *sharedIntance = nil;
    @synchronized(self){
        if (!sharedIntance) {
            sharedIntance = [[self alloc] init];
        }
        return sharedIntance;
    }
}

-(NSString *)dictionarySort :(NSMutableDictionary *)mudic{
    NSDictionary *mutableDictionary = mudic;//定义一个可变字典
    
    NSArray *allKey = [mutableDictionary allKeys];//从可变字典中取出所有的key放入一个数组中
    
    //对数组进行升序排序,并存储到一个新的数组中
    NSArray *newKey = [allKey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString*)obj2];
    }];
    //取出所有的value值 按照排序后的key排列,并存入到一个新的数组中
    // NSMutableArray *allValue = [[NSMutableArray alloc] init];
    NSString *newString = @"";
    for (NSString *key in newKey){
        NSString *value = [mutableDictionary objectForKey:key];
        //[allValue addObject:value];把值放到一个新数组allValue中
        newString = [newString stringByAppendingString:key];
        newString = [newString stringByAppendingString:[NSString stringWithFormat:@"%@",value]];
    }
    newString = [newString stringByAppendingString:APP_SECRET];//生成的字符串后面再加上AppSecret(然后在拿这个新字符串去加密生成sign)
    return newString;
}
-(NSString *)dictionarySort :(NSMutableDictionary *)mudic :(NSString *)secretStr{
    NSMutableDictionary *mutableDictionary = mudic;//定义一个可变字典
    
    NSArray *allKey = [mutableDictionary allKeys];//从可变字典中取出所有的key放入一个数组中
    
    //对数组进行升序排序,并存储到一个新的数组中
    NSArray *newKey = [allKey sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString*)obj2];
    }];
    NSLog(@"newkeys = %@",newKey);
    //取出所有的value值 按照排序后的key排列,并存入到一个新的数组中
    // NSMutableArray *allValue = [[NSMutableArray alloc] init];
    NSString *newString = secretStr;
    for (NSString *key in newKey){
        NSString *value = [mutableDictionary objectForKey:key];
        //[allValue addObject:value];把值放到一个新数组allValue中
        newString = [newString stringByAppendingString:key];
        newString = [newString stringByAppendingString:value];
    }
    newString = [newString stringByAppendingString:secretStr];
    
    
    
    return newString;
}
@end
