//
//  YJUserShopTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/25.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJUserShopTableViewCell.h"

@implementation YJUserShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configUI:(NSIndexPath *)indexPath{
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
    topView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 12);
    [self addSubview:topView];
    _UserImageView = [[UIImageView alloc]init];
    _UserImageView.backgroundColor = [UIColor whiteColor];
    _UserImageView.layer.masksToBounds = YES;
    _UserImageView.layer.cornerRadius = 16;
    [self addSubview:_UserImageView];
    [_UserImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
    }];
    _UserNameLabel = [[UILabel alloc]init];
    _UserNameLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_UserNameLabel];
    [_UserNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_UserImageView.mas_right).offset(5);
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    _UserPhoneLabel = [[UILabel alloc]init];
    _UserPhoneLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_UserPhoneLabel];
    [_UserPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_UserImageView.mas_right).offset(5);
        make.top.mas_equalTo(self->_UserNameLabel.mas_bottom);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(17);
    }];
    _UserStateLabel = [[UILabel alloc]init];
    _UserStateLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_UserStateLabel];
    [_UserStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self.mas_top).offset(28);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    _UserSetFirstImageView = [[UIImageView alloc]init];
    _UserSetFirstImageView.hidden = YES;
    _UserSetFirstImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_UserSetFirstImageView];
    [_UserSetFirstImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self->_UserImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);

    }];
    _UserSetSecondImageView = [[UIImageView alloc]init];
    _UserSetSecondImageView.hidden = YES;
    _UserSetSecondImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_UserSetSecondImageView];
    [_UserSetSecondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_UserSetFirstImageView.mas_right).offset(13);
        make.top.mas_equalTo(self->_UserImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);
        
    }];
    _UserSetThirdImageView = [[UIImageView alloc]init];
     _UserSetThirdImageView.hidden = YES;
    _UserSetThirdImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_UserSetThirdImageView];
    [_UserSetThirdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_UserSetSecondImageView.mas_right).offset(13);
        make.top.mas_equalTo(self->_UserImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(109);
        make.height.mas_equalTo(109);
        
    }];
    _ShopDetailLabel = [[UILabel alloc]init];
    _ShopDetailLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_ShopDetailLabel];
    [_ShopDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self->_UserSetFirstImageView.mas_bottom).offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH-40);
        make.height.mas_equalTo(20);
    }];
    _ShopMoneyLabel = [[UILabel alloc]init];
    _ShopMoneyLabel.font = [UIFont systemFontOfSize:20];
    _ShopMoneyLabel.textColor = colorWithRGB(1, 0.29, 0.29);
    [self addSubview:_ShopMoneyLabel];
    [_ShopMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.top.mas_equalTo(self->_ShopDetailLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
    }];
    _ShopUserLabel = [[UILabel alloc]init];
    _ShopUserLabel.font = [UIFont systemFontOfSize:12];
    _ShopUserLabel.textAlignment = NSTextAlignmentRight;
    _ShopUserLabel.textColor = colorWithRGB(0.56, 0.56, 0.56);
    [self addSubview:_ShopUserLabel];
    [_ShopUserLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.top.mas_equalTo(self->_ShopDetailLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(20);
    }];
    
}
- (void)setShopModel:(YJHotShopModel *)shopModel{
    if (shopModel != _shopModel) {
        _shopModel = shopModel;
        [_UserImageView sd_setImageWithURL:[NSURL URLWithString:shopModel.imageUrl] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        if (shopModel.nickName.length) {
            _UserNameLabel.text = shopModel.nickName;
        }else{
            _UserNameLabel.text  = @"迈克";
        }
        if (shopModel.phoneNumber.length) {
            _UserPhoneLabel.text = shopModel.phoneNumber;
        }else{
            _UserPhoneLabel.text =@"暂未设置电话号码";
        }
        
        _ShopUserLabel.text = shopModel.shoppingGuide;
        if (shopModel.price) {
            _ShopMoneyLabel.text = shopModel.price;

        }else{
            _ShopMoneyLabel.text =@"正在评估";

        }
        //0待确认 1已确认 2已付款 3已取消
        if ([_shopModel.state integerValue] == 1) {
             _UserStateLabel.text = @"已确认 ";
        }else if ([_shopModel.state integerValue] == 2){
            _UserStateLabel.text = @"已付款";
        }else if ([_shopModel.state integerValue] == 3){
            _UserStateLabel.text = @"已取消";
        }else{
            _UserStateLabel.text = @"待确认";
        }
     
        NSMutableArray *array = [[NSMutableArray alloc]init];
        [array removeAllObjects];
        if (shopModel.doorColumnStyle.length) {
            [array addObject:_shopModel.doorColumnStyle];
        }
        if (shopModel.doorHeadStyle.length) {
            [array addObject:_shopModel.doorHeadStyle];
        }
        if (shopModel.style.length) {
            [array addObject:_shopModel.style];
        }
        for (int i = 0; i <array.count; i++) {
            if (i == 0) {
                [_UserSetFirstImageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:0]]];
            }else if (i == 1){
                [_UserSetSecondImageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:1]]];
            }else{
                [_UserSetThirdImageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:2]]];
            }
            
            
        }
        if (array.count== 1) {
            _UserSetFirstImageView.hidden = NO;
            _UserSetSecondImageView.hidden = YES;
            _UserSetThirdImageView.hidden = YES;
            [_ShopDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(20);

                make.top.mas_equalTo(self->_UserSetFirstImageView.mas_bottom).offset(5);
            }];
        }else if (array.count == 2){
            _UserSetFirstImageView.hidden = NO;
            _UserSetSecondImageView.hidden = NO;
            _UserSetThirdImageView.hidden = YES;
            [_ShopDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(20);

                make.top.mas_equalTo(self->_UserSetFirstImageView.mas_bottom).offset(5);
            }];
        }else if (array.count == 3){
            _UserSetFirstImageView.hidden = NO;
            _UserSetSecondImageView.hidden = NO;
            _UserSetThirdImageView.hidden = NO;
            [_ShopDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(20);

                make.top.mas_equalTo(self->_UserSetFirstImageView.mas_bottom).offset(5);
            }];
        }else{
            _UserSetFirstImageView.hidden = YES;
            _UserSetSecondImageView.hidden = YES;
            _UserSetThirdImageView.hidden = YES;
        
            [_ShopDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.mas_left).offset(20);

                 make.top.mas_equalTo(self->_UserImageView.mas_bottom).offset(10);
            }];
        }
        
        _ShopDetailLabel.text = _shopModel.name;

       
    }
    
}
+ (CGFloat)whc_CellHeightForIndexPath:(NSIndexPath *)indexPath shopModel:(YJHotShopModel *)model{
    if (model.style.length) {
        return 254;
    }else if (model.doorHeadStyle.length){
        return 254;
    }else if (model.doorHeadStyle.length){
        return 254;
    }else{
        return 254-109;
    }
}
@end
