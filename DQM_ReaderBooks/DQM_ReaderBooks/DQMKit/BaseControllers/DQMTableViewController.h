//
//  DQMTableViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 列表视图控制器基类 在原有的 带有网络监控 遮罩 导航等等的视图控制器基类 封装得来 */
#import "DQMBaseViewController.h"

@interface DQMTableViewController : DQMBaseViewController <UITableViewDelegate, UITableViewDataSource>

// 这个代理方法如果子类实现了, 必须调用super
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView NS_REQUIRES_SUPER;


/** 列表 */
@property (strong, nonatomic) UITableView *tableView;

// tableview的样式, 默认plain
- (instancetype)initWithStyle:(UITableViewStyle)style;


@end

