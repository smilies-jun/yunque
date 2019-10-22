//
//  AliyunOSSHelper.m
//  YunMaiQ
//
//  Created by 高爽 on 17/4/20.
//  Copyright © 2017年 XR. All rights reserved.
//


#import "AliyunOSSHelper.h"
#import <AliyunOSSiOS/OSSService.h>
#import <UIKit/UIKit.h>
NSString * const AccessKey = @"LTAI4FpjRLsxFev1L2a9tTh7";
NSString * const SecretKey = @"SUwnNBqn9pGvhBhuQ2K60SZyWbSEXM";
NSString * const endPoint = @"http://oss-cn-zhangjiakou.aliyuncs.com";
//NSString * const endPointCertifa = @"http://id-images.logibeat.com";//认证
@interface AliyunOSSHelper()
@property (strong, nonatomic)NSMutableArray* arrayObjSend;

@end

@implementation AliyunOSSHelper
OSSClient * client;
static dispatch_queue_t queue4demo;
+ (instancetype)sharedInstance{
    static AliyunOSSHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [AliyunOSSHelper new];
        
    });
    
    return instance;
}

- (void)setupEnvironment{
    _arrayObjSend  =[NSMutableArray arrayWithCapacity:3];
    
    if (_arrayObjGetMark) {
        [_arrayObjGetMark removeAllObjects];
        _arrayObjGetMark = nil;
    }
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:AccessKey
                                                                                                            secretKey:SecretKey];
    
    // 自实现签名，可以用本地签名也可以远程加签
    id<OSSCredentialProvider> credential1 = [[OSSCustomSignerCredentialProvider alloc] initWithImplementedSigner:^NSString *(NSString *contentToSign, NSError *__autoreleasing *error) {
        NSString *signature = [OSSUtil calBase64Sha1WithData:contentToSign withSecret:@"<your secret key>"];
        if (signature != nil) {
            *error = nil;
        } else {
            // construct error object
            *error = [NSError errorWithDomain:@"<your error domain>" code:OSSClientErrorCodeSignFailed userInfo:nil];
            return nil;
        }
        return [NSString stringWithFormat:@"OSS %@:%@", @"<your access key>", signature];
    }];
    
    
    id<OSSCredentialProvider> credential2 = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        NSURL * url = [NSURL URLWithString:@"https://localhost:8080/distribute-token.json"];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        OSSTaskCompletionSource * tcs = [OSSTaskCompletionSource taskCompletionSource];
        NSURLSession * session = [NSURLSession sharedSession];
        NSURLSessionTask * sessionTask = [session dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if (error) {
                                                            [tcs setError:error];
                                                            return;
                                                        }
                                                        [tcs setResult:data];
                                                    }];
        [sessionTask resume];
        [tcs.task waitUntilFinished];
        if (tcs.task.error) {
//            NSLog(@"get token error: %@", tcs.task.error);
            return nil;
        } else {
            NSDictionary * object = [NSJSONSerialization JSONObjectWithData:tcs.task.result
                                                                    options:kNilOptions
                                                                      error:nil];
            OSSFederationToken * token = [OSSFederationToken new];
            token.tAccessKey = [object objectForKey:@"accessKeyId"];
            token.tSecretKey = [object objectForKey:@"accessKeySecret"];
            token.tToken = [object objectForKey:@"securityToken"];
            token.expirationTimeInGMTFormat = [object objectForKey:@"expiration"];
//            NSLog(@"get token: %@", token);
            return token;
        }
    }];
    
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
//    if (_uploadImageType == 1)
//    {
//        client = [[OSSClient alloc] initWithEndpoint:endPointCertifa credentialProvider:credential clientConfiguration:conf];
//
//    }else
//    {
//
//    }
    client = [[OSSClient alloc] initWithEndpoint:endPoint credentialProvider:credential clientConfiguration:conf];

    
}
- (NSString *)createCUID:(NSString *)prefix
{
    
    NSString *  result;
    
    CFUUIDRef  uuid;
    
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    
    result =[NSString stringWithFormat:@"%@",uuidStr];
    
    result  =[result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    result =[NSString stringWithFormat:@"%@%@", prefix,result];
    CFRelease(uuidStr);
    
    CFRelease(uuid);
    
    return result;
    
}
// 异步上传
- (void)uploadObjectAsync {
    
    [_arrayObjGet enumerateObjectsUsingBlock:^(NSData* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDate  *currentDate = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:currentDate];
        
        NSInteger year=[components year];
        NSInteger month=[components month];
        NSInteger day=[components day];
        NSInteger shi=[components hour];
        NSInteger fen=[components minute];
        //    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,year,month,day);
        
        //    NSString* strUdid = [[UIDevice currentDevice].identifierForVendor.UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];;
        //
        //       Android这边 http://logibeat.oss-cn-hangzhou.aliyuncs.com/prod/notice/images/2017/05/11/Android-1136-e56375bba04c4cb5ba0e0b49883b0a27.jpg
        //历史
        //http://note.youdao.com/share/?id=eb57a5aedf6fd957f6f2987530e69b40&type=note#/
        NSString* str = @"";
        
        NSString* strEnvironmentType = @"yzyunque";//正式环境prod,其它test
//
       NSString *uuid = [[NSUUID UUID] UUIDString];
        NSString *uuidStr =[uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
         str = [NSString stringWithFormat:@"%@/%@/repair/%ld%ld/%ld%ld%ld_%ld%ld_%@_%@",strEnvironmentType,@"YunQueApp",year,month,year,month,day,shi,fen,uuidStr,@"iOS"];
        if (self->_arrayObjGetMark) {//按顺序上传时候需要
            if (idx<=[self->_arrayObjGetMark count]-1) {
                str = [str stringByAppendingString:self->_arrayObjGetMark[idx]];
                
            }
        }
        str = [str stringByAppendingString:@".jpg"];
        
        OSSPutObjectRequest * put = [OSSPutObjectRequest new];
        
        // required fields
        
//        if (self->_uploadImageType == 1)
//        {
//            put.bucketName = @"zjmaike";
//
//        }else
//        {
//            put.bucketName = @"logibeat-test";
//
//        }
        
        put.bucketName = @"yzyunque";
        put.objectKey = str;
        //    NSString * docDir = [self getDocumentDirectory];
        //    put.uploadingFileURL = [NSURL fileURLWithPath:[docDir stringByAppendingPathComponent:@"file1m"]];
        
        // optional fields
        put.uploadingData = obj;
        put.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        };
        put.contentType = @"";
        put.contentMd5 = @"";
        put.contentEncoding = @"";
        put.contentDisposition = @"";
        
        OSSTask * putTask = [client putObject:put];
        
        [putTask continueWithBlock:^id(OSSTask *task) {
            if (!task.error) {
                [self signAccessObjectURL:str];
            } else {
                
                if (self.AliyunBlock) {
                    self.AliyunBlock(nil);
                }
            }
            return nil;
        }];
    }];
}
// 签名URL授予第三方访问
- (void)signAccessObjectURL:(NSString*)strKey {
   //NSString * constrainURL = nil;
    NSString * publicURL = nil;
    
    // sign constrain url
    OSSTask *task = nil;
    
    
//    if (_uploadImageType == 1)
////    {
//        task = [client presignConstrainURLWithBucketName:@"zjmaike"
//                                           withObjectKey:strKey
//                                  withExpirationInterval:2222222978307200];
//
//    }else
//    {
//        task = [client presignConstrainURLWithBucketName:@"logibeat-test"
//                                           withObjectKey:strKey
//                                  withExpirationInterval:60 * 30];

//    }
    
    
//    if (!task.error) {
//        constrainURL = task.result;
//    } else {
//    }
    
    // sign public url
    
//    if (_uploadImageType == 1)
////    {
        task = [client presignPublicURLWithBucketName:@"yzyunque"
                                        withObjectKey:strKey];
    
//    }else
//    {
//        task = [client presignPublicURLWithBucketName:@"logibeat-test"
//                                        withObjectKey:strKey];

//    }
    
    if (!task.error) {
        publicURL = task.result;
        
        [_arrayObjSend addObject:publicURL];
        if (_arrayObjSend.count == _arrayObjGet.count) {
            if (self.AliyunBlock) {
                self.AliyunBlock(_arrayObjSend);
            }
        }
        
        
    } else {
    }
}
@end
