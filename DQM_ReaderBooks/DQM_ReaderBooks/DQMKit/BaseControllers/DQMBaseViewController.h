//
//  DQMBaseViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 带有网络监控 遮罩 导航等等的视图控制器基类 */
#import <UIKit/UIKit.h>
#import "DQMRequestBaseViewController.h"

@interface DQMBaseViewController : DQMRequestBaseViewController

- (instancetype)initWithTitle:(NSString *)title;

@end
