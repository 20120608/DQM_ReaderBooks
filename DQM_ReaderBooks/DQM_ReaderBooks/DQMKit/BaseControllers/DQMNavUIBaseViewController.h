//
//  DQMNavUIBaseViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 自定义的视图带导航栏基类的视图 */
#import <UIKit/UIKit.h>
#import "DQMNavigationBar.h"
#import "DQMNavigationController.h"

@class DQMNavUIBaseViewController;
@protocol DQMNavUIBaseViewControllerDataSource <NSObject>

@optional
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController;
@end

@interface DQMNavUIBaseViewController : UIViewController <DQMNavigationBarDelegate, DQMNavigationBarDataSource, DQMNavUIBaseViewControllerDataSource>
/*默认的导航栏字体*/
- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle;
/**  */
@property (weak, nonatomic) DQMNavigationBar *dqm_navgationBar;


@end

