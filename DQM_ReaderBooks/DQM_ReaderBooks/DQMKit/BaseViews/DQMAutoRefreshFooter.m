//
//  DQMAutoRefreshFooter.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMAutoRefreshFooter.h"

@implementation DQMAutoRefreshFooter

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setupUIOnce];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setupUIOnce];
}

- (void)setupUIOnce
{
  self.automaticallyChangeAlpha = YES;
}

- (void)endRefreshing {
  [super endRefreshing];
  self.state = MJRefreshStateIdle;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
}

@end
