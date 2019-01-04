//
//  DQMFileTools.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//小说阅读器文件管理类
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMFileTools : NSObject

/**
 获取文件路径
 */
+ (NSString *)getDocumentPath;

/**
 获取缓存路径
 */
+ (NSString *)getCachePath;

/**
 获取临时路径
 */
+ (NSString *)getTmpPath;

/**创建根目录*/
+ (BOOL )creatRootDirectory;

/**根据文件路径，解析文件,utf8,GKB,GBK18030*/
+ (NSString *)transcodingWithPath:(NSString *)path;

/**从字符串中查找要找字符的位置（所有字符）*/
+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText;

/**获取书籍目录列表*/
+ (NSMutableArray *)getBookListWithText:(NSString *)text;

/**将文件按章节分割*/
+ (NSMutableArray *)getChapterArrWithString:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
