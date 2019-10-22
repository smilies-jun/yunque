//
//  FCCollectionViewCell.m
//  FCUICollectionView
//
//  Created by FanChuan on 2019/6/17.
//  Copyright © 2019 fc. All rights reserved.
//

#import "YJPhoneImageCollectionViewCell.h"

@implementation YJPhoneImageCollectionViewCell
//方块视图的缓存池标示
+(NSString *)cellIdentifier{
    static NSString *cellIdentifier = @"CollectionViewCellIdentifier";
    return cellIdentifier;
}
//获取方块视图对象
+(instancetype)cellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    YJPhoneImageCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[YJPhoneImageCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    return cell;
    
}
//注册了方块视图后，当缓存池中没有底部视图的对象时候，自动调用alloc/initWithFrame创建
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _shopImageView = [[UIImageView alloc]init];
        _shopImageView.backgroundColor = colorWithRGB(0.95, 0.95, 0.95);
        [self addSubview:_shopImageView];
        [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_shopImageView.mas_bottom).offset(2);
            make.centerX.mas_equalTo(self->_shopImageView.mas_centerX);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
@end
