//
//  DQMPageTopView.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMPageTopView.h"

@interface DQMPageTopView()
@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation DQMPageTopView

-(instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
    self.backgroundColor = [UIColor darkGrayColor];
    [self setupUI];
  }
  return self;
}
-(void)layoutSubviews
{
  [super layoutSubviews];
  
  [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(10);
    make.bottom.mas_equalTo(-10);
    make.size.mas_equalTo(CGSizeMake(30, 30));
  }];
  
}
-(void)setupUI
{
  [self addSubview:self.backBtn];
}

-(void)back
{
  if([self.delegate respondsToSelector:@selector(backInDCPageTopView:)])
  {
    [self.delegate backInDCPageTopView:self];
  }
}
-(UIButton *)backBtn
{
  if(_backBtn == nil)
  {
    _backBtn = [[UIButton alloc]init];
    [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  }
  return _backBtn;
}
@end
