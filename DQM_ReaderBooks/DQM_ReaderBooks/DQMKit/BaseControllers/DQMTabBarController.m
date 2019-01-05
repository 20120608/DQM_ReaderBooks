//
//  DQMTabBarController.m
//  DQM_AnimationDemo
//
//  Created by 漂读网 on 2018/12/24.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMTabBarController.h"
#import "DQMNavigationController.h"                     //导航栏  给每个首页套上导航栏
#import "BooksListViewController.h"                     //书籍列表
#import "DownloadOnceWebBookViewController.h"           //下载一本书籍

@interface DQMTabBarController () <UITabBarControllerDelegate>

@end

@implementation DQMTabBarController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self addChildViewControllers];
  [self addTabarItems];
  self.delegate = self;
}
- (void)customIsInGod:(NSNotification *)noti {
  if (![noti.object boolValue]) {
    return;
  }
}


- (void)addChildViewControllers
{
  DQMNavigationController *one = [[DQMNavigationController alloc] initWithRootViewController:[[BooksListViewController alloc] initWithTitle:@"首页列表"]];
  
  DQMNavigationController *two = [[DQMNavigationController alloc] initWithRootViewController:[[DownloadOnceWebBookViewController alloc] initWithTitle:@"下载新书"]];
  
   self.viewControllers = @[one,two];
  
}

- (void)addTabarItems
{
  
  NSDictionary *firstTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"书本列表",
                                               @"TabBarItemImage" : @"icon_tabbar_home_default",
                                               @"TabBarItemSelectedImage" : @"icon_tabbar_home_select",
                                               };
  
  NSDictionary *secondTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"下载新书",
                                               @"TabBarItemImage" : @"icon_tabbar_download_default",
                                               @"TabBarItemSelectedImage" : @"icon_tabbar_download_select",
                                               };
  
  NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                          firstTabBarItemsAttributes,
                                                          secondTabBarItemsAttributes,
                                                          ];
  
  [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    obj.tabBarItem.title = tabBarItemsAttributes[idx][@"TabBarItemTitle"];
    obj.tabBarItem.image = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemImage"]];
    obj.tabBarItem.selectedImage = [UIImage imageNamed:tabBarItemsAttributes[idx][@"TabBarItemSelectedImage"]];
    obj.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
  }];
  
  self.tabBar.tintColor = [UIColor redColor];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
  return YES;
}

@end
