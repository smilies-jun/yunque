//
//  YJShowShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/17.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJShowShopTableViewCell.h"

@implementation YJShowShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)configUI:(NSIndexPath *)indexPath{
    
    _ShopImageView = [[UIImageView alloc]init];
    _ShopImageView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    [self addSubview:_ShopImageView];
    [_ShopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    _ShopNameLabel = [[UILabel alloc]init];
    _ShopNameLabel.text = @"高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡木门高端定制橡";
    _ShopNameLabel.font = [UIFont systemFontOfSize:14];
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
    _ShopMoneyLabel.textColor = colorWithRGB(1, 0.29, 0.29);
    _ShopMoneyLabel.font = [UIFont systemFontOfSize:14];
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
    _ShopNumberLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _ShopNumberLabel.font = [UIFont systemFontOfSize:12];
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
    _ShopTagFirstLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _ShopTagFirstLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagFirstLabel.font = [UIFont systemFontOfSize:11 ];
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
    _ShopTagSecondLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);

    _ShopTagSecondLabel.layer.borderWidth = 1.0f;//设置边框粗细
    _ShopTagSecondLabel.layer.cornerRadius = 5;
    _ShopTagSecondLabel.layer.masksToBounds = YES;
    _ShopTagSecondLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagSecondLabel.font = [UIFont systemFontOfSize:11];
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
    _ShopTagThirdLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    _ShopTagThirdLabel.layer.borderWidth = 1.0f;//设置边框粗细
    _ShopTagThirdLabel.layer.cornerRadius = 5;
    _ShopTagThirdLabel.layer.masksToBounds = YES;
    _ShopTagThirdLabel.textAlignment = NSTextAlignmentCenter;
    _ShopTagThirdLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_ShopTagThirdLabel];
    [_ShopTagThirdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_ShopTagSecondLabel.mas_right).offset(10);
        make.bottom.mas_equalTo(self->_ShopMoneyLabel.mas_top).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(30);
    }];
}
- (void)setModel:(YJHotShopModel *)model{
    if (model != _model) {
        _model = model;
        _ShopNameLabel.text = [NSString stringWithFormat:@"%@",model.title];
       _ShopNumberLabel.text = [NSString stringWithFormat:@"本店热销%@件",model.salesVolume];
        _ShopMoneyLabel.text = [NSString stringWithFormat:@"￥%@",model.marketRefrencePrice];
        [_ShopImageView sd_setImageWithURL:[NSURL URLWithString:model.productImg] placeholderImage:[UIImage imageNamed:@"imageDefault"]];
        //NSLog(@"model === %@",model.keyWord);
        if (model.keyWord.length) {
            NSArray  *array = [model.keyWord componentsSeparatedByString:@"；"];//其中"-"号为分隔符
            switch (array.count) {
                case 1:
                    _ShopTagFirstLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];;
                    _ShopTagFirstLabel.hidden = NO;
                    _ShopTagSecondLabel.hidden = YES;
                    _ShopTagThirdLabel.hidden= YES;
                    break;
                case 2:
                    _ShopTagFirstLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];;
                    _ShopTagSecondLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
                    _ShopTagFirstLabel.hidden = NO;
                    _ShopTagSecondLabel.hidden = NO;
                    _ShopTagThirdLabel.hidden= YES;
                    break;
                case 3:
                     _ShopTagFirstLabel.hidden = NO;
                    _ShopTagSecondLabel.hidden = NO;
                    _ShopTagThirdLabel.hidden= NO;
                   
                    _ShopTagFirstLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];;
                      _ShopTagSecondLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:1]];
                    _ShopTagThirdLabel.text = [NSString stringWithFormat:@"%@",[array objectAtIndex:2]];
                    break;
                    
                default:
                    break;
            }
        }else{
            _ShopTagFirstLabel.text = @"无";
            _ShopTagSecondLabel.hidden = YES;
            _ShopTagThirdLabel.hidden= YES;
            _ShopTagFirstLabel.hidden = NO;
        }
        [_ShopTagFirstLabel sizeToFit];
         [_ShopTagSecondLabel sizeToFit];
         [_ShopTagThirdLabel sizeToFit];
    }
}

//处理选中背景色问题
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (!self.editing) {
        return;
    }
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        //        self.textLabel.backgroundColor = [UIColor clearColor];
        //        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        //self.label.backgroundColor = [UIColor clearColor];
        
        _ShopNameLabel.backgroundColor = [UIColor clearColor];
        _ShopMoneyLabel.backgroundColor = [UIColor clearColor];
        _ShopNumberLabel.backgroundColor = [UIColor clearColor];
        _ShopTagFirstLabel.backgroundColor = [UIColor clearColor];
        _ShopTagSecondLabel.backgroundColor = [UIColor clearColor];
        _ShopTagThirdLabel.backgroundColor = [UIColor clearColor];
    }
 
    
}
//- (void)layoutSubviews
//{
//    [self customMultipleChioce];
//    [super layoutSubviews];
//}
//
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    [super setEditing:editing animated:animated];
//    if (editing) {
//        [self customMultipleChioce];
//    }
//}



//-(void)customMultipleChioce{
//    for (UIControl *control in self.subviews){
//        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
//            for (UIView *view in control.subviews)
//            {
//                if ([view isKindOfClass: [UIImageView class]]) {
//                    UIImageView *img=(UIImageView *)view;
//                    //系统默认的横坐标为12，这里我们设定为20，everybody happy!
//                    img.frame = CGRectMake(20, img.frame.origin.y, img.frame.size.width, img.frame.size.height);
//                    //我们在这里替换多选按钮的图片
//                    if (self.selected) {
//                        img.image=[UIImage imageNamed:@"check"];
//                    }else
//                    {
//                        img.image=[UIImage imageNamed:@"uncheck"];
//                    }
//                }
//            }
//        }
//    }
//}
@end
