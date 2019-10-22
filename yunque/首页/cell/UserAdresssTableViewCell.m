//
//  UserAdresssTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "UserAdresssTableViewCell.h"

@implementation UserAdresssTableViewCell

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
    _NameLabel.text = @"收货人：羊斯科拉深刻理解的克拉数据";
    _NameLabel.font = [UIFont boldSystemFontOfSize:16];
    _NameLabel.numberOfLines = 0;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(60);
    }];
    
    _AdressLabel = [[UILabel alloc]init];
    _AdressLabel.text = @"￥80000";
   _AdressLabel.textColor = colorWithRGB(0.83, 0.83, 0.83);
    _AdressLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_AdressLabel];
    [_AdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"下一步"];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(12);
    }];
}
@end
