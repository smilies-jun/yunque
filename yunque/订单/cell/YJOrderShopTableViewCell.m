//
//  YJOrderShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJOrderShopTableViewCell.h"

@implementation YJOrderShopTableViewCell

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
    _ShopImageView.backgroundColor = colorWithRGB(0.96, 0.96, 0.96);
    [self addSubview:_ShopImageView];
    [_ShopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    _ShopNameLabel = [[UILabel alloc]init];
    _ShopNameLabel.text = @"高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡";
    _ShopNameLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_ShopNameLabel];
    [_ShopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.top.mas_equalTo(self->_ShopImageView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH-170);
        make.height.mas_equalTo(20);
    }];
    _ShopTypeLabel = [[UILabel alloc]init];
    _ShopTypeLabel.text = @"局木门撒大声地大萨达撒多";
    _ShopTypeLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _ShopTypeLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ShopTypeLabel];
    [_ShopTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopNameLabel.mas_left);
        make.top.mas_equalTo(self->_ShopNameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-170);
        make.height.mas_equalTo(20);
    }];
    
    
    _ShopMoneyLabel = [[UILabel alloc]init];
    _ShopMoneyLabel.text = @"￥80000";
    _ShopMoneyLabel.textColor = colorWithRGB(1, 0.29, 0.29);
    _ShopMoneyLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_ShopMoneyLabel];
    [_ShopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.bottom.mas_equalTo(self->_ShopImageView.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    
    _ShopNumberLabel = [[UILabel alloc]init];
    _ShopNumberLabel.text = @"*56";
    _ShopNumberLabel.textAlignment = NSTextAlignmentRight;
    _ShopNumberLabel.font = [UIFont systemFontOfSize:12];
    _ShopNameLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self addSubview:_ShopNumberLabel];
    [_ShopNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.bottom.mas_equalTo(self->_ShopImageView.mas_bottom);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(30);
    }];
    _ShopTagFirstLabel = [[UILabel alloc]init];
    _ShopTagFirstLabel.text = @"物流状态：";
    _ShopTagFirstLabel.textAlignment = NSTextAlignmentLeft;
    _ShopTagFirstLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_ShopTagFirstLabel];
    [_ShopTagFirstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopImageView.mas_right).offset(20);
        make.top.mas_equalTo(self->_ShopNumberLabel.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH-170);
        make.height.mas_equalTo(20);
    }];
//    _ShopTagSecondLabel = [[UILabel alloc]init];
//    _ShopTagSecondLabel.text = @"新品";
//    _ShopTagSecondLabel.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:235.0f/255.0f blue:240.0f/255.0f alpha:1].CGColor;//颜色
//    _ShopTagSecondLabel.layer.borderWidth = 1.0f;//设置边框粗细
//    _ShopTagSecondLabel.layer.cornerRadius = 5;
//    _ShopTagSecondLabel.layer.masksToBounds = YES;
//    _ShopTagSecondLabel.textAlignment = NSTextAlignmentCenter;
//    _ShopTagSecondLabel.font = [UIFont systemFontOfSize:17];
//    [self addSubview:_ShopTagSecondLabel];
//    [_ShopTagSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->_ShopTagFirstLabel.mas_right).offset(10);
//        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(30);
//    }];
//    _ShopTagThirdLabel = [[UILabel alloc]init];
//    _ShopTagThirdLabel.text = @"新品";
//    _ShopTagThirdLabel.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:235.0f/255.0f blue:240.0f/255.0f alpha:1].CGColor;//颜色
//    _ShopTagThirdLabel.layer.borderWidth = 1.0f;//设置边框粗细
//    _ShopTagThirdLabel.layer.cornerRadius = 5;
//    _ShopTagThirdLabel.layer.masksToBounds = YES;
//    _ShopTagThirdLabel.textAlignment = NSTextAlignmentCenter;
//    _ShopTagThirdLabel.font = [UIFont systemFontOfSize:17];
//    [self addSubview:_ShopTagThirdLabel];
//    [_ShopTagThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->_ShopTagSecondLabel.mas_right).offset(10);
//        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(30);
//    }];
}

- (void)setModel:(YJOrderModel *)model{
    if (model != _model) {
        _model = model;
        [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.orderImgUrl] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
        _ShopNameLabel.text = model.orderProductTitle;
       // _ShopTypeLabel.text = [NSString stringWithFormat:@"%ld",(long)[model.orderTotalAmount integerValue]];
        _ShopNumberLabel.text = [NSString stringWithFormat:@"%ld",(long)[model.number integerValue]];
        _ShopMoneyLabel.text = [NSString stringWithFormat:@"%@",model.productPriceUnit ];
        switch ([model.orderDetailStatus intValue]) {
            case 105:
                _ShopTagFirstLabel.text = @"物流状态：已发货";
                break;
            case 106:
                _ShopTagFirstLabel.text = @"物流状态：发货失败";
                break;
            case 107:
               _ShopTagFirstLabel.text = @"物流状态：已到货";
                break;
            default:
                 _ShopTagFirstLabel.text = @"物流状态：暂无";
                break;
        }
        
    }
}
@end
