//
//  YJPinPaiTableViewCell.m
//  yunque
//
//  Created by Apple on 2019/10/15.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJPinPaiTableViewCell.h"
#import "UIView+SDAutoLayout.h"

@implementation YJPinPaiTableViewCell
{
    UIImageView *_iconView;
    UILabel *_nameLable;
    UILabel *_contentLabel;
    
    UIImageView *imageView0;
    UIImageView *imageView1;
    UIImageView *imageView2;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setup];
        
        //设置主题
        //[self configTheme];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)setup{
    
        _iconView = [UIImageView new];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius =20.0f;
        [self.contentView addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(20);
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        _nameLable = [UILabel new];
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
        [self.contentView addSubview:_nameLable];
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_iconView.mas_right).offset(10);
                make.centerY.mas_equalTo(_iconView.mas_centerY);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(40);
        }];
    
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 0;
        _contentLabel.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(self.contentView.mas_left).offset(20);
              make.top.mas_equalTo(_iconView.mas_bottom).offset(20);
              make.width.mas_equalTo(SCREEN_WIDTH - 40);
              make.height.mas_equalTo(200);
          }];
        _contentLabel.sd_layout.autoHeightRatio(0);
    
    
    imageView0 = [UIImageView   new];
    //imageView0.image = [UIImage imageNamed:@"icon1.jpg"];
    [self.contentView addSubview:imageView0];
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(105);
    }];
    imageView1 = [UIImageView   new];
   // imageView1.image = [UIImage imageNamed:@"icon1.jpg"];
    [self.contentView addSubview:imageView1];
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView0.mas_right).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(105);
    }];
    imageView2 = [UIImageView   new];
   // imageView2.image = [UIImage imageNamed:@"icon1.jpg"];
    [self.contentView addSubview:imageView2];
    [imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView1.mas_right).offset(10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.mas_equalTo(105);
        make.height.mas_equalTo(105);
    }];

}

- (void)setModel:(YJPinPaiModel *)model
{
    _model = model;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.brandIcon]]];
    _nameLable.text= model.title;
    _contentLabel.text = model.productDes;
    if (model.wheelImageUrls.count==3) {
        [imageView0 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
           [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:1]]]placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
           [imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:2]]]placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
    }else if (model.masterImageUrls.count == 2){
        [imageView0 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
                 [imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:1]]]placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
    }else{
        [imageView0 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[model.wheelImageUrls objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"icon1.jpg"]];
               
    }
   

    
}

@end
