//
//  YJUpLoadShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/12.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUpLoadShopTableViewCell.h"

@implementation YJUpLoadShopTableViewCell

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
    _NameLabel.text = @"价格规则";
    _NameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _MoneyLabel = [[UILabel alloc]init];
    _MoneyLabel.text = @"利润率：123%";
    _MoneyLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_MoneyLabel];
    [_MoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _TypeLabel = [[UILabel alloc]init];
    _TypeLabel.text = @"分类：迪卡龙；上看到；拉萨看到；卢萨卡；大卡司；来看待；拉萨看到；拉萨看到；拉萨看到";
    _TypeLabel.font = [UIFont systemFontOfSize:14];
    _TypeLabel.numberOfLines = 0;
    [self addSubview:_TypeLabel];
    [_TypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(10);
        make.top.mas_equalTo(self->_MoneyLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(40);
    }];
}

- (void)setModel:(YJJiaGeModel *)model{
    if (model != _model) {
        _model = model;
        //NSLog(@"model = %@",model.ruleName);
       // NSLog(@"model == %@",model.category );
    }
}
@end
