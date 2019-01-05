//
//  DQMRequestBaseViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 带网络监察的视图基类 */
#import "DQMTextViewController.h"

@class DQMRequestBaseViewController;
@protocol DQMRequestBaseViewControllerDelegate <NSObject>

@optional
#pragma mark - 网络监听
/*
 NotReachable = 0,
 ReachableViaWiFi = 2,
 ReachableViaWWAN = 1,
 ReachableVia2G = 3,
 ReachableVia3G = 4,
 ReachableVia4G = 5,
 */
- (void)networkStatus:(NetworkStatus)networkStatus inViewController:(DQMRequestBaseViewController *)inViewController;

@end



@interface DQMRequestBaseViewController : DQMTextViewController<DQMRequestBaseViewControllerDelegate>
#pragma mark - 加载框

- (void)showLoading;

- (void)dismissLoading;

@end


