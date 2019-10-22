//
//  YJBaseViewController.h
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PYSearch.h"
#import "EVNCustomSearchBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface YJBaseViewController : UIViewController<EVNCustomSearchBarDelegate>
@property (nonatomic,strong)UIView *TopView;
@property (nonatomic,strong)UIButton *BackButton;
@property (nonatomic,strong)UILabel  *TopTitleLabel;
@property (nonatomic,strong)UIButton *RightFirstButton;
@property (nonatomic,strong)UIButton *RightSecondButton;

@property (strong, nonatomic) EVNCustomSearchBar *YJsearchBar;
- (void)HideKeyBoardClick;
- (void)setStatusBarBackgroundColor:(UIColor *)color;
@end

NS_ASSUME_NONNULL_END
