//
//  YJAutherTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/23.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJAutherTableViewCell.h"

@implementation YJAutherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _AutherTitleLabel  = [[UILabel alloc]init];
    _AutherTitleLabel.text= @"开户信息";
    _AutherTitleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _AutherTitleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_AutherTitleLabel];
    [_AutherTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    _choseTextField = [[UITextField alloc]init];
    _choseTextField.enabled = NO;
    [self addSubview:_choseTextField];
    [_choseTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.left.mas_equalTo(self->_AutherTitleLabel.mas_right);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(40);
    }];
    
    
    _AutherButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_AutherButton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
     [_AutherButton setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.contentView addSubview:_AutherButton];
    [_AutherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
         make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
