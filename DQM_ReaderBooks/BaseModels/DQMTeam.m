//
//  DQMTeam.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMTeam.h"

@implementation DQMTeam

+ (instancetype)initTeamWithName:(NSString *)name sortNumber:(NSString *)sortNumber destVc:(Class)destVc extensionDictionary:(NSDictionary *)extensionDictionary {
  DQMTeam *item = [[self alloc] init];
  item.name = name;
  item.sortNumber = sortNumber;
  item.destVc = destVc;
  if (extensionDictionary != nil) {
    item.extensionDictionary = extensionDictionary;
  } else {
    item.extensionDictionary = [NSMutableDictionary new];
  }
  
  return item;
}

@end
