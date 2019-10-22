//
//  YJPayCodeViewController.m
//  maike
//
//  Created by Apple on 2019/9/10.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPayCodeViewController.h"
#import <CoreImage/CoreImage.h>
#import "YJPayViewController.h"
#import "YJPayResultViewController.h"

@interface YJPayCodeViewController (){
    
    UIImageView  *userImageView;
    UILabel *userNameLabel;
    UILabel *userAdressLabel;
    UILabel *shareLabel;
    UILabel *nameLabel;
    UIImageView *shareImageView;
    UIImage *codeImage;
    NSString *codeStr;
}


@end

@implementation YJPayCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.TopView.hidden = NO;
    
    self.TopTitleLabel.text = @"二维码收款";
    self.view.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.BackButton addTarget:self action:@selector(ShopListBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self reoadDate];
    
}
- (void)reoadDate{
    NSString *url;
    if ([_typeStr integerValue] == 1) {
         url = [NSString stringWithFormat:@"%@/alipay/pre?transaction=0.01&orderId=1",BASE_URL];
    }else{
        url = [NSString stringWithFormat:@"%@/pay/pre?transaction=0.01&orderId=1",BASE_URL];
    }
   
    //NSLog(@"url = %@",url);
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        NSString *url = [[result objectForKey:@"data"]objectForKey:@"qrCode"];
        self->codeStr = [[result objectForKey:@"data"]objectForKey:@"suborderSn"];
        self->codeImage =   [self createQRCodeWithUrl:url];
        [self initUI];
    }];
    
}
- (void)initUI{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(SCREEN_HEIGHT-60);
    }];
//    userImageView = [[UIImageView alloc]init];
//    userImageView.layer.masksToBounds = YES;
//    userImageView.layer.cornerRadius = 20;
//    userImageView.backgroundColor = font_main_color;
//    [backView addSubview:userImageView];
//    [userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(backView.mas_left).offset(20);
//        make.top.mas_equalTo(backView.mas_top).offset(20);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//    }];
//    userNameLabel = [[UILabel alloc]init];
//    userNameLabel.text = @"slakjd";
//    userNameLabel.font = [UIFont systemFontOfSize:16];
//    [backView addSubview:userNameLabel];
//    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->userImageView.mas_right).offset(5);
//        make.top.mas_equalTo(self->userImageView.mas_top);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
//    userAdressLabel = [[UILabel alloc]init];
//    userAdressLabel.text = @"slakjd";
//    userAdressLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
//    userAdressLabel.font = [UIFont systemFontOfSize:12];
//    [backView addSubview:userAdressLabel];
//    [userAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->userImageView.mas_right).offset(5);
//        make.top.mas_equalTo(self->userNameLabel.mas_bottom);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
    
    
    shareImageView = [[UIImageView alloc]init];
    shareImageView.image = codeImage;
    [backView addSubview:shareImageView];
    [shareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(20);
        make.top.mas_equalTo(self.TopView.mas_bottom).offset(80);
        make.width.mas_equalTo(SCREEN_WIDTH - 80-20);
        make.height.mas_equalTo(SCREEN_WIDTH - 80-20);
    }];
    nameLabel  = [[UILabel alloc]init];
    nameLabel.text = @"扫码支付";
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = colorWithRGB(0.83, 0.83, 0.83);
    [backView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(20);
        make.bottom.mas_equalTo(self.TopView.mas_bottom).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH-80);
        make.height.mas_equalTo(20);
    }];
    shareLabel  = [[UILabel alloc]init];
    shareLabel.text = _moneyStr;
    shareLabel.textAlignment = NSTextAlignmentCenter;
    shareLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [backView addSubview:shareLabel];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backView.mas_left).offset(20);
        make.top.mas_equalTo(self->nameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-80);
        make.height.mas_equalTo(20);
    }];
    UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [codeBtn setTitle:@"确定收款" forState:UIControlStateNormal];
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.cornerRadius = 5.0f;
    codeBtn.backgroundColor =font_main_color;
    [codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [codeBtn addTarget:self action:@selector(codePostClick) forControlEvents:UIControlEventTouchUpInside];
    [backView  addSubview:codeBtn];
    [codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->shareImageView.mas_bottom).offset(80);
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 80);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    
}
- (void)codePostClick{
    NSString *url;
    url = [NSString stringWithFormat:@"%@/alipay/verification?suborderSn=%@",BASE_URL,codeStr];
    [[DateSource sharedInstance]requestHtml5WithParameters:nil withUrl:url withTokenStr:nil usingBlock:^(NSDictionary *result, NSError *error) {
        if ([[result objectForKey:@"code"]integerValue] == 200) {
          //  [AnimationView showString:@"支付成功"];
          //  [self.navigationController popToRootViewControllerAnimated:NO];
            YJPayResultViewController   *vc = [[YJPayResultViewController alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        }else{
            [AnimationView showString:[result objectForKey:@"errmsg"]];
        }

    }];
}
- (UIImage *)createQRCodeWithUrl:(NSString *)url {
    // 1. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 滤镜恢复默认设置
    [filter setDefaults];
    
    // 2. 给滤镜添加数据
    NSString *string = url;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 使用KVC的方式给filter赋值
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 3. 生成二维码
    CIImage *image = [filter outputImage];
    // 转成高清格式
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:image withSize:200];
    // 添加logo
    qrcode = [self drawImage:[UIImage imageNamed:@"logo"] inImage:qrcode];
    return qrcode;
}
// 将二维码转成高清的格式
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}
// 添加logo
- (UIImage *)drawImage:(UIImage *)newImage inImage:(UIImage *)sourceImage {
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    // 注意logo的尺寸不要太大,否则可能无法识别
    CGRect rect = CGRectMake(imageSize.width / 2 - 25, imageSize.height / 2 - 25, 50, 50);
    //    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [newImage drawInRect:rect];
    
    //返回绘制的新图形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)ShopListBackClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YJPayViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
   // [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
