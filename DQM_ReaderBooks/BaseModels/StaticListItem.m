//
//  StaticListItem.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "StaticListItem.h"

@implementation StaticListItem

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
  StaticListItem *item = [[self alloc] init];
  item.subTitle = subTitle;
  item.title = title;
  return item;
}

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
  StaticListItem *item = [self itemWithTitle:title subTitle:subTitle];
  item.itemOperation = itemOperation;
  return item;
}

/** 带点击事件 返回一个cell 还能带上是否展示箭头 */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle accessoryType:(UITableViewCellAccessoryType)accessoryType itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
  StaticListItem *item = [self itemWithTitle:title subTitle:subTitle itemOperation:itemOperation];
  item.itemOperation = itemOperation;
  item.accessoryType = accessoryType;
  return item;
}

/** 带点击事件 返回一个cell 可以输入一个固定的高度 */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle fixedCellHeight:(CGFloat)fixedCellHeight itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation {
  StaticListItem *item = [self itemWithTitle:title subTitle:subTitle];
  item.itemOperation = itemOperation;
  item.fixedCellHeight = fixedCellHeight;
  return item;
}


- (instancetype)init
{
  if (self = [super init]) {
    _titleColor = [UIColor blackColor];
    _subTitleColor = [UIColor blackColor];
    _titleFont = AdaptedFontSize(16);
    _subTitleFont = AdaptedFontSize(16);
    _subTitleNumberOfLines = 2;
  }
  return self;
}

- (CGFloat)fixedCellHeight {
  if (!_fixedCellHeight) {
    _fixedCellHeight = 0;
  }
  return _fixedCellHeight;
}


@end
