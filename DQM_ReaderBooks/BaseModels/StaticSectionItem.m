//
//  StaticSectionItem.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "StaticSectionItem.h"

@implementation StaticSectionItem

+ (instancetype)sectionWithItems:(NSArray<StaticListItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle
{
  StaticSectionItem *item = [[self alloc] init];
  if (items.count) {
    [item.items addObjectsFromArray:items];
  }
  
  item.headerTitle = headerTitle;
  item.footerTitle = footerTitle;
  
  return item;
}

- (NSMutableArray<StaticListItem *> *)items
{
  if(!_items)
  {
    _items = [NSMutableArray array];
  }
  return _items;
}

@end
