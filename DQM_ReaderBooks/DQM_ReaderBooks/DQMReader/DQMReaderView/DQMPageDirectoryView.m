//
//  DQMPageDirectoryView.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMPageDirectoryView.h"

@interface DQMPageDirectoryView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel        *headerView;

@end


static NSString *const cellKey = @"cellKey";

@implementation DQMPageDirectoryView
#pragma mark  - life cycle
-(instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
    [self setupUI];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.backView addGestureRecognizer:tap];
  }
  return self;
}
-(void)layoutSubviews
{
  [super layoutSubviews];
  self.backgroundColor = [UIColor clearColor];
  self.headerView.frame = CGRectMake(0, 0, kScreenWidth*0.75, 80);
  self.tableView.frame = CGRectMake(-kScreenWidth*0.75, 0, kScreenWidth*0.75, kScreenHeight);
}
#pragma mark  - event

-(void)tap:(UITapGestureRecognizer *)tap
{
  self.backView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.8];
  [UIView animateWithDuration:0.3 animations:^{
    self.tableView.frame = CGRectMake(-kScreenWidth*0.75, 0, kScreenWidth*0.75, kScreenHeight);
    self.backView.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:0.01];
  }completion:^(BOOL finished) {
    self.hidden = YES;
  }];
}
#pragma mark  - delegate


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if([self.delegate respondsToSelector:@selector(bookListView:didSelectRowAtIndex:)])
  {
    [self.delegate bookListView:self didSelectRowAtIndex:indexPath.row];
  }
  [self tap:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellKey];
  if(!cell)
  {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellKey];
  }
  cell.textLabel.font = AdaptedFontSize(15);
  cell.textLabel.textColor = QMTextColor;
  cell.textLabel.text = self.list[indexPath.row];
  cell.backgroundColor = [UIColor colorWithRed:250/255.0 green:244/255.0 blue:233/255.0 alpha:1];
  return cell;
}

#pragma mark  - private
-(void)setupUI
{
  [self addSubview:self.backView];
  [self addSubview:self.tableView];
  self.tableView.tableHeaderView = self.headerView;
}

#pragma mark  - public

#pragma mark  - setter or getter
-(void)setList:(NSArray *)list
{
  _list = list;
  [self.tableView reloadData];
}
-(UITableView *)tableView
{
  if(_tableView == nil)
  {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = [UIColor colorWithRed:250/255.0 green:244/255.0 blue:233/255.0 alpha:1];

  }
  return _tableView;
}

-(UILabel *)headerView
{
  if(_headerView == nil)
  {
    _headerView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.75, 80)];
    _headerView.backgroundColor = [UIColor colorWithRed:250/255.0 green:244/255.0 blue:233/255.0 alpha:1];
    _headerView.text = @"    目录";
    _headerView.font = AdaptedBoldFont(20);
    _headerView.textColor = QMTextColor;
  }
  return _headerView;
}
-(UIView *)backView
{
  if(_backView == nil)
  {
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  }
  return _backView;
}

@end

