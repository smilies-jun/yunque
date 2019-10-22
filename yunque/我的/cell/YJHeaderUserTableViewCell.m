
//
//  YJHeaderUserTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/3.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJHeaderUserTableViewCell.h"

@implementation YJHeaderUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _userImageView  = [[UIImageView alloc]init];
    _userImageView.backgroundColor = [UIColor blueColor];
    _userImageView.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = 30;
    [self addSubview:_userImageView];
    [_userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.text = @"基拉";
    [self addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_userImageView.mas_right).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(30);
    }];
    _AdressLabel = [[UILabel alloc]init];
    _AdressLabel.text = @"基拉";
    [self addSubview:_AdressLabel];
    [_AdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_userImageView.mas_right).offset(10);
        make.top.mas_equalTo(self->_userNameLabel.mas_bottom).offset(1);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _iconImageView = [[UIImageView alloc]init];
    [_iconImageView setImage:[UIImage imageNamed:@"下一步"]];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];

}
@end
