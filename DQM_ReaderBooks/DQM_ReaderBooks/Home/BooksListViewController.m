//
//  BooksListViewController.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "BooksListViewController.h"
#import "DCBookModel.h"                           //书本模型
#import "DQMReadHistory.h"
#import "DQMReaderPageViewController.h"


@interface BooksListViewController ()

@property (nonatomic,strong) NSMutableArray<DCBookModel *> *books;           //书本列表

@end

@implementation BooksListViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:KreloadReadHistoryListDataNotification object:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
  [self loadData];
}

#pragma mark - reload data
- (void)loadData {
  
  [self.sections removeAllObjects];
  //获取文件夹中的所有文件
  NSArray *fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:DCBooksPath error:nil];
  NSMutableArray *bookArr = [[NSMutableArray alloc] init];
  for (NSString *file in fileArr) {
    DCBookModel *book = [[DCBookModel alloc]init];
    book.path = [DCBooksPath stringByAppendingPathComponent:file];
    NSArray *arr = [file componentsSeparatedByString:@"."];
    book.name = arr.firstObject;
    book.type = arr.lastObject;
    [bookArr addObject:book];
    self.addItem([StaticListItem itemAdditionalExtensionWithTitle:book.name subTitle:book.type extensionDictionary:nil itemOperation:nil]);
  }
  self.books = [NSMutableArray arrayWithArray:bookArr];
  
  if (![_books count]) {
    [self.view makeToast:@"请到下载新书页面添加书本"];
  }
  
  [self.tableView reloadData];
  
}





#pragma mark - uiTabelView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  DCBookModel *book = self.books[indexPath.row];
  DQMReaderPageViewController *vc = [[DQMReaderPageViewController alloc] init];
  DQMReadHistory *historyModel = [[DQMReadHistory alloc] init];
  historyModel.name = book.name;
  historyModel.type = book.type;
  historyModel.path = book.path;
  vc.readHistoryModel = historyModel;
  [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - dqm_navibar
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar
{
  return true;
}


@end
