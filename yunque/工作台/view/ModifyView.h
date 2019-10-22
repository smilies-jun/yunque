//
//  ModifyView.h
//  maike
//
//  Created by Apple on 2019/8/2.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJUpShopModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HeaderViewDelegate <NSObject>

- (void)selAnSection:(NSInteger)section;

@end

@interface ModifyView : UIView

@property (nonatomic,strong)UILabel *NameLabel;

@property (nonatomic,strong)UITextField *NameTextField;

@property (nonatomic, weak) id < HeaderViewDelegate> delegate;
@property (nonatomic,assign) NSInteger section;
@property(nonatomic, retain)YJUpShopModel *UpShopModel;

- (void)configUI:(NSIndexPath *)indexPath;
- (void)setUpShopModel:(YJUpShopModel * _Nonnull)UpShopModel;
@end

NS_ASSUME_NONNULL_END
