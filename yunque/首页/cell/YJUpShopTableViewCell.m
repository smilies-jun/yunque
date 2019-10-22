//
//  YJUpShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/30.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUpShopTableViewCell.h"

@implementation YJUpShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{

    _ShopNameLabel = [[UILabel alloc]init];
    _ShopNameLabel.text = @"高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡";
    _ShopNameLabel.font = [UIFont systemFontOfSize:17];
    _ShopNameLabel.numberOfLines = 0;
    [self addSubview:_ShopNameLabel];
    [_ShopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    _ShopMoneyLabel = [[UILabel alloc]init];
    _ShopMoneyLabel.text = @"￥80000";
    _ShopMoneyLabel.font = [UIFont systemFontOfSize:17];
    [self addSubview:_ShopMoneyLabel];
    [_ShopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopNameLabel.mas_right).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];

}

- (void)setUpShopModel:(YJUpShopModel *)UpShopModel{
    if (UpShopModel != _UpShopModel) {
        _UpShopModel = UpShopModel;
        if (UpShopModel.showAllL) {           
        }else{
        }
        
    }
}

@end
