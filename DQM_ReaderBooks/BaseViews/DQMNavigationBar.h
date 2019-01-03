//
//  DQMNavigationBar.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 自定义导航栏的Bar */
#import <UIKit/UIKit.h>

@class DQMNavigationBar;
// 主要处理导航条的代理事件
@protocol  DQMNavigationBarDataSource <NSObject>

@optional

/** 头部标题 */
- (NSMutableAttributedString*)dqmNavigationBarTitle:(DQMNavigationBar *)navigationBar;
/** 背景图片 */
- (UIImage *)dqmNavigationBarBackgroundImage:(DQMNavigationBar *)navigationBar;
/** 背景色 */
- (UIColor *)dqmNavigationBackgroundColor:(DQMNavigationBar *)navigationBar;
/** 是否显示底部黑线 */
- (BOOL)dqmNavigationIsHideBottomLine:(DQMNavigationBar *)navigationBar;
/** 导航条的高度 */
- (CGFloat)dqmNavigationHeight:(DQMNavigationBar *)navigationBar;


/** 导航条的左边的 view */
- (UIView *)dqmNavigationBarLeftView:(DQMNavigationBar *)navigationBar;
/** 导航条右边的 view */
- (UIView *)dqmNavigationBarRightView:(DQMNavigationBar *)navigationBar;
/** 导航条中间的 View */
- (UIView *)dqmNavigationBarTitleView:(DQMNavigationBar *)navigationBar;
/** 导航条左边的按钮 */
- (UIImage *)dqmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(DQMNavigationBar *)navigationBar;
/** 导航条右边的按钮 */
- (UIImage *)dqmNavigationBarRightButtonImage:(UIButton *)rightButton navigationBar:(DQMNavigationBar *)navigationBar;
@end


@protocol DQMNavigationBarDelegate <NSObject>

@optional
/** 左边的按钮的点击 */
-(void)leftButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar;
/** 右边的按钮的点击 */
-(void)rightButtonEvent:(UIButton *)sender navigationBar:(DQMNavigationBar *)navigationBar;
/** 中间如果是 label 就会有点击 */
-(void)titleClickEvent:(UILabel *)sender navigationBar:(DQMNavigationBar *)navigationBar;
@end


@interface DQMNavigationBar : UIView

/** 底部的黑线 */
@property (weak, nonatomic) UIView *bottomBlackLineView;

/** 标题 */
@property (weak, nonatomic) UIView *titleView;

/** 左边视图 */
@property (weak, nonatomic) UIView *leftView;

/** 右边视图 */
@property (weak, nonatomic) UIView *rightView;

/** 富文本顶部标题 */
@property (nonatomic, copy) NSMutableAttributedString *title;

/** 数据源 */
@property (weak, nonatomic) id<DQMNavigationBarDataSource> dataSource;

/** 数据代理 */
@property (weak, nonatomic) id<DQMNavigationBarDelegate> dqmDelegate;

/** 背景图片 */
@property (weak, nonatomic) UIImage *backgroundImage;

@end

