//
//  YJYuanGongTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJYuanGongTableViewCell.h"

@implementation YJYuanGongTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _KeHuNameLabel = [[UILabel alloc]init];
    _KeHuNameLabel.text = @"某某某";
    _KeHuNameLabel.font = [UIFont systemFontOfSize:16];
    _KeHuNameLabel.numberOfLines = 0;
    [self addSubview:_KeHuNameLabel];
    [_KeHuNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _KeHuNumberLabel = [[UILabel alloc]init];
    _KeHuNumberLabel.text = @"15110499302";
    _KeHuNumberLabel.font = [UIFont systemFontOfSize:12];
    _KeHuNumberLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self addSubview:_KeHuNumberLabel];
    [_KeHuNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self->_KeHuNameLabel.mas_bottom);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    _UserNameLabel = [[UILabel alloc]init];
    _UserNameLabel.text = @"某某某";
    _UserNameLabel.font = [UIFont systemFontOfSize:16];
    _UserNameLabel.numberOfLines = 0;
    [self addSubview:_UserNameLabel];
    [_UserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    _UserNumberLabel = [[UILabel alloc]init];
    _UserNumberLabel.text = @"15110499302";
    _UserNumberLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _UserNumberLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_UserNumberLabel];
    [_UserNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self->_UserNameLabel.mas_bottom);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    _EditBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //_EditBtn.backgroundColor = [UIColor redColor];
    [_EditBtn setTitle:@"禁用" forState:UIControlStateNormal];
    [_EditBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [_EditBtn.layer setBorderWidth:1.0];
    _EditBtn.layer.borderColor = font_main_color.CGColor;
    [self addSubview:_EditBtn];
    [_EditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}
- (void)setModel:(YJKeHuModel *)model{
    if (model != _model) {
        _model = model;
        _KeHuNameLabel.text = model.actualName;
        _KeHuNumberLabel.text = model.phone;
        if ([[[model.roleList objectAtIndex:0]objectForKey:@"roleId"] integerValue] == 5) {
            _UserNameLabel.text = @"导购";
        }else{
            _UserNameLabel.text = @"店员";

        }
        
         _UserNumberLabel.text = model.lastloginDateStr;
        if ([model.forbidden integerValue]) {
              [_EditBtn setTitle:@"启用" forState:UIControlStateNormal];
        }else{
              [_EditBtn setTitle:@"禁用" forState:UIControlStateNormal];
        }
    }
}
@end
