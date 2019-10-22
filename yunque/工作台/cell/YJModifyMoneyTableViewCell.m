//
//  YJModifyMoneyTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJModifyMoneyTableViewCell.h"

@implementation YJModifyMoneyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI:(NSIndexPath *)indexPath{
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @" 室内门:";
    _NameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(60);
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
}

@end
