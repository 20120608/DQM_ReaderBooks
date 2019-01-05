//
//  DQMFileTools.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMFileTools.h"

@implementation DQMFileTools

+(NSString *)getDocumentPath
{
  return  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}
+(NSString *)getCachePath
{
  return  NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}
+(NSString *)getTmpPath
{
  return  NSTemporaryDirectory();
}
+(BOOL )creatRootDirectory
{
  NSFileManager *fileMag = [NSFileManager defaultManager];
  BOOL isDir = YES;
  if(![fileMag fileExistsAtPath:DCBooksPath isDirectory:&isDir])
  {
    //如果没有则创建文件夹
    [fileMag createDirectoryAtPath:DCBooksPath withIntermediateDirectories:YES attributes:nil error:nil];
  }
  return YES;
}

/** 判断文件是否已经在沙盒中存在 */
+ (BOOL)isFileExist:(NSString *)fileName
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *path = [paths objectAtIndex:0];
  NSString *filePath = [path stringByAppendingPathComponent:fileName];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  BOOL result = [fileManager fileExistsAtPath:filePath];
  return result;
}

+(NSString *)transcodingWithPath:(NSString *)path
{
  NSURL *fileUrl = [NSURL fileURLWithPath:path];
  NSStringEncoding * usedEncoding = nil;
  //带编码头的如 utf-8等 这里会识别
  NSString *body = [NSString stringWithContentsOfURL:fileUrl usedEncoding:usedEncoding error:nil];
  if(body)
  {
    return body;
  }
  //如果之前不能解码，现在使用GBK解码
  NSLog(@"GBK");
  body = [NSString stringWithContentsOfURL:fileUrl encoding:0x80000632 error:nil];
  if (body)
  {
    return body;
  }
  
  //再使用GB18030解码
  NSLog(@"GBK18030");
  body = [NSString stringWithContentsOfURL:fileUrl encoding:0x80000631 error:nil];
  if(body)
  {
    return body;
  }else
  {
    return nil;
  }
}

#pragma mark - 获取这个字符串text中的所有findText的所在的NSRange
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
  NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:3];
  if (findText == nil && [findText isEqualToString:@""])
  {
    return nil;
  }
  NSRange rang = [text rangeOfString:findText options:NSRegularExpressionSearch];
  if (rang.location != NSNotFound && rang.length != 0)
  {
    [arrayRanges addObject:[NSValue valueWithRange:rang]];
    NSRange rang1 = {0,0};
    NSInteger location = 0;
    NSInteger length = 0;
    for (int i = 0;; i++)
    {
      if (0 == i)
      {
        //去掉这个abc字符串
        location = rang.location + rang.length;
        length = text.length - rang.location - rang.length;
        rang1 = NSMakeRange(location, length);
      }
      else
      {
        location = rang1.location + rang1.length;
        length = text.length - rang1.location - rang1.length;
        rang1 = NSMakeRange(location, length);
      }
      //在一个range范围内查找另一个字符串的range
      rang1 = [text rangeOfString:findText options:NSRegularExpressionSearch range:rang1];
      
      if (rang1.location == NSNotFound && rang1.length == 0)
      {
        break;
      }
      else//添加符合条件的location进数组
        [arrayRanges addObject:[NSValue valueWithRange:rang1]];
      
    }
    return arrayRanges;
  }
  return nil;
}

//这正表达式匹配章节目录列表
+(NSMutableArray *)getBookListWithText:(NSString *)text
{
  NSMutableArray *marr = [DQMFileTools getRangeStr:text findText:@"\r\n第.{1,}章.*\r\n"];
  NSMutableArray *strMarr = [NSMutableArray array];
  [strMarr addObject:@"开始"];
  for (int i = 0; i<marr.count; i++) {
    NSValue *value = marr[i];
    NSString *string = [text substringWithRange:value.rangeValue];
    string = [string stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    [strMarr addObject:string];
  }
  return strMarr;
}



+(NSMutableArray *)getChapterArrWithString:(NSString *)text
{
  NSMutableArray *marr = [DQMFileTools getRangeStr:text findText:@"\r\n第.{1,}章.*\r\n"];
  NSMutableArray *strMarr = [NSMutableArray array];
  NSRange lastRange = NSMakeRange(0, 0);
  for (int i = 0; i<marr.count; i++) {
    NSValue *value = marr[i];
    NSString *string = [text substringWithRange:NSMakeRange(lastRange.location, value.rangeValue.location - lastRange.location)];
    lastRange = value.rangeValue;
    if([string isEqualToString:@""])
    {
      string = @"\r\n";
    }
    [strMarr addObject:string];
  }
  //最后一章到结尾
  NSString *string = [text substringFromIndex:lastRange.location];
  if([string isEqualToString:@""])
  {
    string = @"\r\n";
  }
  [strMarr addObject:string];
  return strMarr;
}


@end
