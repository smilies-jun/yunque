//
//  DateSource.m
//  YWD
//
//  Created by 007 on 15/10/28.
//  Copyright © 2015年 star. All rights reserved.
//

#import "DateSource.h"
#import <AliyunOSSiOS/OSSService.h>

@implementation DateSource
+ (DateSource *)sharedInstance{
    static DateSource *_sharedMydata;
    static dispatch_once_t token;
    
    dispatch_once(&token,^{ _sharedMydata = [[DateSource alloc] init];} );
    
    return _sharedMydata;
}



-(void)md5WithParameters:(NSMutableDictionary *)parameters usingBlock:(void (^)(NSMutableDictionary *, NSError *))block{
    NSString  *mutableDictionaryConvertTo_A_String_WithAppSecret =  [[DictionarySort sharedInstance]dictionarySort:parameters];
    _sign =   [[MD5Encrpt sharedInstance] getMd5_32Bit_String:mutableDictionaryConvertTo_A_String_WithAppSecret ];
    [parameters setObject:_sign forKey:@"sign"];
    NSError *error = nil;
    block(parameters,error);
}

- (void)CheckNetWorkinguseingBlock:(void (^)(NSString *staus))block{
    AFNetworkReachabilityManager *Netmanager = [AFNetworkReachabilityManager sharedManager];
    
    [Netmanager startMonitoring];
    
    
    [Netmanager  setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *CheckStr;

        if (status == -1) {
            
            CheckStr = [NSString stringWithFormat:@"未识别网络"];
        }
        if (status == 0) {
            CheckStr = [NSString stringWithFormat:@"未连接网络"];
        }
        if (status == 1) {
            CheckStr = [NSString stringWithFormat:@"3G/4G网络"];
        }
        if (status == 2) {
            CheckStr = [NSString stringWithFormat:@"Wifi网络"];
        }
        if (block) {
            block(CheckStr);
        }
        
    }];

}



- (void)requestHomeWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url withTokenStr:(NSString *)tokenStr usingBlock:(void (^)(NSDictionary *, NSError *))block{
    if (manager) {
        manager = nil;
    }
    [self CheckNetWorkinguseingBlock:^(NSString *staus) {
        
        if ([staus isEqualToString:@"未连接网络"]) {
             [AnimationView showString:@"请检查网络"];

        }else{
           NSuserSave(@"0", @"Net");
        }
        
       
    }];
//    __block NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [self md5WithParameters:parameters usingBlock:^(NSMutableDictionary *result, NSError *error) {
//        parameter = result;
//    }];
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (tokenStr.length) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil];    //发送POST请求
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (block) {
            block(responseObject,nil);
        }
        NSLog(@" == == = =%@",task);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: ======================%@", error);
        if (block) {
            block(nil,error);
        }
    }];
    
    
    
}
- (void)requestDeleteWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url withTokenStr:(NSString *)tokenStr usingBlock:(void (^)(NSDictionary *, NSError *))block{
    [self CheckNetWorkinguseingBlock:^(NSString *staus) {
        
        if ([staus isEqualToString:@"未连接网络"]) {
             [AnimationView showString:@"请检查网络"];

        }else{
            NSuserSave(@"0", @"Net");
        }
        
        
    }];
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (tokenStr.length) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
        
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream", nil];
    [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        
        if (block) {
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }

    }];
}
- (void)requestHtml5WithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url withTokenStr:(NSString *)tokenStr usingBlock:(void (^)(NSDictionary *, NSError *))block{
    if (manager) {
        manager = nil;
    }
    [self CheckNetWorkinguseingBlock:^(NSString *staus) {
        
        if ([staus isEqualToString:@"未连接网络"]) {
             [AnimationView showString:@"请检查网络"];

        }else{
            NSuserSave(@"0", @"Net");
        }
        
        
    }];//    __block NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
//    [self md5WithParameters:parameters usingBlock:^(NSMutableDictionary *result, NSError *error) {
//        parameter = result;
//    }];
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (tokenStr.length) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
        
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream", nil];    //发送get请求
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
      
           
           
        if (block) {
                       block(responseObject,nil);
                   }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
                        block(nil,error);
                    }

    }];


}

- (void)requestPutWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url withTokenStr:(NSString *)tokenStr usingBlock:(void (^)(NSDictionary *result, NSError *error))block{
    if (manager) {
        manager = nil;
    }
    __block NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];

    [self md5WithParameters:parameters usingBlock:^(NSMutableDictionary *result, NSError *error) {
        parameter = result;
    }];
    [self CheckNetWorkinguseingBlock:^(NSString *staus) {
        
        if ([staus isEqualToString:@"未连接网络"]) {
             [AnimationView showString:@"请检查网络"];

        }else{
            NSuserSave(@"0", @"Net");
        }
        
        
    }];    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (tokenStr.length) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
        
    }

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream", nil];    //发送get请求
    [manager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        if (block) {
            block(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (block) {
            block(nil,error);
        }

    }];
    
//    [manager POST:url parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
//        NSLog(@"目前请求进度");
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (block) {
//            block(responseObject,nil);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"Error: ======================%@", error);
//        if (block) {
//            block(nil,error);
//        }
//    }];

}

- (void)requestImageWithParameters:(NSMutableDictionary *)parameters withUrl:(NSString *)url withTokenStr:(NSString *)tokenStr usingBlock:(void (^)(NSDictionary *, NSError *))block{
    if (manager) {
        manager = nil;
    }
    [self CheckNetWorkinguseingBlock:^(NSString *staus) {
        
        if ([staus isEqualToString:@"未连接网络"]) {
            [AnimationView showString:@"请检查网络"];

        }else{
            NSuserSave(@"0", @"Net");
        }
        
        
    }];    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if (tokenStr.length) {
        [manager.requestSerializer setValue:tokenStr forHTTPHeaderField:@"token"];
        
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/octet-stream", nil];    //发送get请求
    
   
}
@end
