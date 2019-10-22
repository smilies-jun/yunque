//
//  YJPayTopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPayTopTableViewCell.h"

@implementation YJPayTopTableViewCell

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
    _NameLabel.text = @"点击修改点击金额";
    _NameLabel.font = [UIFont systemFontOfSize:12];
    _NameLabel.textAlignment = NSTextAlignmentCenter;
    _NameLabel.textColor = colorWithRGB(0.56, 0.57, 0.60);
    _NameLabel.numberOfLines = 0;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    _AdressTextField = [[UITextField alloc]init];
    _AdressTextField.text = @"￥80000";
    _AdressTextField.font = [UIFont boldSystemFontOfSize:17];
    _AdressTextField.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_AdressTextField];
    [_AdressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
    
}
@end
