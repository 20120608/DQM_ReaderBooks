//
//  DQMNavigationController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMNavigationController.h"

@interface DQMNavigationController ()

/** 系统的右划返回功能的代理记录 */
//@property (nonatomic, strong) id popGesDelegate;

@end

@implementation DQMNavigationController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationBar.hidden = YES;
  
  // 不让自控制器控制系统导航条
  self.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
}
/*
 #pragma mark - 全局侧滑代码------------BEGIN----
 - (void)getSystemGestureOfBack
 {
 // 记录系统的pop代理
 UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
 
 [self.view addGestureRecognizer:panGes];
 
 panGes.delegate = self;
 
 // 禁止之前的手势
 self.interactivePopGestureRecognizer.enabled = NO;
 
 }
 
 
 - (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
 {
 // 非根控制器才能触发
 return self.childViewControllers.count > 1;
 }
 #pragma mark - 全局侧滑代码------------END----
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (self.childViewControllers.count != 0) {
    viewController.hidesBottomBarWhenPushed = YES;
  }
  
  [super pushViewController:viewController animated:animated];
}

/** 不返回顶级视图就不会触发最顶层视图的preferredStatusBarStyle */
- (UIViewController *)childViewControllerForStatusBarStyle {
  return self.topViewController;
}

@end



