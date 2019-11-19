//
//  YJOrderDetailTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJOrderDetailTableViewCell.h"

@implementation YJOrderDetailTableViewCell

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
    _NameLabel.text = @"订单信息";
    _NameLabel.font = [UIFont systemFontOfSize:16];
    _NameLabel.numberOfLines = 0;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
    _orderNumberLabel = [[UILabel alloc]init];
    _orderNumberLabel.text = @"订单编号";
    _orderNumberLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _orderNumberLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_orderNumberLabel];
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _orderNumberDetailLabel = [[UILabel alloc]init];
    _orderNumberDetailLabel.text = @"2019898989988899";
    _orderNumberDetailLabel.font = [UIFont systemFontOfSize:13];
    _orderNumberDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_orderNumberDetailLabel];
    [_orderNumberDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(30);
    }];
    
    _OrderCreateLabel = [[UILabel alloc]init];
    _OrderCreateLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);

    _OrderCreateLabel.text = @"创建时间";
    _OrderCreateLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderCreateLabel];
    [_OrderCreateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_orderNumberLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderCreateDetailLabel = [[UILabel alloc]init];
    _OrderCreateDetailLabel.text = @"2019898989988899";
     _OrderCreateDetailLabel.font = [UIFont systemFontOfSize:14];
    _OrderCreateDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderCreateDetailLabel];
    [_OrderCreateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderCreateLabel.mas_top);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    _OrderTimeLabel = [[UILabel alloc]init];
      _OrderTimeLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _OrderTimeLabel.text = @"生效时间";
    _OrderTimeLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderTimeLabel];
    [_OrderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_OrderCreateLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderTimeDetailLabel = [[UILabel alloc]init];
    _OrderTimeDetailLabel.text = @"2019898989988899";
    _OrderTimeDetailLabel.font = [UIFont systemFontOfSize:14];
    _OrderTimeDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderTimeDetailLabel];
    [_OrderTimeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderTimeLabel.mas_top);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    _OrderFirstPayLabel = [[UILabel alloc]init];
      _OrderFirstPayLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _OrderFirstPayLabel.text = @"首次支付";
    _OrderFirstPayLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderFirstPayLabel];
    [_OrderFirstPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_OrderTimeLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderFirstPayDetailLabel = [[UILabel alloc]init];
    
    _OrderFirstPayDetailLabel.text = @"2019898989988899";
    _OrderFirstPayDetailLabel.font = [UIFont systemFontOfSize:14];
    _OrderFirstPayDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderFirstPayDetailLabel];
    [_OrderFirstPayDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderFirstPayLabel.mas_top);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _OrderPayComplyLabel = [[UILabel alloc]init];
    _OrderPayComplyLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);

    _OrderPayComplyLabel.hidden = YES;
    _OrderPayComplyLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderPayComplyLabel];
    [_OrderPayComplyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_OrderFirstPayLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderPayComplyDetailLabel = [[UILabel alloc]init];
    _OrderPayComplyDetailLabel.hidden = YES;
    _OrderPayComplyDetailLabel.font = [UIFont systemFontOfSize:14];
    _OrderPayComplyDetailLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_OrderPayComplyDetailLabel];
    [_OrderPayComplyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderPayComplyLabel.mas_top);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _OrderReceiveLabel = [[UILabel alloc]init];
     _OrderReceiveLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _OrderReceiveLabel.hidden= YES;
    _OrderReceiveLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderReceiveLabel];
    [_OrderReceiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_NameLabel.mas_left);
        make.top.mas_equalTo(self->_OrderPayComplyLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    _OrderReceiveDetailLabel = [[UILabel alloc]init];
    _OrderReceiveDetailLabel.hidden= YES;
    _OrderReceiveDetailLabel.textAlignment = NSTextAlignmentRight;
    _OrderReceiveDetailLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_OrderReceiveDetailLabel];
    [_OrderReceiveDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_OrderReceiveLabel.mas_top);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
}
@end
