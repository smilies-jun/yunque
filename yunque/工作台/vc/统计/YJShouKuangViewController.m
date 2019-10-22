//
//  YJShouKuangViewController.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShouKuangViewController.h"
#import "ZFChart.h"

@interface YJShouKuangViewController ()<ZFGenericChartDataSource, ZFBarChartDelegate,ZFWaveChartDelegate>{
    UIScrollView *scrollView;
    UIButton *AllBtn;
    UIButton *UseBtn;
    UIButton *complyBtn;
    UIButton *timeBtn;
    UILabel *xsLabel;
    NSMutableArray *topArray;
    NSMutableArray *bottomArray;
    
    NSMutableArray *topZhuArray;
    NSMutableArray *bottomZhuArray;
    NSString *totalStr;
    NSString * max;
    NSString * zhumax;
    
    NSString *state;
    
}
@property (nonatomic, strong) ZFBarChart * barChart;
@property (nonatomic, strong) ZFWaveChart * waveChart;

@property (nonatomic, assign) CGFloat height;

@end

@implementation YJShouKuangViewController

- (void)setUp{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.5;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
}
- (void)initUI{
    self.TopView.hidden = YES;
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44);
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT+200);
    [self.view addSubview:scrollView];
    
    AllBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [AllBtn setTitle:@"全部" forState:UIControlStateNormal];
    [AllBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    AllBtn.tag = 100;
    AllBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    AllBtn.tintColor = [UIColor whiteColor];
    AllBtn.backgroundColor = font_main_color;
    AllBtn.layer.masksToBounds = YES;
    AllBtn.layer.cornerRadius = 15;
    [scrollView addSubview:AllBtn];
    [AllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->scrollView.mas_left).offset(40);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
    UseBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [UseBtn setTitle:@"已生效" forState:UIControlStateNormal];
    [UseBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UseBtn.tag = 200;
    UseBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    UseBtn.tintColor = [UIColor whiteColor];
    UseBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    UseBtn.layer.masksToBounds = YES;
    UseBtn.layer.cornerRadius = 15;    [scrollView addSubview:UseBtn];
    [UseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->AllBtn.mas_right).offset(20);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    complyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [complyBtn setTitle:@"已完成" forState:UIControlStateNormal];
    [complyBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    complyBtn.tag = 300;
    complyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    complyBtn.tintColor = [UIColor whiteColor];
    complyBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    complyBtn.layer.masksToBounds = YES;
    complyBtn.layer.cornerRadius = 15;
    [scrollView addSubview:complyBtn];
    [complyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->UseBtn.mas_right).offset(20);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    timeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [timeBtn setTitle:@"近6个月" forState:UIControlStateNormal];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    timeBtn.tintColor = [UIColor whiteColor];
    timeBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    timeBtn.layer.masksToBounds = YES;
    timeBtn.layer.cornerRadius = 15;
    [timeBtn setTintColor:[UIColor blackColor]];
    [scrollView addSubview:timeBtn];
    [timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_right).offset(-100);
        make.top.mas_equalTo(self->scrollView.mas_top).offset(20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    UILabel *xiaoshouLabel = [[UILabel alloc]init];
    xiaoshouLabel.text = @"累计销售额";
    xiaoshouLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    xiaoshouLabel.font = [UIFont systemFontOfSize:12];
    [scrollView addSubview:xiaoshouLabel];
    [xiaoshouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->scrollView.mas_left).offset(40);
        make.top.mas_equalTo(self->AllBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(12);
    }];
    xsLabel = [[UILabel alloc]init];
    xsLabel.text = [NSString stringWithFormat:@"￥%@元",totalStr];
    xsLabel.font = [UIFont boldSystemFontOfSize:16];
    [scrollView addSubview:xsLabel];
    [xsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->scrollView.mas_left).offset(40);
        make.top.mas_equalTo(xiaoshouLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(32);
    }];
}
- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 100) {
        state = @"0";
        AllBtn.tintColor = [UIColor whiteColor];
        AllBtn.backgroundColor = font_main_color;
        
        complyBtn.tintColor = [UIColor whiteColor];
        complyBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
        
        UseBtn.tintColor = [UIColor whiteColor];
        UseBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
        
        
        
    }else if (btn.tag ==300){
        state = @"2";
        AllBtn.tintColor = [UIColor whiteColor];
        AllBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
        
        complyBtn.tintColor = [UIColor whiteColor];
        complyBtn.backgroundColor = font_main_color;
        
        UseBtn.tintColor = [UIColor whiteColor];
        UseBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
    }else{
        state = @"1";
        AllBtn.tintColor = [UIColor whiteColor];
        AllBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
        
        complyBtn.tintColor = [UIColor whiteColor];
        complyBtn.backgroundColor = colorWithRGB(0.94, 0.94, 0.94);
        
        UseBtn.tintColor = [UIColor whiteColor];
        UseBtn.backgroundColor = font_main_color;
    }
    [self reloadData:state];
}
- (void)reloadData:(NSString *)state{
    NSString *tokenID = NSuserUse(@"token");
    [bottomZhuArray removeAllObjects];
    [bottomArray removeAllObjects];
    [topArray    removeAllObjects];
    [topZhuArray removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"%@/account/salesDiscountedView?month=6&status=1&type=2",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            for (int i = 0 ; i< [[[result objectForKey:@"data"]objectForKey:@"data"] count] ; i++) {
                NSString *str = [NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectForKey:@"data"]objectAtIndex:i]];
                if ([str integerValue]) {
                    [self->bottomArray addObject:str];
                }else{
                    [self->bottomArray addObject:@"0"];
                }
                
            }
            
            for (int i = 0 ; i< [[[result objectForKey:@"data"]objectForKey:@"columnKeys"] count] ; i++) {
                NSString *str = [NSString stringWithFormat:@"%@月", [[[result objectForKey:@"data"]objectForKey:@"columnKeys"]objectAtIndex:i]];
                [self->topArray addObject:str];
            }
            self->max = [NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"dataMax"]];
            [self reloadAlldata];
          //  [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
    
    
    
    
}
- (void)reloadAlldata{
    NSString *tokenID = NSuserUse(@"token");
    
    NSString *ZhuUrl = [NSString stringWithFormat:@"%@/account/salesNumCylindricalView?month=12&status=1&type=1",BASE_URL];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:ZhuUrl withTokenStr:tokenID usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
            for (int i = 0 ; i< [[[result objectForKey:@"data"]objectForKey:@"data"] count] ; i++) {
                NSString *str = [NSString stringWithFormat:@"%@", [[[result objectForKey:@"data"]objectForKey:@"data"]objectAtIndex:i]];
                if ([str integerValue]) {
                    [self->bottomZhuArray addObject:str];
                }else{
                    [self->bottomZhuArray addObject:@"0"];
                }
                
            }
            
            self->zhumax =[NSString stringWithFormat:@"%@",[[result objectForKey:@"data"]objectForKey:@"dataMax"]];
            for (int i = 0 ; i< [[[result objectForKey:@"data"]objectForKey:@"columnKeys"] count] ; i++) {
                NSString *str = [NSString stringWithFormat:@"%@月", [[[result objectForKey:@"data"]objectForKey:@"columnKeys"]objectAtIndex:i]];
                [self->topZhuArray addObject:str];
                
            }
            self->totalStr = [NSString stringWithFormat:@"%@",[[[result objectForKey:@"data"]objectForKey:@"total"]objectAtIndex:0]];
            self->xsLabel.text = [NSString stringWithFormat:@"￥%@元",totalStr];

            [self.barChart strokePath];
            [self.waveChart strokePath];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }
        
    }];
}
- (void)intChart{
    self.barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH,300)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"销售额";
    self.barChart.topicLabel.frame = CGRectMake(40, 0, 200, 20);
    self.barChart.topicLabel.textAlignment = NSTextAlignmentLeft;
    self.barChart.unit = @"万";
    //    self.barChart.isAnimated = NO;
    //    self.barChart.isResetAxisLineMinValue = YES;
    self.barChart.isResetAxisLineMaxValue = YES;
    self.barChart.tag = 100;
    //    self.barChart.isShowAxisLineValue = NO;
    //    self.barChart.valueLabelPattern = kPopoverLabelPatternBlank;
    self.barChart.isShowXLineSeparate = YES;
    self.barChart.isShowYLineSeparate = YES;
    //    self.barChart.topicLabel.textColor = ZFWhite;
    // self.barChart.unitColor = ZFWhite;
    //    self.barChart.xAxisColor = ZFWhite;
    //    self.barChart.yAxisColor = ZFWhite;
    //    self.barChart.xAxisColor = ZFClear;
    //    self.barChart.yAxisColor = ZFClear;
    //self.barChart.axisLineNameColor = ZFWhite;
    //    self.barChart.axisLineValueColor = ZFWhite;
    //    self.barChart.backgroundColor = ZFPurple;
    //    self.barChart.isShowAxisArrows = NO;
    self.barChart.separateLineStyle = kLineStyleDashLine;
    //    self.barChart.isMultipleColorInSingleBarChart = YES;
    //    self.barChart.separateLineDashPhase = 0.f;
    //    self.barChart.separateLineDashPattern = @[@(5), @(5)];
    
    [scrollView addSubview:self.barChart];
    [self.barChart strokePath];
    
    
    self.waveChart = [[ZFWaveChart alloc] initWithFrame:CGRectMake(0, 440, SCREEN_WIDTH, 300)];
    self.waveChart.dataSource = self;
    self.waveChart.delegate = self;
    self.waveChart.topicLabel.text = @"销售额增长率";
    self.waveChart.topicLabel.frame = CGRectMake(40, 0, 200, 20);
    self.waveChart.topicLabel.textAlignment = NSTextAlignmentLeft;
    self.waveChart.unit = @"万";
    self.waveChart.tag = 101;
    //    self.waveChart.isShowYLineSeparate = YES;
    //    self.waveChart.pathColor = ZFGrassGreen;
    self.waveChart.pathLineColor = ZFLightGray;
    self.waveChart.topicLabel.textColor = font_main_color;
    //    self.waveChart.isAnimated = NO;
    //    self.waveChart.isResetAxisLineMinValue = YES;
    //    self.waveChart.isShowAxisLineValue = NO;
    //    self.waveChart.isShadowForValueLabel = NO;
    //    self.waveChart.valuePosition = kChartValuePositionOnBelow;
    //    self.waveChart.valueLabelPattern = kPopoverLabelPatternBlank;
    //    self.waveChart.wavePatternType = kWavePatternTypeForSharp;
    //    self.waveChart.valueLabelToWaveLinePadding = 20.f;
    [self.waveChart strokePath];
    [scrollView addSubview:self.waveChart];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    topArray = [[NSMutableArray alloc]init];
    bottomArray = [[NSMutableArray alloc]init];
    
    topZhuArray = [[NSMutableArray alloc]init];
    bottomZhuArray = [[NSMutableArray alloc]init];
    state = @"0";
    [self reloadData:state];
    [self initUI];
    [self setUp];
    [self intChart];
    
    
}

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    if (chart.tag == 100) {
        if (bottomArray.count) {
            return bottomArray;
        }
        return @[@"123", @"256", @"300", @"283", @"490", @"236"];
    }else{
        if (bottomZhuArray.count) {
            return bottomZhuArray;
        }
        return @[@"0", @"0", @"0", @"0", @"0", @"0"];
    }
    
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    if (chart.tag == 100) {
        if (topArray.count) {
            return topArray;
        }
        return @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级"];
    }else{
        if (topZhuArray.count) {
            return topZhuArray;
        }
        return @[@"一年级", @"二年级", @"三年级", @"四年级", @"五年级", @"六年级"];
    }
    
}

//- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
//    return @[ZFMagenta];
//
////    return @[ZFRandom, ZFRandom, ZFRandom, ZFRandom, ZFRandom, ZFRandom];
//}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    if (chart.tag == 100) {
        if ([max integerValue]) {
            return [max integerValue];
        }
        return 10;
    }else{
        if ([zhumax integerValue]) {
            return [zhumax integerValue];
        }
        return 10;
    }
    
}

//- (CGFloat)axisLineMinValueInGenericChart:(ZFGenericChart *)chart{
//    return 50;
//}

- (NSUInteger)axisLineSectionCountInGenericChart:(ZFGenericChart *)chart{
    if (chart.tag == 100) {
        if (topArray.count) {
            return topArray.count;
        }
        return 6;
    }else{
        if (topZhuArray.count) {
            return topZhuArray.count;
        }
        return 6;
    }
    
}

//- (NSInteger)axisLineStartToDisplayValueAtIndex:(ZFGenericChart *)chart{
//    return -7;
//}

- (void)genericChartDidScroll:(UIScrollView *)scrollView{
    NSLog(@"当前偏移量 ------ %f", scrollView.contentOffset.x);
}

#pragma mark - ZFBarChartDelegate

//- (CGFloat)barWidthInBarChart:(ZFBarChart *)barChart{
//    return 40.f;
//}

//- (CGFloat)paddingForGroupsInBarChart:(ZFBarChart *)barChart{
//    return 40.f;
//}

//- (id)valueTextColorArrayInBarChart:(ZFGenericChart *)barChart{
//    return ZFBlue;
//}

- (NSArray *)gradientColorArrayInBarChart:(ZFBarChart *)barChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)font_main_color.CGColor, (id)ZFWhite.CGColor];
    gradientAttribute.locations = @[@(0.5), @(0.99)];
    
    return [NSArray arrayWithObjects:gradientAttribute, nil];
}

- (void)barChart:(ZFBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex bar:(ZFBar *)bar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)barIndex);
    
    //可在此处进行bar被点击后的自身部分属性设置,可修改的属性查看ZFBar.h
    bar.barColor = ZFGold;
    bar.isAnimated = YES;
    //    bar.opacity = 0.5;
    [bar strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
    //    popoverLabel.hidden = NO;
}

- (void)barChart:(ZFBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFSkyBlue;
    //    [popoverLabel strokePath];
}
#pragma mark - ZFWaveChartDelegate

//- (CGFloat)groupWidthInWaveChart:(ZFWaveChart *)waveChart{
//    return 50.f;
//}

//- (CGFloat)paddingForGroupsInWaveChart:(ZFWaveChart *)waveChart{
//    return 20.f;
//}

- (ZFGradientAttribute *)gradientColorInWaveChart:(ZFWaveChart *)waveChart{
    ZFGradientAttribute * gradientAttribute = [[ZFGradientAttribute alloc] init];
    gradientAttribute.colors = @[(id)font_main_color.CGColor, (id)ZFWhite.CGColor];
    gradientAttribute.locations = @[@(0.0), @(0.9)];
    
    return gradientAttribute;
}

- (void)waveChart:(ZFWaveChart *)waveChart popoverLabelAtIndex:(NSInteger)index popoverLabel:(ZFPopoverLabel *)popoverLabel{
    NSLog(@"第%ld个Label",(long)index);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFGold;
    //    [popoverLabel strokePath];
}
#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}


@end
