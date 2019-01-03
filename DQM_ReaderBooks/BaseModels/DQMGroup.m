//
//  DQMGroup.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMGroup.h"
#import "DQMTeam.h"

@implementation DQMGroup

+ (NSDictionary *)mj_objectClassInArray
{
  return @{@"teams" : [DQMTeam class]};
}



- (NSMutableArray<DQMTeam *> *)teams
{
  if(_teams == nil)
  {
    _teams = [NSMutableArray array];
  }
  return _teams;
}


+ (instancetype)sectionWithItems:(NSArray<DQMTeam *> *)teams andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle name:(NSString *)name
{
  DQMGroup *item = [[self alloc] init];
  item.name = name;
  item.isOpened = true;//默认展开
  if (teams.count) {
    [item.teams addObjectsFromArray:teams];
  }
  
  item.headerTitle = headerTitle;
  item.footerTitle = footerTitle;
  
  return item;
}


@end
