//
//  DQMStaticTableViewController.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMStaticTableViewController.h"
#import "StaticListTableViewCell.h"

const UIEdgeInsets tableViewDefaultSeparatorInset = {0, 15, 0, 0};
const UIEdgeInsets tableViewDefaultLayoutMargins = {8, 8, 8, 8};

@interface DQMStaticTableViewController ()

@end

@implementation DQMStaticTableViewController


- (void)viewDidLoad
{
  [super viewDidLoad];
  
  NSLog(@"self.tableView.separatorInset = %@, self.tableView.separatorInset = %@", NSStringFromUIEdgeInsets(self.tableView.separatorInset), NSStringFromUIEdgeInsets(self.tableView.layoutMargins));
  //    self.tableView.separatorInset = UIEdgeInsetsZero;
  //    self.tableView.layoutMargins = UIEdgeInsetsZero;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.sections[section].items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  StaticListItem *item = self.sections[indexPath.section].items[indexPath.row];
  if (item.fixedCellHeight) {
    return item.fixedCellHeight;
  }
  return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  StaticListItem *item = self.sections[indexPath.section].items[indexPath.row];
  StaticListTableViewCell *cell = [StaticListTableViewCell cellWithTableView:tableView andCellStyle:UITableViewCellStyleValue1];
  cell.item = item;
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  StaticListItem *item = self.sections[indexPath.section].items[indexPath.row];
  
  //点击事件返回
  if(item.itemOperation)
  {
    item.itemOperation(indexPath);
  }
  
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return self.sections[section].headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  return self.sections[section].footerTitle;
}

- (NSMutableArray<StaticSectionItem *> *)sections
{
  if(_sections == nil)
  {
    _sections = [NSMutableArray array];
  }
  return _sections;
}

- (DQMStaticTableViewController *(^)(StaticListItem *))addItem {
  
  QMWeak(self);
  if (!self.sections.firstObject) {
    [self.sections addObject:[StaticSectionItem sectionWithItems:@[] andHeaderTitle:nil footerTitle:nil]];
  }
  return  ^DQMStaticTableViewController *(StaticListItem *item) {
    [weakself.sections.firstObject.items addObject:item];
    return weakself;
  };
}

- (instancetype)init
{
  return [super initWithStyle:UITableViewStyleGrouped];
}


@end
