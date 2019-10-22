//
//  YJChoseShopView.m
//  maike
//
//  Created by Apple on 2019/8/14.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJChoseShopView.h"

@implementation YJChoseShopView

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
    _iconImageView = [[UIImageView alloc]init];
    //_iconImageView.backgroundColor = [UIColor blueColor];
    _iconImageView.image = [UIImage imageNamed:@"单选"];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"我测";
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    _NextImageView = [[UIImageView alloc]init];
    [_NextImageView setImage:[UIImage imageNamed:@"展开"]];
    [self addSubview:_NextImageView];
    [_NextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
}
    
@end
