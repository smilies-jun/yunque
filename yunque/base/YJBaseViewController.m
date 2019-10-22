//
//  YJBaseViewController.m
//  maike
//
//  Created by amin on 2019/7/13.
//  Copyright © 2019 yj. All rights reserved.
//

#import "YJBaseViewController.h"

@interface YJBaseViewController (){
     UIImageView *navBarHairlineImageView;
}

@end

@implementation YJBaseViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark - 隐藏当前页面所有键盘-
- (void)HideKeyBoardClick{
    for (UIView *KeyView in self.view.subviews) {
        [self dismissAllKeyBoard:KeyView];
    }
    
}

- (BOOL)dismissAllKeyBoard:(UIView *)view{
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoard:subView])
        {
            return YES;
        }
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    _TopView = [[UIView alloc]init];
    _TopView.backgroundColor = [UIColor whiteColor];
    _TopView.hidden = NO;
    [self.view addSubview:_TopView];
    [_TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.top.mas_equalTo(self.view.mas_top).offset(StatusBarHeight);
        make.height.mas_equalTo(64);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    _BackButton = [UIButton buttonWithType:UIButtonTypeCustom];
   [_BackButton setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    _BackButton.clickArea = @"3";
    [_TopView addSubview:_BackButton];
    [_BackButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_TopView.mas_left).offset(20);
        make.top.mas_equalTo(self->_TopView.mas_top).offset(30);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    
    _RightFirstButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //[_RightFirstButton setImage:[UIImage imageNamed:@"identity_scan"] forState:UIControlStateNormal];
    [_TopView addSubview:_RightFirstButton];
    [_RightFirstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_TopView.mas_right).offset(-20);
        make.top.mas_equalTo(self->_TopView.mas_top).offset(20);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    
    _RightSecondButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[_RightSecondButton setImage:[UIImage imageNamed:@"identity_scan"] forState:UIControlStateNormal];
    [_TopView addSubview:_RightSecondButton];
    [_RightSecondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->_RightFirstButton.mas_left).offset(-10);
        make.top.mas_equalTo(self->_TopView.mas_top).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20);
    }];
    _TopTitleLabel = [[UILabel alloc]init];
    _TopTitleLabel.textAlignment = NSTextAlignmentCenter;
    _TopTitleLabel.font = [UIFont systemFontOfSize:18];
    _TopTitleLabel.textColor = [UIColor blackColor];
    [_TopView addSubview:_TopTitleLabel];
    [_TopTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self->_TopView.mas_centerX);
        make.top.mas_equalTo(self->_TopView.mas_top).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40);
    }];
    
   // [self.searchBar becomeFirstResponder];
    
    _YJsearchBar = [[EVNCustomSearchBar alloc] initWithFrame:CGRectMake(50, 10, SCREEN_WIDTH-80, 44)];
    _YJsearchBar.hidden = YES;
    
    _YJsearchBar.backgroundColor = [UIColor clearColor]; // 清空searchBar的背景色
    //_YJsearchBar.iconImage = [UIImage imageNamed:@"SouSuo"];
    //        _searchBar.iconImage = [UIImage imageNamed:@"EVNCustomSearchBar.bundle/searchImageTextColor.png"];
    _YJsearchBar.iconAlign = EVNCustomSearchBarIconAlignLeft;
    [_YJsearchBar setPlaceholder:@"请输入关键字"];  // 搜索框的占位符
   //_YJsearchBar.placeholderColor = TextGrayColor;
    _YJsearchBar.delegate = self; // 设置代理
    _YJsearchBar.isHiddenCancelButton = YES;

    [_YJsearchBar sizeToFit];
    [_TopView addSubview:_YJsearchBar];

 
}
#pragma mark: EVNCustomSearchBar delegate method
- (BOOL)searchBarShouldBeginEditing:(EVNCustomSearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (BOOL)searchBarShouldEndEditing:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
    return YES;
}

- (void)searchBarTextDidEndEditing:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)searchBar:(EVNCustomSearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (BOOL)searchBar:(EVNCustomSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
    return YES;
}

- (void)searchBarSearchButtonClicked:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)searchBarCancelButtonClicked:(EVNCustomSearchBar *)searchBar
{
    NSLog(@"class: %@ function:%s", NSStringFromClass([self class]), __func__);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.YJsearchBar resignFirstResponder];
}

#pragma mark: UISearchResultsUpdating Method
#pragma mark 监听者搜索框中的值的变化
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // 1. 获取输入的值
   // self.inputText = self.searchBar.text;
    //    [self afn1];
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (@available(iOS 13.0, *)) {
        UIView *viewStatusColorBlend = [[UIView alloc]initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
        viewStatusColorBlend.backgroundColor = color;
        [keyWindow addSubview:viewStatusColorBlend];
    } else {
        // Fallback on earlier versions
        UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
           if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
               statusBar.backgroundColor = color;
           }
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
