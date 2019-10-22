//
//  YJSetDetailTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJSetDetailTableViewCell.h"

@implementation YJSetDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _iconImageView = [[UIImageView alloc]init];
    //_iconImageView.backgroundColor = [UIColor blueColor];
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
    [_NextImageView setImage:[UIImage imageNamed:@"下一步"]];
    [self addSubview:_NextImageView];
    [_NextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
    
    _adressLabel = [[UILabel alloc]init];
    _adressLabel.text = @"我测";
    _adressLabel.font = [UIFont systemFontOfSize:12];
    _adressLabel.hidden = YES;
    _adressLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_adressLabel];
    [_adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_NextImageView.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(24);
    }];
    _stateImageView = [[UIImageView alloc]init];
    [_stateImageView setImage:[UIImage imageNamed:@"已认证"]];
    _stateImageView.hidden = YES;
    [self addSubview:_stateImageView];
    [_stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_NextImageView.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(24);
    }];
}
@end
