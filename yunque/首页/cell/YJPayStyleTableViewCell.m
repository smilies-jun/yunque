//
//  YJPayStyleTableViewCell.m
//  maike
//
//  Created by Apple on 2019/7/24.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPayStyleTableViewCell.h"

@implementation YJPayStyleTableViewCell

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
    _NameLabel.text = @"商品金额";
    _NameLabel.font = [UIFont systemFontOfSize:17];
    _NameLabel.numberOfLines = 0;
    [self addSubview:_NameLabel];
    [_NameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(10);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(40);
    }];
    
  
    _AdressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_AdressBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_AdressBtn setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateSelected];
    [self.contentView addSubview:_AdressBtn];
    [_AdressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.top.mas_equalTo(self.contentView.mas_top).offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
}
@end
