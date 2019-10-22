//
//  YJKeHuTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/31.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJKeHuTableViewCell.h"

@implementation YJKeHuTableViewCell

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
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    _KeHuNametTypeLabel = [[UILabel alloc]init];
    _KeHuNametTypeLabel.text = @"男士";
    _KeHuNametTypeLabel.font = [UIFont systemFontOfSize:12];
    _KeHuNametTypeLabel.textColor = font_main_color;
    _KeHuNametTypeLabel.layer.masksToBounds = YES;
    _KeHuNametTypeLabel.textAlignment = NSTextAlignmentCenter;
    _KeHuNametTypeLabel.layer.cornerRadius = 5;
    _KeHuNametTypeLabel.backgroundColor = colorWithRGB(0.87, 0.92, 0.99);
    [self addSubview:_KeHuNametTypeLabel];
    [_KeHuNametTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_KeHuNameLabel.mas_right);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(28);
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
        make.width.mas_equalTo(90);
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
    _EditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //_EditBtn.backgroundColor = [UIColor redColor];
    [self addSubview:_EditBtn];
    [_EditBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
}
- (void)setModel:(YJKeHuModel *)model{
    if (model != _model) {
        _model = model;
        _KeHuNameLabel.text = model.nickName;
        if ([model.gender  integerValue]==2) {
           _KeHuNametTypeLabel.text = @"女士";
        }else{
             _KeHuNametTypeLabel.text = @"男士";
        }
       
        _KeHuNumberLabel.text = model.phoneNumber;
    }
}
@end
