//
//  DQMBaseViewController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMBaseViewController.h"
//#import "DQMUMengHelper.h"    //解锁三个并pod Umeng即可进行统计分析了

@interface DQMBaseViewController ()



@end

@implementation DQMBaseViewController


#pragma mark - 生命周期
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
  self.automaticallyAdjustsScrollViewInsets = NO;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    if (@available(iOS 11.0, *)){
      //处理掉视图偏移问题
      [[UIScrollView appearanceWhenContainedInInstancesOfClasses:@[[DQMBaseViewController class]]] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
  });
  
  /*
   *例如： 使UIView上面的UIButton的titleColor都变成灰色
   *[[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   */
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  // 配置友盟统计
//  [DQMUMengHelper beginLogPageViewName:self.title ?: self.navigationItem.title];
  
}


- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
  
  // 配置友盟统计
//  [DQMUMengHelper endLogPageViewName:self.title ?: self.navigationItem.title];
}

- (instancetype)initWithTitle:(NSString *)title
{
  if (self = [super init]) {
    self.title = title.copy;
  }
  return self;
}

- (void)dealloc
{
  NSLog(@"dealloc---%@", self.class);
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end








