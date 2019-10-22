//
//  YJOrderPayDetailTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJOrderPayDetailTableViewCell.h"

@implementation YJOrderPayDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    
    _orderNumberLabel = [[UILabel alloc]init];
    _orderNumberLabel.text = @"支付编号";
    _orderNumberLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _orderNumberLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_orderNumberLabel];
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _orderNumberDetailLabel = [[UILabel alloc]init];
    _orderNumberDetailLabel.text = @"2019898989988899";
    _orderNumberDetailLabel.font = [UIFont systemFontOfSize:14];
    _orderNumberDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_orderNumberDetailLabel];
    [_orderNumberDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(20);
    }];
    
    _OrderCreateLabel = [[UILabel alloc]init];
    _OrderCreateLabel.text = @"支付时间";
    _OrderCreateLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_OrderCreateLabel];
    [_OrderCreateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self->_orderNumberLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderCreateDetailLabel = [[UILabel alloc]init];
    _OrderCreateDetailLabel.text = @"2019-01-28";
    _OrderCreateDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderCreateDetailLabel];
    [_OrderCreateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderCreateLabel.mas_top);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    _OrderTimeLabel = [[UILabel alloc]init];
    _OrderTimeLabel.text = @"支付方式";
    _OrderTimeLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_OrderTimeLabel];
    [_OrderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self->_OrderCreateLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderTimeDetailLabel = [[UILabel alloc]init];
    _OrderTimeDetailLabel.text = @"微信";
    _OrderTimeDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderTimeDetailLabel];
    [_OrderTimeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderTimeLabel.mas_top);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
    }];
    
    _OrderMoneyLabel = [[UILabel alloc]init];
    _OrderMoneyLabel.text = @"支付金额";
    _OrderMoneyLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_OrderMoneyLabel];
    [_OrderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self->_OrderTimeLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderMoneyDetailLabel = [[UILabel alloc]init];
    _OrderMoneyDetailLabel.text = @"微信";
    _OrderMoneyDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderMoneyDetailLabel];
    [_OrderMoneyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderMoneyLabel.mas_top);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(30);
    }];
}
- (void)setModel:(YJOrderModel *)model{
    if (model != _model) {
        _model = model;
        _orderNumberDetailLabel.text = model.orderSn;
        _OrderCreateDetailLabel.text =model.createDate;
        _OrderMoneyDetailLabel.text = [NSString stringWithFormat:@"%@", model.transaction];
        
        switch ([model.payType integerValue]) {
            case 1:
                  _OrderTimeDetailLabel.text = @"微信";
                break;
            case 2:
                _OrderTimeDetailLabel.text = @"支付宝";
                break;
            case 3:
                _OrderTimeDetailLabel.text = @"现金";
                break;
            case 4:
                _OrderTimeDetailLabel.text = @"刷卡";
                break;
            case 5:
                _OrderTimeDetailLabel.text = @"其他";
                break;
            default:
                 _OrderTimeDetailLabel.text = @"其他";
                break;
        }
      

        
    }
}
@end
