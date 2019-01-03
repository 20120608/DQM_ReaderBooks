//
//  UIView+DQMFrame.m
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "UIView+DQMFrame.h"

@implementation UIView (DQMFrame)
- (CGFloat)x
{
  return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
  CGRect rect = self.frame;
  rect.origin.x = x;
  self.frame = rect;
}

- (CGFloat)y
{
  return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
  CGRect rect = self.frame;
  rect.origin.y = y;
  self.frame = rect;
}

- (CGFloat)right {
  return self.frame.origin.x + self.frame.size.width;
}

- (void)setright:(CGFloat)right {
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}

- (CGFloat)bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setbottom:(CGFloat)bottom {
  
  CGRect frame = self.frame;
  
  frame.origin.y = bottom - frame.size.height;
  
  self.frame = frame;
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (void)setwidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (void)setheight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGFloat)centerX {
  return self.center.x;
}

- (void)setcenterX:(CGFloat)centerX {
  self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
  return self.center.y;
}

- (void)setcenterY:(CGFloat)centerY {
  self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
  return self.frame.origin;
}

- (void)setorigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGSize)size {
  return self.frame.size;
}

- (void)setsize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

@end
