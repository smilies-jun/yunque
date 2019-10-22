//
//  ModifyView.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "ModifyView.h"

@implementation ModifyView

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
    
    
    _NameTextField = [[UITextField alloc]init];
    _NameTextField.backgroundColor = [UIColor whiteColor];
    _NameTextField.font = [UIFont systemFontOfSize:15];
    _NameTextField.textAlignment = NSTextAlignmentLeft;
    _NameTextField.placeholder = @"请输入对应信息";
    [self addSubview:_NameTextField];
    [_NameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerClick)];
    [self addGestureRecognizer:tap];
    
    
}
- (void)headerClick{
    if ([self.delegate respondsToSelector:@selector(selAnSection:)]) {
        [self.delegate selAnSection:self.section];
    }
}
- (void)setUpShopModel:(YJUpShopModel *)UpShopModel{
    if (UpShopModel != _UpShopModel) {
        _UpShopModel = UpShopModel;
        if (UpShopModel.isAn) {
            
        }else{
            
        }
        
    }
}
@end
