//
//  CustomChooseView.m
//  milier
//
//  Created by amin on 17/4/19.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "CustomChooseView.h"

@implementation CustomChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    if (self) {
        self = [super initWithFrame:frame];
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    
    return self;
}
- (void)initView{
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"门店信息:";
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    _ChooseLabel   = [[UILabel alloc]init];
    _ChooseLabel.backgroundColor = [UIColor whiteColor];
    _ChooseLabel.font = [UIFont systemFontOfSize:15];
    _ChooseLabel.textAlignment = NSTextAlignmentLeft    ;
    _ChooseLabel.text = @"对应信息";
    [self addSubview:_ChooseLabel];
    [_ChooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
}
@end
