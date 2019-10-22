//
//  YJShouCangTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/5.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShouCangTableViewCell.h"

@implementation YJShouCangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _ShopImageView = [[UIImageView alloc]init];
    _ShopImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_ShopImageView];
    [_ShopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    _ShopNameLabel = [[UILabel alloc]init];
    _ShopNameLabel.text = @"高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡";
    _ShopNameLabel.font = [UIFont systemFontOfSize:17];
    _ShopNameLabel.numberOfLines = 0;
    [self addSubview:_ShopNameLabel];
    [_ShopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.top.mas_equalTo(self->_ShopNameLabel.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH-180);
        make.height.mas_equalTo(60);
    }];
    
    _ShopMoneyLabel = [[UILabel alloc]init];
    _ShopMoneyLabel.text = @"￥80000";
    _ShopMoneyLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_ShopMoneyLabel];
    [_ShopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.bottom.mas_equalTo(self->_ShopImageView.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    _ShopNumberLabel = [[UILabel alloc]init];
    _ShopNumberLabel.text = @"本店热销29件";
    _ShopNumberLabel.textAlignment = NSTextAlignmentRight;
    _ShopNumberLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_ShopNumberLabel];
    [_ShopNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self->_ShopImageView.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _ShopTagFirstLabel = [[UILabel alloc]init];
    _ShopTagFirstLabel.text = @"新品";
    _ShopTagFirstLabel.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:235.0f/255.0f blue:240.0f/255.0f alpha:1].CGColor;//颜色
    _ShopTagFirstLabel.layer.borderWidth = 1.0f;//设置边框粗细
    _ShopTagFirstLabel.layer.cornerRadius = 5;
    _ShopTagFirstLabel.layer.masksToBounds = YES;
    _ShopTagFirstLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagFirstLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_ShopTagFirstLabel];
    [_ShopTagFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    _ShopTagSecondLabel = [[UILabel alloc]init];
    _ShopTagSecondLabel.text = @"新品";
    _ShopTagSecondLabel.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:235.0f/255.0f blue:240.0f/255.0f alpha:1].CGColor;//颜色
    _ShopTagSecondLabel.layer.borderWidth = 1.0f;//设置边框粗细
    _ShopTagSecondLabel.layer.cornerRadius = 5;
    _ShopTagSecondLabel.layer.masksToBounds = YES;
    _ShopTagSecondLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagSecondLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_ShopTagSecondLabel];
    [_ShopTagSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopTagFirstLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
    _ShopTagThirdLabel = [[UILabel alloc]init];
    _ShopTagThirdLabel.text = @"新品";
    _ShopTagThirdLabel.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:235.0f/255.0f blue:240.0f/255.0f alpha:1].CGColor;//颜色
    _ShopTagThirdLabel.layer.borderWidth = 1.0f;//设置边框粗细
    _ShopTagThirdLabel.layer.cornerRadius = 5;
    _ShopTagThirdLabel.layer.masksToBounds = YES;
    _ShopTagThirdLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagThirdLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_ShopTagThirdLabel];
    [_ShopTagThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopTagSecondLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}
@end
