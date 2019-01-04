//
//  DQMReadHistory.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/4.
//  Copyright © 2019 漂读网. All rights reserved.
//

//用来缓存读书的状态
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMReadHistory : NSObject

@property (nonatomic,copy   ) NSString  *name;//文件名
@property (nonatomic,copy   ) NSString  *path;//文件路径
@property (nonatomic,copy   ) NSString  *type;//文件类型
@property (nonatomic,copy   ) NSString  *textFontSize;//字体大小
@property (nonatomic,assign ) NSInteger currentIndex;//当前第几页
@property (nonatomic,assign ) NSInteger currentChapter;//当前第几章章


@end

NS_ASSUME_NONNULL_END
