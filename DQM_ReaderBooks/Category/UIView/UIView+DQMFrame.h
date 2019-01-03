//
//  UIView+DQMFrame.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//


/** 视图类扩展 带上frame的参数 */
#import <UIKit/UIKit.h>

@interface UIView (DQMFrame)

@property (nonatomic, assign) CGFloat height;   ///< Shortcut for frame.size.height.
@property (nonatomic, assign) CGFloat width;    ///< Shortcut for frame.size.width.
@property (nonatomic, assign) CGFloat x;        ///< Shortcut for frame.origin.x.
@property (nonatomic, assign) CGFloat y;        ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;            ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;           ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat centerX;          ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;          ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;           ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;             ///< Shortcut for frame.size.



@end
