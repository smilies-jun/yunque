//
//  YJOrderTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/21.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJOrderTableViewCell.h"

@implementation YJOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)configUI:(NSIndexPath *)indexPath{
    UIImageView *lineImageView = [[UIImageView alloc]init];
    lineImageView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self.contentView addSubview:lineImageView];
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top);
        make.left.mas_equalTo(self.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    _OrderNumberLabel  = [[UILabel alloc]init];
    _OrderNumberLabel.text= @"订单号:123728738217839";
    _OrderNumberLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNumberLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_OrderNumberLabel];
    [_OrderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineImageView.mas_bottom);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH-100);
        make.height.mas_equalTo(30);
    }];
    _OrderNumberLabelSate = [[UILabel alloc]init];
    _OrderNumberLabelSate.text= @"已创建";
    _OrderNumberLabelSate.textColor = font_main_color;
    _OrderNumberLabelSate.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_OrderNumberLabelSate];
    [_OrderNumberLabelSate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNumberLabel.mas_top);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
   
    
    _OrderNameLabel = [[UILabel alloc]init];
    _OrderNameLabel.text= @"客户信息:";
    _OrderNameLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNameLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_OrderNameLabel];
    [_OrderNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNumberLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    _OrderNamePhoneLabel = [[UILabel alloc]init];
    _OrderNamePhoneLabel.text= @"余军-达达手机打开撒娇的";
    _OrderNamePhoneLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNamePhoneLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_OrderNamePhoneLabel];
    [_OrderNamePhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNameLabel.mas_top);
        make.left.mas_equalTo(self->_OrderNameLabel.mas_right).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-140);
        make.height.mas_equalTo(20);
    }];
    _OrderNameAdresssLabel = [[UILabel alloc]init];
    _OrderNameAdresssLabel.text= @"就撒客户登记卡萨很快就的哈手机客户端科技撒谎的:";
    _OrderNameAdresssLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNameAdresssLabel.font = [UIFont systemFontOfSize:14];
    _OrderNameAdresssLabel.numberOfLines = 0;
    [self.contentView addSubview:_OrderNameAdresssLabel];
    [_OrderNameAdresssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNamePhoneLabel.mas_bottom);
        make.left.mas_equalTo(self->_OrderNameLabel.mas_right).offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH-140);
        make.height.mas_equalTo(40);
    }];
    
    _OrderMoneyLabel = [[UILabel alloc]init];
    _OrderMoneyLabel.text= @"订单金额:";
    _OrderMoneyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderMoneyLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_OrderMoneyLabel];
    [_OrderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNameAdresssLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];
    
    _OrderAllMoneyLabel = [[UILabel alloc]init];
    _OrderAllMoneyLabel.text= @"￥899999";
    _OrderAllMoneyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderAllMoneyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_OrderAllMoneyLabel];
    [_OrderAllMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderMoneyLabel.mas_top);
        make.left.mas_equalTo(self->_OrderMoneyLabel.mas_right);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _OrderNoPayStyleMoneyLabel = [[UILabel alloc]init];
    _OrderNoPayStyleMoneyLabel.text= @"已支付";
    _OrderNoPayStyleMoneyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNoPayStyleMoneyLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_OrderNoPayStyleMoneyLabel];
    [_OrderNoPayStyleMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderAllMoneyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self->_OrderAllMoneyLabel.mas_left);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _OrderPayMoneyLabel = [[UILabel alloc]init];
    _OrderPayMoneyLabel.text= @"￥899999";
    _OrderPayMoneyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderPayMoneyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_OrderPayMoneyLabel];
    [_OrderPayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNoPayStyleMoneyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self->_OrderNoPayStyleMoneyLabel.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    _OrderPayMoneyStyleLabel = [[UILabel alloc]init];
    _OrderPayMoneyStyleLabel.text= @"未支付";
    _OrderPayMoneyStyleLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderPayMoneyStyleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_OrderPayMoneyStyleLabel];
    [_OrderPayMoneyStyleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderAllMoneyLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self->_OrderNoPayStyleMoneyLabel.mas_right).offset(80);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    _OrderNoPayMoneyLabel = [[UILabel alloc]init];
    _OrderNoPayMoneyLabel.text= @"￥899999";
    _OrderNoPayMoneyLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderNoPayMoneyLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_OrderNoPayMoneyLabel];
    [_OrderNoPayMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderPayMoneyStyleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self->_OrderPayMoneyStyleLabel.mas_left);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    _OrderUserLabel = [[UILabel alloc]init];
    _OrderUserLabel.text= @"导购员:     少时诵诗书所";
    _OrderUserLabel.textColor = colorWithRGB(0.27, 0.27, 0.27);
    _OrderUserLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_OrderUserLabel];
    [_OrderUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_OrderNoPayMoneyLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(20);
    }];
    
    _SureOverBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_SureOverBtn setTitle:@"确认完成" forState:UIControlStateNormal];
    [_SureOverBtn setTintColor:font_main_color];
    [_SureOverBtn.layer setMasksToBounds:YES];
    [_SureOverBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [_SureOverBtn.layer setBorderWidth:1.0];
    _SureOverBtn.layer.borderColor = font_main_color.CGColor;

    [self addSubview:_SureOverBtn];
    [_SureOverBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
    }];
    _PayMoneyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_PayMoneyBtn setTintColor:font_main_color];

    [_PayMoneyBtn setTitle:@"待支付" forState:UIControlStateNormal];
    [_PayMoneyBtn.layer setCornerRadius:15.0]; //设置矩形四个圆角半径
    [_PayMoneyBtn.layer setBorderWidth:1.0];
    _PayMoneyBtn.layer.borderColor = font_main_color.CGColor;
    [self addSubview:_PayMoneyBtn];
    [_PayMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_SureOverBtn.mas_left).offset(-20);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-10);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(30);
    }];
   
}


- (void)setOrderModel:(YJOrderModel *)orderModel{
    if (orderModel != _orderModel) {
        _orderModel = orderModel;
        _OrderNumberLabel.text= [NSString stringWithFormat:@"订单编号:%@",orderModel.orderSn];
        
        switch ([_orderModel.orderStatus integerValue]) {
            case 101:
                 _OrderNumberLabelSate.text= @"已创建";
                _SureOverBtn.hidden = NO;
                _PayMoneyBtn.hidden= NO;
                [_SureOverBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [_PayMoneyBtn setTitle:@"待支付" forState:UIControlStateNormal];

                break;
            case 102:
                _OrderNumberLabelSate.text= @"已生效";
                _SureOverBtn.hidden = YES;
                _PayMoneyBtn.hidden= YES;
                [_SureOverBtn setTitle:@"确认完成" forState:UIControlStateNormal];
                [_PayMoneyBtn setTitle:@"待支付" forState:UIControlStateNormal];
                break;
            case 103:
                _OrderNumberLabelSate.text= @"已完成";
                
                _SureOverBtn.hidden = YES;
                _PayMoneyBtn.hidden= YES;
                break;
            default:
                _SureOverBtn.hidden = YES;
                _PayMoneyBtn.hidden= YES;
                 _OrderNumberLabelSate.text= @"已取消";
                break;
        }
       
        _OrderNamePhoneLabel.text= [NSString    stringWithFormat:@"%@  %ld",orderModel.buyer,(long)[orderModel.cod integerValue]];
        _OrderNameAdresssLabel.text= [NSString   stringWithFormat:@"%@%@%@%@",orderModel.province,orderModel.city,orderModel.area,orderModel.street];
        _OrderAllMoneyLabel.text=[NSString stringWithFormat:@"%ld",(long)[ orderModel.orderTotalAmount integerValue]];
        _OrderPayMoneyLabel.text= [NSString stringWithFormat:@"%ld",(long)[ orderModel.paidAmount integerValue]];
        _OrderNoPayMoneyLabel.text= [NSString stringWithFormat:@"%ld",[orderModel.orderTotalAmount integerValue] -[orderModel.paidAmount integerValue] ];
        _OrderUserLabel.text= [NSString stringWithFormat:@"导购员：%@",orderModel.sellerName];


    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
