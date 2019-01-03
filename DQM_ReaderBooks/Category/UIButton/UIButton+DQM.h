//
//  UIButton+DQM.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchedBlock)(NSInteger tag);

@interface UIButton (DQM)

/**
 添加 addtarget
 */
- (void)addActionHandler:(TouchedBlock)touchHandler;

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

/*
 *  @brief
 *
 *  @param frame         frame
 *  @param buttonTitle   标题
 *  @param normalBGColor 未选中的背景色
 *  @param selectBGColor 选中的背景色
 *  @param normalColor   未选中的文字色
 *  @param selectColor   选中的文字色
 *  @param buttonFont    文字字体
 *  @param cornerRadius  圆角值 没有则为0
 *  @param doneBlock     点击事件
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor
                  normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat )cornerRadius
                    doneBlock:(void(^)(UIButton *sender))doneBlock;


+ (UIButton *)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle normalBGColor:(UIColor *)normalBGColor selectBGColor:(UIColor *)selectBGColor
                normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor buttonFont:(UIFont *)buttonFont cornerRadius:(CGFloat )cornerRadius
                  doneBlock:(void(^)(UIButton *sender))doneBlock;



- (instancetype)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle
                  normalColor:(UIColor *)normalColor cornerRadius:(CGFloat )cornerRadius
                    doneBlock:(void(^)(UIButton *sender))doneBlock;


+ (UIButton *)initWithFrame:(CGRect)frame buttonTitle:(NSString *)buttonTitle
                normalColor:(UIColor *)normalColor cornerRadius:(CGFloat )cornerRadius
                  doneBlock:(void(^)(UIButton *sender))doneBlock;



@end


//
//  Created by Alberto Pasca on 27/02/14.
//  Copyright (c) 2014 albertopasca.it. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface APRoundedButton : UIButton

@property (nonatomic, assign) IBInspectable NSUInteger style;
@property (nonatomic, assign) IBInspectable CGFloat nj_cornerRaduous;

@end
