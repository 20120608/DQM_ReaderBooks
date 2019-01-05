//
//  DQMFoldingTableViewController.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMFoldingTableViewController.h"
#import "DQMListExpendHeaderView.h"


@interface DQMFoldingTableViewController ()

@end

@implementation DQMFoldingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  
}


#pragma mark - UITableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.groups.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // 关键
  return self.groups[section].isOpened ? self.groups[section].teams.count : 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return self.groups[section].name;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *const ID = @"team";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
  
  if (!cell) {
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
  }
  
  cell.detailTextLabel.text = self.groups[indexPath.section].teams[indexPath.row].sortNumber;
  cell.textLabel.text = self.groups[indexPath.section].teams[indexPath.row].name;
  
  return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  DQMListExpendHeaderView *headerView = [DQMListExpendHeaderView headerViewWithTableView:tableView];
  headerView.backgroundView.backgroundColor = QMHexColor(@"d6d6d6");
  headerView.group = self.groups[section];
  QMWeak(self);
  [headerView setSelectGroup:^BOOL{
    
    weakself.groups[section].isOpened = !weakself.groups[section].isOpened;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    return weakself.groups[section].isOpened;
  }];
  
  return headerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 44;
}


#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.groups[indexPath.section].teams[indexPath.row].destVc) {
    DQMBaseViewController *vc = [[self.groups[indexPath.section].teams[indexPath.row].destVc alloc] initWithTitle:self.groups[indexPath.section].teams[indexPath.row].name];
    if ([vc isKindOfClass:[DQMBaseViewController class]]) {
     
      [self.navigationController pushViewController:vc animated:true];
    }
  }
}



#pragma mark - dataSource
- (NSMutableArray<DQMGroup *> *)groups
{
  if (_groups == nil) {
    _groups = [NSMutableArray array];
  }
  return _groups;
}




#pragma mark - 用点语法添加每组每单元的数据
-(DQMFoldingTableViewController *(^)(DQMTeam *item, NSString *name, int section))addItem {
  QMWeak(self);
  return  ^DQMFoldingTableViewController *(DQMTeam *item, NSString *name, int section) {
    if (weakself.groups.count <= section) {
      DQMGroup *group = [DQMGroup sectionWithItems:@[] andHeaderTitle:@"组头" footerTitle:@"组尾" name:name];
      group.isOpened = weakself.defaultOpen;
      [weakself.groups addObject:group];
    }
    [weakself.groups[section].teams addObject:item];
    return weakself;
  };
}



@end
