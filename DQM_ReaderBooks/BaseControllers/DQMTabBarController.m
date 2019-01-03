//
//  DQMTabBarController.m
//  DQM_AnimationDemo
//
//  Created by 漂读网 on 2018/12/24.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMTabBarController.h"
#import "DQMNavigationController.h"                     //导航栏  给每个首页套上导航栏
#import "ReactiveCocoaListViewController.h"

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
  DQMNavigationController *one = [[DQMNavigationController alloc] initWithRootViewController:[[ReactiveCocoaListViewController alloc] initWithTitle:@"首页列表"]];
  
//  LMJNavigationController *two = [[LMJNavigationController alloc] initWithRootViewController:[[LMJNewViewController alloc] init]];
//
//  LMJNavigationController *three = [[LMJNavigationController alloc] initWithRootViewController:[[LMJMessageViewController alloc] init]];
//
//  LMJNavigationController *four = [[LMJNavigationController alloc] initWithRootViewController:[[LMJMeViewController alloc] init]];
  
//  LMJNavigationController *five = [[LMJNavigationController alloc] initWithRootViewController:[[LMJCasesViewController alloc] init]];
  
//  self.viewControllers = @[two, one, three, five, four];
  
   self.viewControllers = @[one];
  
}

- (void)addTabarItems
{
  
  NSDictionary *firstTabBarItemsAttributes = @{
                                               @"TabBarItemTitle" : @"首页列表",
                                               @"TabBarItemImage" : @"icon_tabbar_home_default",
                                               @"TabBarItemSelectedImage" : @"icon_tabbar_home_select",
                                               };
  
//  NSDictionary *secondTabBarItemsAttributes = @{
//                                                @"TabBarItemTitle" : @"预演",
//                                                @"TabBarItemImage" : @"tabBar_friendTrends_icon",
//                                                @"TabBarItemSelectedImage" : @"tabBar_friendTrends_click_icon",
//                                                };
//  NSDictionary *thirdTabBarItemsAttributes = @{
//                                               @"TabBarItemTitle" : @"实例",
//                                               @"TabBarItemImage" : @"tabBar_new_icon",
//                                               @"TabBarItemSelectedImage" : @"tabBar_new_click_icon",
//                                               };
//  NSDictionary *fourthTabBarItemsAttributes = @{
//                                                @"TabBarItemTitle" : @"分享",
//                                                @"TabBarItemImage" : @"tabBar_me_icon",
//                                                @"TabBarItemSelectedImage" : @"tabBar_me_click_icon"
//                                                };
//  NSDictionary *fifthTabBarItemsAttributes = @{
//                                               @"TabBarItemTitle" : @"更多",
//                                               @"TabBarItemImage" : @"tabbar_discover",
//                                               @"TabBarItemSelectedImage" : @"tabbar_discover_highlighted"
//                                               };
  NSArray<NSDictionary *>  *tabBarItemsAttributes = @[
                                                          firstTabBarItemsAttributes,
//                                                          secondTabBarItemsAttributes,
//                                                          thirdTabBarItemsAttributes,
//                                                          fifthTabBarItemsAttributes,
//                                                          fourthTabBarItemsAttributes
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
