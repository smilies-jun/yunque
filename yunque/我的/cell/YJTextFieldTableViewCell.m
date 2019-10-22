//
//  YJTextFieldTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/6.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJTextFieldTableViewCell.h"

@implementation YJTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    _YJTextField = [[UITextField alloc]init];
    _YJTextField.placeholder = @"请输入你宝贵的意见";
    [self addSubview:_YJTextField];
    [_YJTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(160);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
