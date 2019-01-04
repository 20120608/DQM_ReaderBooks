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
#import "DQMReaderPageViewController.h"           //小说阅读器的详情页 需要filePath初始化

@interface BooksListViewController ()

@property (nonatomic,strong) NSArray<DCBookModel *> *books;           //书本列表

@end

@implementation BooksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
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
  self.books = [NSArray arrayWithArray:bookArr];
  [self.tableView reloadData];
  
}


#pragma mark - uiTabelView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  DCBookModel *book = self.books[indexPath.row];
  DQMReaderPageViewController *vc = [[DQMReaderPageViewController alloc]init];
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
