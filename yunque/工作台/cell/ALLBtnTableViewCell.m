//
//  ALLBtnTableViewCell.m
//  maike
//
//  Created by Apple on 2019/8/1.
//  Copyright © 2019 yj. All rights reserved.
//

#import "ALLBtnTableViewCell.h"

@implementation ALLBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI:(NSIndexPath *)indexPath{
    _lineImageView = [[UIView alloc]init];
    _lineImageView.backgroundColor = font_main_color;
    [self addSubview:_lineImageView];
    [_lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(40);
    }];
    
    _btnLabel = [[UILabel alloc]init];
    _btnLabel.text = @"防火门";
    _btnLabel.textAlignment = NSTextAlignmentCenter;
    _btnLabel.font = [UIFont systemFontOfSize:14];
    _btnLabel.textColor = font_main_color;
    _btnLabel.frame = CGRectMake(10, 20, 60, 20);
    [self addSubview:_btnLabel];
     
}
     
@end
