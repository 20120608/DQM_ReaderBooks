//
//  DQMReadingHistoryFMDBManager.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/4.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMReadingHistoryFMDBManager.h"

@interface DQMReadingHistoryFMDBManager ()
{
  FMDatabase *_db;
  NSString *_txtPath;//沙盒地址
}
@end

@implementation DQMReadingHistoryFMDBManager

+ (instancetype)sharedInstance {
  static DQMReadingHistoryFMDBManager *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[self alloc] init];
  });
  return sharedInstance;
}


/**
 创建表 name文件名  path文件路径   type文件类型  currentIndex当前第几页  currentChapter当前第几章
 @return 创建结果
 */
- (BOOL)createReadHistoryFMDB {
  //AUTOINCREMENT 自增    PRIMARY KEY关键字
  BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS dqmReadHistory (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, path text NOT NULL, type text NOT NULL, currentChapter integer NOT NULL, currentIndex integer NOT NULL);"];
  if (result) {
    NSLog(@"创建表成功");
  } else {
    NSLog(@"创建表失败");
  }
  return result;
}

/**
 删除表
 */
- (BOOL)dropReadHistoryFMDB {
  //如果表格存在 则销毁
  BOOL result = [_db executeUpdate:@"drop table if exists dqmReadHistory"];
  if (result) {
    NSLog(@"删除表成功");
  } else {
    NSLog(@"删除表失败");
  }
  return result;
}




/**
 打开数据库
 @return 打开结果
 */
- (BOOL)openReadHistoryDB {
  //1.获取数据库文件的路径
  _txtPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
  NSLog(@"数据库地址: %@",_txtPath);
  //设置数据库名称
  NSString *fileName = [_txtPath stringByAppendingPathComponent:@"dqmReadHistory.sqlite"];
  //2.获取数据库
  _db = [FMDatabase databaseWithPath:fileName];
  if ([_db open]) {
    NSLog(@"打开数据库成功");
    return true;
  } else {
    NSLog(@"打开数据库失败");
    return false;
  }
}

/**
 插入数据
 @param historyModel 阅读的模型
 */
- (BOOL)insertDataToReadHistory:(DQMReadHistory *)historyModel {
  //插入数据
  //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
  BOOL result = [_db executeUpdate:@"INSERT INTO dqmReadHistory (name, path, type, currentIndex, currentChapter) VALUES (?,?,?)",historyModel.name, historyModel.path, historyModel.type, historyModel.currentIndex, historyModel.currentChapter];
  
  //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
  //    BOOL result = [_db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
  //3.参数是数组的使用方式
  //    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
  //4.可以在sex中插入一个空值，但是这里的空值不是nil，而是NSNull
  //  [_db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?,?,?)",name,@(age),[NSNull null]];

  if (result) {
    NSLog(@"插入成功");
  } else {
    NSLog(@"插入失败");
  }
  return result;
}

/**
 删除数据
 @param historyModel 阅读的模型
 */
- (BOOL)removeDataToReadHistory:(DQMReadHistory *)historyModel {
  //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
//  BOOL result = [_db executeUpdate:@"delete from t_student where id = ?",@(11)];
  //2.不确定的参数用%@，%d等来占位
  //BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
  
  BOOL result = [_db executeUpdateWithFormat:@"delete from dqmReadHistory where name = %@",historyModel.name];
  if (result) {
    NSLog(@"删除成功");
  } else {
    NSLog(@"删除失败");
  }
  return result;
}





/**
 修改数据
 @param historyModel 阅读的模型
 */
- (BOOL)updateDataToReadHistory:(DQMReadHistory *)historyModel {
  //eg: 修改学生的名字
  //  NSString *newName = @"李浩宇";
  //  NSString *oldName = @"王子涵2";
  //  BOOL result = [_db executeUpdate:@"update t_student set name = ? where name = ?",newName,oldName];
  
//1.
//  BOOL result = [_db executeUpdate:@"update dqmReadHistory set name = ?, path = ?, type = ?, currentIndex = ?, currentChapter = ?  where name = ?",historyModel.name,historyModel.path,historyModel.type,historyModel.currentIndex,historyModel.currentChapter,historyModel.name];
  
 //2.
  NSString *sql = [NSString stringWithFormat:@"update dqmReadHistory set name = ?, path = ?, type = ?, currentIndex = ?, currentChapter = ?  where name = ?"];
  BOOL result = [_db executeUpdate:sql withArgumentsInArray:@[historyModel.name,historyModel.path,historyModel.type,@(historyModel.currentIndex),@(historyModel.currentChapter),historyModel.name]];
  
  if (result) {
    NSLog(@"修改成功");
  } else {
    NSLog(@"修改失败");
  }
  return result;
}



/**
 查找数据
 @param historyModel 阅读的模型
 */
- (DQMReadHistory *)searchDataToReadHistory:(DQMReadHistory *)historyModel {
  //查询整个表
//  FMResultSet * resultSet = [_db executeQuery:@"select * from dqmReadHistory"];
  //根据条件查询
  //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
  //遍历结果集合
//  while ([resultSet next]) {
//    int idNum = [resultSet intForColumn:@"id"];
//    NSString *name = [resultSet objectForColumnName:@"name"];
//    int age = [resultSet intForColumn:@"age"];
//    NSString *sex = [resultSet objectForColumnName:@"sex"];
//    NSLog(@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex);
//  }
  
  FMResultSet * resultSet = [_db executeQuery:@"select * from dqmReadHistory where name = ?",historyModel.name];
    while ([resultSet next]) {
      int idNum = [resultSet intForColumn:@"id"];
      NSString *name = [resultSet objectForColumn:@"name"];
      NSString *path = [resultSet objectForColumn:@"path"];
      NSString *type = [resultSet objectForColumn:@"type"];
      NSInteger currentIndex = [resultSet intForColumn:@"currentIndex"];
      NSInteger currentChapter = [resultSet intForColumn:@"currentChapter"];
      NSLog(@"编号：%@ 名称：%@ 路径：%@ 类型：%@ 页数:%ld, 章节:%ld", @(idNum), name, path, type, currentIndex, currentChapter);
      
      DQMReadHistory *resultHistory = [[DQMReadHistory alloc] init];
      resultHistory.name = name;
       resultHistory.path = path;
       resultHistory.type = type;
       resultHistory.currentIndex = currentIndex;
       resultHistory.currentChapter = currentChapter;
      return resultHistory;
    }
  NSLog(@"查无数据");
  return nil;
}


@end
