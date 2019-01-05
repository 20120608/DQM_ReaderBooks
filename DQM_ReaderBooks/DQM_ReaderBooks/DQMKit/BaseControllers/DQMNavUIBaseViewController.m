//
//  DQMNavUIBaseViewController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMNavUIBaseViewController.h"
#import "DQMNavigationBar.h"

@implementation DQMNavUIBaseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  QMWeak(self);
  [self.navigationItem addObserverBlockForKeyPath:QMKeyPath(self.navigationItem, title) block:^(id  _Nonnull obj, id  _Nonnull oldVal, NSString  *_Nonnull newVal) {
    if (newVal.length > 0 && ![newVal isEqualToString:oldVal]) {
      weakself.title = newVal;
    }
  }];
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

- (void)viewWillLayoutSubviews {
  [super viewWillLayoutSubviews];
}


- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  
  self.dqm_navgationBar.width = self.view.width;
  [self.view bringSubviewToFront:self.dqm_navgationBar];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)dealloc {
  [self.navigationItem removeObserverBlocksForKeyPath:QMKeyPath(self.navigationItem, title)];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}

#pragma mark - DataSource
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(DQMNavUIBaseViewController *)navUIBaseViewController {
  return YES;
}

/**头部标题*/
- (NSMutableAttributedString*)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar {
  return [self changeTitle:self.title ?: self.navigationItem.title];
}

/** 背景图片 */
//- (UIImage *)dqmNavigationBarBackgroundImage:(DQMNavigationBar *)navigationBar
//{
//
//}

/** 背景色 */
- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar {
  return [UIColor whiteColor];
}

/** 是否显示底部黑线 */
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar
{
    return NO;
}

/** 导航条的高度 */
- (CGFloat)dqmNavigationHeight:(DQMNavigationBar *)navigationBar {
  return [UIApplication sharedApplication].statusBarFrame.size.height + 44.0;
}


/** 导航条的左边的 view */
//- (UIView *)dqmNavigationBarLeftView:(DQMNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的 view */
//- (UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar
//{
//
//}
/** 导航条中间的 View */
//- (UIView *)dqmNavigationBarTitleView:(DQMNavigationBar *)navigationBar
//{
//
//}
/** 导航条左边的按钮 */
//- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar
//{
//
//}
/** 导航条右边的按钮 */
//- (UIImage *)dqmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(DQMNavigationBar *)navigationBar
//{
//
//}



#pragma mark - Delegate
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  NSLog(@"%s", __func__);
}
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  NSLog(@"%s", __func__);
}
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(DQMNavigationBar *)navigationBar {
  NSLog(@"%s", __func__);
}


#pragma mark 自定义代码

- (NSMutableAttributedString *)changeTitle:(NSString *)curTitle
{
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
  
  [title addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, title.length)];
  
  [title addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, title.length)];
  
  return title;
}


- (DQMNavigationBar *)dqm_navgationBar {
  // 父类控制器必须是导航控制器
  if(!_dqm_navgationBar && [self.parentViewController isKindOfClass:[UINavigationController class]])
  {
    DQMNavigationBar *navigationBar = [[DQMNavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0)];
    [self.view addSubview:navigationBar];
    _dqm_navgationBar = navigationBar;
    
    navigationBar.dataSource = self;
    navigationBar.dqmDelegate = self;
    navigationBar.hidden = ![self navUIBaseViewControllerIsNeedNavBar:self];
  }
  return _dqm_navgationBar;
}




- (void)setTitle:(NSString *)title {
  [super setTitle:title];
  self.dqm_navgationBar.title = [self changeTitle:title];
}

@end






