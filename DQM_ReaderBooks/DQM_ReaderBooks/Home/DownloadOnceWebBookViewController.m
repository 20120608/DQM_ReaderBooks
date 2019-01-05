//
//  DownloadOnceWebBookViewController.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/5.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DownloadOnceWebBookViewController.h"


//小说阅读器
#import "DQMReadHistory.h"
#import "DQMReaderPageViewController.h"



@interface DownloadOnceWebBookViewController ()

@end

@implementation DownloadOnceWebBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, (kScreenHeight-100)/2 - 50, 200, 100) buttonTitle:@"下载新书" normalColor:[UIColor blueColor] cornerRadius:4 doneBlock:^(UIButton *sender) {
    
    [self WebTxtBookjudgeFileExistWithUrl:@"https://image.piaoduwang.cn/group1/M00/01/B4/rBAAiVwnOiGAIoUhAAkwCpXA00s755.txt"];
    
    
  }];
  [self.view addSubview:button];
  
  
  UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake((kScreenWidth-200)/2, (kScreenHeight-100)/2 + 50, 200, 100) buttonTitle:@"加载项目中的书" normalColor:[UIColor blueColor] cornerRadius:4 doneBlock:^(UIButton *sender) {
    
    //将mainbundle的文件拷贝到沙盒
    NSFileManager *fileMag = [NSFileManager defaultManager];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"龙王传说" ofType:@"txt"];
    if(![fileMag fileExistsAtPath:[DCBooksPath stringByAppendingPathComponent:@"龙王传说.txt"]])
    {
      [fileMag copyItemAtPath:filePath toPath:[DCBooksPath stringByAppendingPathComponent:@"龙王传说.txt"] error:nil];
      NSLog(@"filepath = %@ , topath = %@",filePath,[DCBooksPath stringByAppendingPathComponent:@"龙王传说.txt"]);
      [[NSNotificationCenter defaultCenter] postNotificationName:KreloadReadHistoryListDataNotification object:nil];
    }

  }];
  [self.view addSubview:button2];
  
  
  
  
  
  
  
}




/**
 打开一个网络小说  有加载 没有先缓存
 */
- (void)WebTxtBookjudgeFileExistWithUrl:(NSString *)urlOfBook {
  //创建下载进程
  NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
  AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
  NSString *bookurl =  [urlOfBook stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  NSString *fileName = [bookurl lastPathComponent]; //获取文件名称
  NSURL *URL = [NSURL URLWithString:bookurl];
  NSURLRequest *request = [NSURLRequest requestWithURL:URL];
  
  //判断是否存在
  if([DQMFileTools isFileExist:fileName]) {
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
    NSLog(@"文件存在 %@",url);
    //打开
    NSString *urlStr = [[url absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];//去除协议头
    [self openWebTxtBookWithUrl:urlStr];

    
  }
  else {
    
    //下载电子书
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.view.userInteractionEnabled = false;
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = @"下载书籍中..";
    hud.label.font = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.offset = CGPointMake(0, 0);
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:true];
    
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress){
      NSLog(@"下载进度 %@",downloadProgress);
//      hud.progress = downloadProgress.fractionCompleted;
      
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
      //下载的准备
      NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
      NSURL *url = [documentsDirectoryURL URLByAppendingPathComponent:fileName];
      NSLog(@"下载目的地  %@",url);
      return url;
      
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
      [hud hideAnimated:true];

      NSFileManager *fileMag = [NSFileManager defaultManager];
      //将下载的文件拷贝到指定的书本沙盒
        if(![fileMag fileExistsAtPath:[DCBooksPath stringByAppendingPathComponent:fileName]]) {
          NSString *urlStr = [[filePath absoluteString] stringByReplacingOccurrencesOfString:@"file://" withString:@""];//去除协议头
          [fileMag copyItemAtPath:urlStr toPath:[DCBooksPath stringByAppendingPathComponent:fileName] error:nil];
          NSLog(@"下载完成 拷贝完成 %@",urlStr);
          
          //打开电子书
          [self openWebTxtBookWithUrl:urlStr];

          [[NSNotificationCenter defaultCenter] postNotificationName:KreloadReadHistoryListDataNotification object:nil];
        }
      
    }];
    [downloadTask resume];
  }
}



/**
 打开书本
 */
- (void)openWebTxtBookWithUrl:(NSString *)url {
  NSArray *arr = [url componentsSeparatedByString:@"."];
  if ([arr count] == 2) {
    NSString *name = [[arr.firstObject componentsSeparatedByString:@"/"] lastObject];
    DQMReaderPageViewController *vc = [[DQMReaderPageViewController alloc]init];
    DQMReadHistory *historyModel = [[DQMReadHistory alloc] init];
    historyModel.name = name;
    historyModel.type = [arr lastObject];
    historyModel.path = url;
    vc.readHistoryModel = historyModel;
    [self.navigationController pushViewController:vc animated:YES];
  }
}



#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar
{
  return true;
}


@end
