//
//  NoDateTableViewCell.h
//  milier
//
//  Created by amin on 2017/6/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDateTableViewCell : UITableViewCell

@property (nonatomic , retain) UILabel *NameLabel;

@property (nonatomic , retain) UIImageView *ImageView;

- (void)configUI:(NSIndexPath *)indexPath;


@end
