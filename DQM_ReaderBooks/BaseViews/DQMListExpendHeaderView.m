//
//  DQMListExpendHeaderView.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMListExpendHeaderView.h"
#import "DQMGroup.h"

@interface DQMListExpendHeaderView ()

/** 头部文本 */
@property (weak, nonatomic) UILabel *headerLabel;

/** 箭头类型的按钮 */
@property (weak, nonatomic) UIButton *indicatorButton;

@end

@implementation DQMListExpendHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
  DQMListExpendHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
  
  if (!headerView) {
    headerView = [[self alloc] initWithReuseIdentifier: NSStringFromClass(self)];
  }
  return headerView;
  
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithReuseIdentifier:reuseIdentifier];
  
  if (!self) {
    return self;
  }
  
  [self setupOnce];
  
  return self;
}


- (void)awakeFromNib
{
  [super awakeFromNib];
  
  [self setupOnce];
}


- (void)setupOnce
{
  self.backgroundView = ({
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor whiteColor];
    view;
  });
  [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
  }];
  
  [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.left.mas_offset(10);
    make.top.bottom.mas_offset(0);
  }];
  
  [self.indicatorButton mas_makeConstraints:^(MASConstraintMaker *make) {
    
    make.right.top.bottom.offset(0);
    make.width.mas_equalTo(60);
  }];
}

- (UILabel *)headerLabel
{
  if(_headerLabel == nil)
  {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:label];
    
    _headerLabel = label;
  }
  return _headerLabel;
}


- (UIButton *)indicatorButton
{
  if(_indicatorButton == nil)
  {
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setImage:[UIImage imageNamed:@"arrow_down_icon"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:btn];
    
    QMWeak(self);
    
    [btn addActionHandler:^(NSInteger tag) {
      
      if (weakself.selectGroup) {
        weakself.selectGroup();
      }
      
      if (weakself.group.isOpened) {
        [UIView animateWithDuration:0.3 animations:^{
          weakself.indicatorButton.imageView.transform = CGAffineTransformIdentity;
        }];
        
      }else
      {
        [UIView animateWithDuration:0.3 animations:^{
          weakself.indicatorButton.imageView.transform = CGAffineTransformMakeRotation(kDegreesToRadian(180.0));
        }];
      }
    }];
    
    _indicatorButton = btn;
  }
  return _indicatorButton;
}

- (void)setGroup:(DQMGroup *)group
{
  _group = group;
  
  
  self.textLabel.text = group.name;
  
  if (group.isOpened) {
    
    self.indicatorButton.imageView.transform = CGAffineTransformIdentity;
    
  }else
  {
    
    self.indicatorButton.imageView.transform = CGAffineTransformMakeRotation(kDegreesToRadian(180.0));
    
  }
}

@end

