//
//  AppDelegate.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "DQMTabBarController.h"
#import "YYFPSLabel.h"
#import "DQMReaderPageViewController.h"           //小说阅读器
#import "DQMReadHistory.h"                         //小说模型
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  //创建根目录  不创建
  [DQMFileTools creatRootDirectory];
  NSLog(@"%@",DCBooksPath);
  

  
  
  
  /*配置键盘*/
  IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
  manager.enable = YES;//    控制整个功能是否启用。
  manager.overrideKeyboardAppearance = YES;
  manager.shouldResignOnTouchOutside = YES;//控制点击背景是否收起键盘
  manager.enableAutoToolbar = YES;//控制是否显示键盘上的工具条。
  manager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
  
  
  self.window.rootViewController = [[DQMTabBarController alloc] init];
  [self.window makeKeyAndVisible];
  
  [self.window addSubview:[[YYFPSLabel alloc] initWithFrame:CGRectMake(61, STATUS_BAR_HEIGHT, 0, 0)]];
  
  
  
  return YES;

}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
  
  //QQ文件可以用其他APP打开到这  以下部分可以不用
  if (url)
  {
    
    NSString *fileNameStr = [url lastPathComponent];
    fileNameStr = [fileNameStr stringByRemovingPercentEncoding];
    
    NSString *toPath = [DCBooksPath stringByAppendingPathComponent:fileNameStr];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
    [data writeToFile:toPath atomically:YES];
    
    
    //用阅读器打开这个文件
//    DQMReaderPageViewController *vc = [[DQMReaderPageViewController alloc] init];
//    DQMReadHistory *ReadHistory = [[DQMReadHistory alloc] init];
//    ReadHistory.name ...
//    vc.filePath = toPath;
//    [((UINavigationController *)self.window.rootViewController.childViewControllers[0]).topViewController.navigationController pushViewController:vc animated:YES];
    
  }
  
  
  
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
