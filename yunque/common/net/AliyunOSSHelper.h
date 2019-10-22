//
//  AliyunOSSHelper.h
//  YunMaiQ
//
//  Created by 高爽 on 17/4/20.
//  Copyright © 2017年 XR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    AliyunOSSImageType_Moments,//司机端发动态
    AliyunOSSImageType_Feedback,//司机端截图反馈
    AliyunOSSImageType_Task,//司机端发行程
    AliyunOSSImageType_Certify, //司机端认证
    AliyunOSSImageType_Logo, //企业/司机,车辆logo
    AliyunOSSImageType_OrderSign, //司机,回单
    AliyunOSSImageType_Repair //报修 上传图片

}AliyunOSSImageType;

@interface AliyunOSSHelper : NSObject
@property(strong, nonatomic)void (^AliyunBlock)(NSMutableArray* arrayObj);
@property (strong, nonatomic)NSMutableArray* arrayObjGet;
@property(strong, nonatomic)NSString* typeUpload;
@property(strong, nonatomic)NSMutableArray* arrayObjGetMark;//arrayObjGetMark和arrayObjGet按顺序对应，block返回数据按mark对应取值

//上传图片的类型 如果是1就是认证的图片上传，如果是2就是其他图片上传
//@property (nonatomic,assign) NSInteger uploadImageType;

//司机端发图片类型
@property (nonatomic,assign) AliyunOSSImageType uploadImageType;

+ (instancetype)sharedInstance;
- (void)setupEnvironment;//环境配置
- (void)uploadObjectAsync;//上传
@end
