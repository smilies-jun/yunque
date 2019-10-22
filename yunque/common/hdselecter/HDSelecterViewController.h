//
//  HDSelecterViewController.h
//  hdselecter
//
//  Created by meng on 2017/12/18.
//  Copyright © 2017年 hugdream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDSelecterView.h"

@interface HDSelecterViewController : UIViewController

-(instancetype)initWithDefualtProvince:(NSString*)province city:(NSString*)city districts:(NSString*)districts;

@property(nonatomic,strong,readonly)HDSelecterView* selecterView;
@property(nonatomic,copy)void(^completeSelectBlock)(NSString*province,NSString*provincecategoryId,NSString*city,NSString*citycategoryId,NSString*districts,NSString*districtscategoryId);
@property(nonatomic,strong)NSArray *MyArray; //数据源
@property(nonatomic,strong)NSString *MyFirstStr;//1级参数
@property(nonatomic,strong)NSString *MySecondStr; //2级参数
@property(nonatomic,strong)NSString *MyThirdStr;//3级参数
@property(nonatomic,strong)NSString *MyFourStr;//4级参数
@property(nonatomic,strong)NSString *MyFiveStr;//4级参数
@property(nonatomic,strong)NSString *categoryId;//4级参数
@end
