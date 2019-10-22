//
//  YJNewShopCollectionViewCell.m
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJNewShopCollectionViewCell.h"

@implementation YJNewShopCollectionViewCell
//方块视图的缓存池标示
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"NewShopCollectionViewCellIdentifier";
    return cellIdentifier;
}
//获取方块视图对象
+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    YJNewShopCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[YJNewShopCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    return cell;
    
}
//注册了方块视图后，当缓存池中没有底部视图的对象时候，自动调用alloc/initWithFrame创建
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.layer.masksToBounds = YES;
        _shopImageView.layer.cornerRadius =30.0f;
        _shopImageView.backgroundColor = font_main_color;
        [self addSubview:_shopImageView];
        [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.top.mas_equalTo(self.mas_top).offset(10);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.text = @"铜门";
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_shopImageView.mas_left);
            make.top.mas_equalTo(self->_shopImageView.mas_bottom).offset(5);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
@end
