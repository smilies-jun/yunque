//
//  YJChoseBtnView.m
//  maike
//
//  Created by Apple on 2019/7/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJChoseBtnView.h"

@implementation YJChoseBtnView

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
    _ChooseFirstbutton = [UIButton buttonWithType:UIButtonTypeCustom];

    [_ChooseFirstbutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_ChooseFirstbutton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self addSubview:_ChooseFirstbutton];
    [_ChooseFirstbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_right).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _ChooseFirstLabel   = [[UILabel alloc]init];
    _ChooseFirstLabel.backgroundColor = [UIColor whiteColor];
    _ChooseFirstLabel.font = [UIFont systemFontOfSize:15];
    _ChooseFirstLabel.textAlignment = NSTextAlignmentLeft    ;
    _ChooseFirstLabel.text = @"信息";
    [self addSubview:_ChooseFirstLabel];
    [_ChooseFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ChooseFirstbutton.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    _ChooseSecondbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ChooseSecondbutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_ChooseSecondbutton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self addSubview:_ChooseSecondbutton];
    [_ChooseSecondbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ChooseFirstbutton.mas_right).offset(100);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _ChooseSecondLabel   = [[UILabel alloc]init];
    _ChooseSecondLabel.backgroundColor = [UIColor whiteColor];
    _ChooseSecondLabel.font = [UIFont systemFontOfSize:15];
    _ChooseSecondLabel.textAlignment = NSTextAlignmentLeft    ;
    _ChooseSecondLabel.text = @"信息";
    [self addSubview:_ChooseSecondLabel];
    [_ChooseSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ChooseSecondbutton.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(15);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    
}

@end
