//
//  UIColor+HexString.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/4.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "UIColor+HexString.h"

@implementation UIColor (HexString)
//绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr {
  //CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
  CAGradientLayer *gradientLayer = [CAGradientLayer layer];
  gradientLayer.frame = view.bounds;
  
  //  创建渐变色数组，需要转换为CGColor颜色
  gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:fromHexColorStr].CGColor,(__bridge id)[UIColor colorWithHexString:toHexColorStr].CGColor];
  
  //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
  gradientLayer.startPoint = CGPointMake(0.5, 0);
  gradientLayer.endPoint = CGPointMake(0.5, 1);
  
  //  设置颜色变化点，取值范围 0.0~1.0
  gradientLayer.locations = @[@0,@1];
  
  return gradientLayer;
  
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
  //删除字符串中的空格
  NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  // String should be 6 or 8 characters
  if ([cString length] < 6)
  {
    return [UIColor clearColor];
  }
  // strip 0X if it appears
  //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
  if ([cString hasPrefix:@"0X"])
  {
    cString = [cString substringFromIndex:2];
  }
  //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
  if ([cString hasPrefix:@"#"])
  {
    cString = [cString substringFromIndex:1];
  }
  if ([cString length] != 6)
  {
    return [UIColor clearColor];
  }
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  //r
  NSString *rString = [cString substringWithRange:range];
  //g
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  //b
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  // Scan values
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
  return [self colorWithHexString:color alpha:1.0f];
}

@end
