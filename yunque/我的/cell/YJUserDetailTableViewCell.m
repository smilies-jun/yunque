//
//  YJUserDetailTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/29.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserDetailTableViewCell.h"

@implementation YJUserDetailTableViewCell

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
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    _NameLabel = [[UILabel alloc]init];
    _NameLabel.text = @"我测";
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    _choseLabel = [[UILabel alloc]init];
    _choseLabel.text = @"我测";
    _choseLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_choseLabel];
    [_choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    _NextImageView = [[UIImageView alloc]init];
    [_NextImageView setImage:[UIImage imageNamed:@"下一步"]];
    _NextImageView.hidden= YES;
    [self addSubview:_NextImageView];
    [_NextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
}
@end
