//
//  YJMessageTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJMessageTableViewCell.h"

@implementation YJMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _YJNameLabel = [[UILabel alloc]init];
    _YJNameLabel.text = @"联系方式:";
    _YJNameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_YJNameLabel];
    [_YJNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    
    _YJTextField = [[UITextField alloc]init];
    _YJTextField.backgroundColor = [UIColor whiteColor];
    _YJTextField.font = [UIFont systemFontOfSize:15];
    _YJTextField.textAlignment = NSTextAlignmentLeft;
    _YJTextField.placeholder = @"请填写方便我们与您联系(电话/邮箱/QQ)";
    [self addSubview:_YJTextField];
    [_YJTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_YJNameLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
