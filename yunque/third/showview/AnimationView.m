//
//  AnimationView.m
//  OneExpress
//
//  Created by Taidy on 14/12/4.
//  Copyright (c) 2014年 YDS. All rights reserved.
//

#import "AnimationView.h"

@implementation AnimationView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scoreLabel = [[UILabel alloc] initWithFrame:self.frame];
        _scoreLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _scoreLabel.layer.cornerRadius = 5;
        _scoreLabel.layer.masksToBounds = YES;
        _scoreLabel.text = title;
        _scoreLabel.textColor = [UIColor clearColor];
        _scoreLabel.hidden = YES;
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.width - 20, self.height)];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [_scoreLabel addSubview:label];
        [[[UIApplication sharedApplication].delegate window] addSubview:_scoreLabel];
    }
    return self;
}

- (void)startAnimation
{
    NSTimeInterval time = MIN((CGFloat)_scoreLabel.text.length*0.1 + 0.5, 3.0);
    [UIView transitionWithView:_scoreLabel duration:time options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self->_scoreLabel.hidden = NO;
    } completion:^(BOOL finished) {
        self->_scoreLabel.hidden = YES;
        [self->_scoreLabel removeFromSuperview];
    }];
}

+ (void)showString:(NSString *)string
{
    AnimationView * animation = [[AnimationView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 180) / 2, (SCREEN_HEIGHT - 80) / 2, 180, 80) withTitle:string];
    [animation startAnimation];
}

+ (NSString *)getTImeBytimestampString:(NSString *)timstampStr
{
    return [AnimationView getTImeBytimestampString:timstampStr dateFormatter:@"YYYY-MM-dd HH:mm:ss"];
}

+ (NSString *)getTImeBytimestampString:(NSString *)timstampStr dateFormatter:(NSString *)f
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timstampStr longLongValue] / 1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:f];
    NSString * str = [NSString stringWithFormat:@"%@", [formatter stringFromDate:date]];
    return str;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
