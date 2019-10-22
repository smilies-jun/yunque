//
//  YJOrderHeaderTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJOrderHeaderTableViewCell.h"

@implementation YJOrderHeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    UIView *topview = [[UIView alloc]init];
    topview.backgroundColor = font_main_color;
    topview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
    [self addSubview:topview];
    UILabel *title = [[UILabel alloc]init];
    title.text = @"订单已创建";
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.font = [UIFont boldSystemFontOfSize:18];
    title.frame = CGRectMake(20, 10, 120, 20);
    [topview addSubview:title];
    
    
    
    UIView *btnView = [[UIView alloc]init];
    btnView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    btnView.frame =CGRectMake(20, 60, SCREEN_WIDTH-40, 80);
    btnView.layer.masksToBounds = YES;
    btnView.layer.cornerRadius = 5;
    [self addSubview:btnView];
    
    UILabel *moneylabel = [[UILabel alloc]init];
    moneylabel.text = @"订单金额";
    moneylabel.textAlignment = NSTextAlignmentCenter;

    moneylabel.font = [UIFont systemFontOfSize:12];
    moneylabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [btnView addSubview:moneylabel];
    [moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnView.mas_left).offset(20);
        make.top.mas_equalTo(btnView.mas_top).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    _orderMoneyLabel = [[UILabel alloc]init];
    _orderMoneyLabel.text = @"2400";
    _orderMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [btnView addSubview:_orderMoneyLabel];
    [_orderMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(moneylabel.mas_centerX);
        make.top.mas_equalTo(moneylabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UILabel *unPaylabel = [[UILabel alloc]init];
    unPaylabel.text = @"未支付";
    unPaylabel.textAlignment = NSTextAlignmentCenter;

    unPaylabel.font = [UIFont systemFontOfSize:12];
    unPaylabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [btnView addSubview:unPaylabel];
    [unPaylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(moneylabel.mas_right).offset(40);
        make.top.mas_equalTo(btnView.mas_top).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    _NoPayLabel = [[UILabel alloc]init];
    _NoPayLabel.text = @"2400";
    _NoPayLabel.textAlignment = NSTextAlignmentCenter;
    [btnView addSubview:_NoPayLabel];
    [_NoPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(unPaylabel.mas_centerX);
        make.top.mas_equalTo(unPaylabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UILabel *Paylabel = [[UILabel alloc]init];
    Paylabel.text = @"已支付";
    Paylabel.textAlignment = NSTextAlignmentCenter;

    Paylabel.font = [UIFont systemFontOfSize:12];
    Paylabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [btnView addSubview:Paylabel];
    [Paylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(unPaylabel.mas_right).offset(40);
        make.top.mas_equalTo(btnView.mas_top).offset(20);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    _PayLabel = [[UILabel alloc]init];
    _PayLabel.text = @"2400";
    _PayLabel.textAlignment = NSTextAlignmentCenter;
    [btnView addSubview:_PayLabel];
    [_PayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(Paylabel.mas_centerX);
        make.top.mas_equalTo(Paylabel.mas_bottom);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.image = [UIImage imageNamed:@"地址"];
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(btnView.mas_bottom).offset(40);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(22);
    }];
 
    _NameLabel =[[UILabel alloc]init];
    _NameLabel.text = @"收货人：科技萨卡时间 2872873 878127389";
    _NameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(60);
        make.top.mas_equalTo(btnView.mas_bottom).offset(30);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(20);
    }];
    _AdressLabel =[[UILabel alloc]init];
    _AdressLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _AdressLabel.font = [UIFont systemFontOfSize:14];
    _AdressLabel.text = @"收货人：科技萨卡时间 2872873 878127389";
    [self addSubview:_AdressLabel];
    [_AdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(60);
        make.top.mas_equalTo(self->_NameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(15);
    }];
    
}
@end
