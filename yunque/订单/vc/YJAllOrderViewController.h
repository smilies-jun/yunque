//
//  YJAllOrderViewController.h
//  maike
//
//  Created by Apple on 2019/7/19.
//  Copyright © 2019 yj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJAllOrderViewController : UIViewController<UITableViewDataSource , UITableViewDelegate>{
    int page;
    BOOL isFirstCome; //第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容。
    int totalPage;//总页数
    BOOL isJuhua;//是否正在下拉刷新或者上拉加载。default NO。
}
@property(nonatomic,strong)NSMutableArray *pictures;
/** maxtime */
@property(nonatomic,copy)NSString *maxtime;

@property (nonatomic, strong) UITableView *AllOrderTableView;


/**
 *  获取网络数据
 *  @param isRefresh 是否是下拉刷新
 */
-(void)getNetworkData:(BOOL)isRefresh;

@end

NS_ASSUME_NONNULL_END
