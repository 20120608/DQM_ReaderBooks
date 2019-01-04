//
//  DQMReadingHistoryFMDBManager.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/4.
//  Copyright © 2019 漂读网. All rights reserved.
//

//管理读书的历史记录的FMDB操作类
#import <Foundation/Foundation.h>
#import "FMDatabase.h"  //数据库
#import "DQMReadHistory.h"//模型



NS_ASSUME_NONNULL_BEGIN

@interface DQMReadingHistoryFMDBManager : NSObject

/**
 单利
 */
+ (instancetype)sharedInstance;

/**
 创建表 name文件名  path文件路径   type文件类型  currentIndex当前第几页  currentChapter当前第几章
 @return 创建结果
 */
- (BOOL)createReadHistoryFMDB;

/**
 删除表
 */
- (BOOL)dropReadHistoryFMDB;


/**
 打开数据库
 @return 打开结果
 */
- (BOOL)openReadHistoryDB;

/**
 插入数据
 @param historyModel 阅读的模型
 */
- (BOOL)insertDataToReadHistory:(DQMReadHistory *)historyModel;


/**
 删除数据
 @param historyModel 阅读的模型
 */
- (BOOL)removeDataToReadHistory:(DQMReadHistory *)historyModel;


/**
 修改数据
 @param historyModel 阅读的模型
 */
- (BOOL)updateDataToReadHistory:(DQMReadHistory *)historyModel;

/**
 查找数据
 @param historyModel 阅读的模型
 */
- (DQMReadHistory *)searchDataToReadHistory:(DQMReadHistory *)historyModel;





@end

NS_ASSUME_NONNULL_END
