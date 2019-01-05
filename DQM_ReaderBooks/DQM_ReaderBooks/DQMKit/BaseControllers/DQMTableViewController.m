//
//  DQMTableViewController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMTableViewController.h"
#import "DQMAutoRefreshFooter.h"

@interface DQMTableViewController ()
/** UITableViewStyle */
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@end

@implementation DQMTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  [self setupBaseTableViewUI];
}

- (void)setupBaseTableViewUI
{
  self.tableView.backgroundColor = self.view.backgroundColor;
  if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top += self.dqm_navgationBar.height;
    self.tableView.contentInset = contentInset;
  }
  
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  
  if (@available(iOS 11.0, *)) {
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  }
}

#pragma mark - scrollDeleggate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  UIEdgeInsets contentInset = self.tableView.contentInset;
  contentInset.bottom -= self.tableView.mj_footer.height;
  self.tableView.scrollIndicatorInsets = contentInset;
  [self.view endEditing:YES];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return [UITableViewCell new];
}

- (UITableView *)tableView
{
  if(_tableView == nil)
  {
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    [self.view addSubview:tableView];
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 44;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tableView = tableView;
  }
  return _tableView;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
  if (self = [super init]) {
    _tableViewStyle = style;
  }
  return self;
}

- (void)dealloc {
  
}

@end
