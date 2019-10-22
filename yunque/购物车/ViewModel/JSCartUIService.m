//
//  JSCartUIService.m
//  JSShopCartModule
//
//  Created by 乔同新 on 16/6/9.
//  Copyright © 2016年 乔同新. All rights reserved.
//

#import "JSCartUIService.h"
#import "JSCartViewModel.h"
#import "JSCartCell.h"
#import "JSCartHeaderView.h"
#import "JSCartFooterView.h"
#import "JSCartModel.h"
#import "JSNummberCount.h"

@implementation JSCartUIService

#pragma mark - UITableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.cartData.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([self.viewModel.cartData[section] count]) {
         return [self.viewModel.cartData[section] count];
    }
    return 1;
}

#pragma mark - header view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];

    JSCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartHeaderView"];
    //店铺全选
    [[[headerView.selectStoreGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:headerView.rac_prepareForReuseSignal] subscribeNext:^(UIButton *xx) {
        xx.selected = !xx.selected;
        BOOL isSelect = xx.selected;
        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
        for (JSCartModel *model in shopArray) {
            [model setValue:@(isSelect) forKey:@"isSelect"];
        }
        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
        self.viewModel.allPrices = [self.viewModel getAllPrices];
    }];
    //店铺选中状态
    headerView.selectStoreGoodsButton.selected = [self.viewModel.shopSelectArray[section] boolValue];
    
//    [RACObserve(headerView.selectStoreGoodsButton, selected) subscribeNext:^(NSNumber *x) {
//        
//        BOOL isSelect = x.boolValue;
//        
//        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
//        for (JSCartModel *model in shopArray) {
//            [model setValue:@(isSelect) forKey:@"isSelect"];
//        }
//        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//    }];
    
    return headerView;
}

#pragma mark - footer view

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if ([self.viewModel.cartData[0] count]) {
       return [JSCartFooterView getCartFooterHeight];
    }else{
        return 0;
    }
   
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    JSCartFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartFooterView"];
    
    footerView.shopGoodsArray = shopArray;
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     if ([self.viewModel.cartData[0] count]) {
    return [JSCartCell getCartCellHeight];
     }else{
         return SCREEN_HEIGHT - 64;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([self.viewModel.cartData[0] count]) {
            JSCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JSCartCell"
                                                       forIndexPath:indexPath];
    
         [self configureCell:cell forRowAtIndexPath:indexPath];
    
         return cell;
     }else{
         static NSString *identifier = @"NodatBundproductidentifier";
         
         NoDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
         if (!cell) {
             cell = [[NoDateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
             [cell configUI:indexPath];
             cell.backgroundColor = [UIColor whiteColor];
             cell.ImageView.image = [UIImage imageNamed:@"暂无客户"];
             cell.NameLabel.text = @"购物车为空！请去挑选商品";
             // cell.backgroundColor = colorWithRGB(0.93, 0.93, 0.93);
             
         }
         
         //  cell.ImageView.image = [UIImage imageNamed:@"nodatas@2x"];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;
        
     
     }
}

- (void)configureCell:(JSCartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    JSCartModel *model = self.viewModel.cartData[section][row];
    //cell 选中
    WEAK
    [[[cell.selectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton *x) {
        STRONG
        x.selected = !x.selected;
        [self.viewModel rowSelect:x.selected IndexPath:indexPath];
    }];
    //数量改变
    cell.nummberCount.NumberChangeBlock = ^(NSInteger changeCount){
        STRONG
        [self.viewModel rowChangeQuantity:changeCount indexPath:indexPath];
    };
    cell.model = model;
}

#pragma mark - delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JSCartModel *model = self.viewModel.cartData[0][indexPath.row];

        self.viewModel.deleteShopId = model.p_product_id;
        [self.viewModel deleteGoodsBySingleSlide:indexPath];
    }
}


@end
