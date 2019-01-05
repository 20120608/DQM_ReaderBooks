//
//  DQMNavigationBar.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMNavigationBar.h"

@implementation DQMNavigationBar

#pragma mark - system

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self setupDQMNavigationBarUIOnce];
  }
  return self;
}

- (void)awakeFromNib
{
  [super awakeFromNib];
  [self setupDQMNavigationBarUIOnce];
}



- (void)layoutSubviews
{
  [super layoutSubviews];
  
  [self.superview bringSubviewToFront:self];
  
  self.leftView.frame = CGRectMake(0, kStatusBarHeight, self.leftView.width, self.leftView.height);
  
  self.rightView.frame = CGRectMake(self.width - self.rightView.width, kStatusBarHeight, self.rightView.width, self.rightView.height);
  
  self.titleView.frame = CGRectMake(0, kStatusBarHeight + (44.0 - self.titleView.height) * 0.5, MIN(self.width - MAX(self.leftView.width, self.rightView.width) * 2 - kViewMargin * 2, self.titleView.width), self.titleView.height);
  
  self.titleView.x = (self.width * 0.5 - self.titleView.width * 0.5);
  
  self.bottomBlackLineView.frame = CGRectMake(0, self.height, self.width, 0.5);
  
}



#pragma mark - Setter
- (void)setTitleView:(UIView *)titleView
{
  [_titleView removeFromSuperview];
  [self addSubview:titleView];
  
  _titleView = titleView;
  
  __block BOOL isHaveTapGes = NO;
  
  [titleView.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
    if ([obj isKindOfClass:[UITapGestureRecognizer class]]) {
      
      isHaveTapGes = YES;
      
      *stop = YES;
    }
  }];
  
  if (!isHaveTapGes) {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick:)];
    
    [titleView addGestureRecognizer:tap];
  }
  
  
  [self layoutIfNeeded];
}




- (void)setTitle:(NSMutableAttributedString *)title
{
  // bug fix
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarTitleView:)] && [self.dataSource dqmNavigationBarTitleView:self]) {
    return;
  }
  
  /**头部标题*/
  UILabel *navTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width * 0.4, 44)];
  
  navTitleLabel.numberOfLines=0;//可能出现多行的标题
  [navTitleLabel setAttributedText:title];
  navTitleLabel.textAlignment = NSTextAlignmentCenter;
  navTitleLabel.backgroundColor = [UIColor clearColor];
  navTitleLabel.userInteractionEnabled = YES;
  navTitleLabel.lineBreakMode = NSLineBreakByClipping;
  
  self.titleView = navTitleLabel;
}


- (void)setLeftView:(UIView *)leftView
{
  [_leftView removeFromSuperview];
  
  [self addSubview:leftView];
  
  _leftView = leftView;
  
  
  if ([leftView isKindOfClass:[UIButton class]]) {
    
    UIButton *btn = (UIButton *)leftView;
    
    [btn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  [self layoutIfNeeded];
  
}


- (void)setBackgroundImage:(UIImage *)backgroundImage
{
  _backgroundImage = backgroundImage;
  
  self.layer.contents = (id)backgroundImage.CGImage;
}



- (void)setRightView:(UIView *)rightView
{
  [_rightView removeFromSuperview];
  
  [self addSubview:rightView];
  
  _rightView = rightView;
  
  if ([rightView isKindOfClass:[UIButton class]]) {
    
    UIButton *btn = (UIButton *)rightView;
    
    [btn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  }
  
  [self layoutIfNeeded];
}



- (void)setDataSource:(id<DQMNavigationBarDataSource>)dataSource
{
  _dataSource = dataSource;
  
  [self setupDataSourceUI];
}


#pragma mark - getter

- (UIView *)bottomBlackLineView
{
  if(!_bottomBlackLineView)
  {
    CGFloat height = 0.5;
    UIView *bottomBlackLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height , self.frame.size.width, height)];
    [self addSubview:bottomBlackLineView];
    _bottomBlackLineView = bottomBlackLineView;
    bottomBlackLineView.backgroundColor = [UIColor lightGrayColor];
  }
  return _bottomBlackLineView;
}

#pragma mark - event

- (void)leftBtnClick:(UIButton *)btn
{
  if ([self.dqmDelegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
    
    [self.dqmDelegate leftButtonEvent:btn navigationBar:self];
    
  }
  
}


- (void)rightBtnClick:(UIButton *)btn
{
  if ([self.dqmDelegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
    
    [self.dqmDelegate rightButtonEvent:btn navigationBar:self];
    
  }
  
}


-(void)titleClick:(UIGestureRecognizer*)Tap
{
  UILabel *view = (UILabel *)Tap.view;
  if ([self.dqmDelegate respondsToSelector:@selector(titleClickEvent:navigationBar:)]) {
    
    [self.dqmDelegate titleClickEvent:view navigationBar:self];
    
  }
}



#pragma mark - custom

- (void)setupDataSourceUI
{
  
  /** 导航条的高度 */
  
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationHeight:)]) {
    
    self.size = CGSizeMake(kScreenWidth, [self.dataSource dqmNavigationHeight:self]);
    
  }else
  {
    self.size = CGSizeMake(kScreenWidth, kDefaultNavBarHeight);
  }
  
  /** 是否显示底部黑线 */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationIsHideBottomLine:)]) {
    
    if ([self.dataSource dqmNavigationIsHideBottomLine:self]) {
      self.bottomBlackLineView.hidden = YES;
    }
    
  }
  
  /** 背景图片 */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarBackgroundImage:)]) {
    
    self.backgroundImage = [self.dataSource dqmNavigationBarBackgroundImage:self];
  }
  
  /** 背景色 */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBackgroundColor:)]) {
    self.backgroundColor = [self.dataSource dqmNavigationBackgroundColor:self];
  }
  
  
  /** 导航条中间的 View */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarTitleView:)]) {
    
    self.titleView = [self.dataSource dqmNavigationBarTitleView:self];
    
  }else if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarTitle:)])
  {
    /**头部标题*/
    self.title = [self.dataSource dqmNavigationBarTitle:self];
  }
  
  
  /** 导航条的左边的 view */
  /** 导航条左边的按钮 */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarLeftView:)]) {
    
    self.leftView = [self.dataSource dqmNavigationBarLeftView:self];
    
  }else if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarLeftButtonImage:navigationBar:)])
  {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kSmallTouchSizeHeight, kSmallTouchSizeHeight)];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIImage *image = [self.dataSource dqmNavigationBarLeftButtonImage:btn navigationBar:self];
    
    if (image) {
      [btn setImage:image forState:UIControlStateNormal];
    }
    
    self.leftView = btn;
  }
  
  /** 导航条右边的 view */
  /** 导航条右边的按钮 */
  if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarRightView:)]) {
    
    self.rightView = [self.dataSource dqmNavigationBarRightView:self];
    
  }else if ([self.dataSource respondsToSelector:@selector(dqmNavigationBarRightButtonImage:navigationBar:)])
  {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kLeftRightViewSizeMinWidth, kSmallTouchSizeHeight)];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UIImage *image = [self.dataSource dqmNavigationBarRightButtonImage:btn navigationBar:self];
    
    if (image) {
      [btn setImage:image forState:UIControlStateNormal];
    }
    
    self.rightView = btn;
  }
  
}


- (void)setupDQMNavigationBarUIOnce
{
  self.backgroundColor = [UIColor whiteColor];
}


@end












