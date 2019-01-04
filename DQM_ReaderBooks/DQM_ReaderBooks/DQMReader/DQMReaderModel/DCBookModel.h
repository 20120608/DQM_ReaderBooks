//
//  DCBookModel.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//小说阅读器书本模型  DCBooks  github
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCBookModel : NSObject

@property (nonatomic,copy) NSString *name;//文件名
@property (nonatomic,copy) NSString *path;//文件路径
@property (nonatomic,copy) NSString *type;//文件类型

@end

NS_ASSUME_NONNULL_END
