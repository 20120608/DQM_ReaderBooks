//
//  QMSGeneralHelpers.m
//  QM_EnlargementHeaderTableView
//
//  Created by 漂读网 on 2018/12/20.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "QMSGeneralHelpers.h"

//闪光灯用到的
#import <AVFoundation/AVFoundation.h>
#import <ImageIO/ImageIO.h>


@implementation QMSGeneralHelpers


//获取单利
+(instancetype)shareInstance
{
  static QMSGeneralHelpers *helpers = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    helpers = [[self alloc] init];
    
  });
  return helpers;
}





/**
 由NSString 转成带颜色字体大小的 NSMutableAttributedString

 @param curTitle 文字
 @param font 字体大小
 @param rangeOfFont 字体大小范围
 @param color 文字颜色
 @param colorOfFont 文字颜色范围
 @return 带颜色字体大小的富文本 NSMutableAttributedString
 */
+ (NSMutableAttributedString *)changeStringToMutableAttributedStringTitle:(NSString *)curTitle font:(UIFont *)font rangeOfFont:(NSRange)rangeOfFont color:(UIColor *)color rangeOfColor:(NSRange)rangeOfColor
{
  NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:curTitle ?: @""];
  [title addAttribute:NSForegroundColorAttributeName value:color range:rangeOfColor];
  [title addAttribute:NSFontAttributeName value:font range:rangeOfFont];
  return title;
}









/** 开或关 闪光灯 */
+ (BOOL)modifyFlashLight {
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  //修改前必须先锁定
  [device lockForConfiguration:nil];
  //必须判定是否有闪光灯，否则如果没有闪光灯会崩溃
  BOOL isopen = false;
  if ([device hasFlash]) {
    if (device.flashMode == AVCaptureFlashModeOff) {
      device.flashMode = AVCaptureFlashModeOn;
      device.torchMode = AVCaptureTorchModeOn;
      isopen = true;
    } else if (device.flashMode == AVCaptureFlashModeOn) {
      device.flashMode = AVCaptureFlashModeOff;
      device.torchMode = AVCaptureTorchModeOff;
      isopen = false;
    }
  }
  [device unlockForConfiguration];
  return isopen;
}








/**
 从bundle中取出图片

 @param imageName 图片名称
 @param bundleName 哪个bundle文件的文件名
 @return UIImage
 */
- (UIImage *)imageWithName:(NSString *)imageName bundle:(NSString *)bundleName {
  
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
  NSBundle *imageBundle = [NSBundle bundleWithURL:url];
  
  NSString *fileName = [NSString stringWithFormat:@"%@@2x", imageName];
  NSString *path = [imageBundle pathForResource:fileName ofType:@"png"];
  
  return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  
}






/**
 将View生成Image
 
 @param view 要生成图片的视图
 @return 图片
 */
+ (UIImage *)imageWithCaputureView:(UIView *)view
{
  // 开启位图上下文
  UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
  
  // 获取上下文
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  
  // 把控件上的图层渲染到上下文,layer只能渲染
  [view.layer renderInContext:ctx];
  
  // 生成一张图片
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  
  // 关闭上下文
  UIGraphicsEndImageContext();
  
  return image;
}


@end
