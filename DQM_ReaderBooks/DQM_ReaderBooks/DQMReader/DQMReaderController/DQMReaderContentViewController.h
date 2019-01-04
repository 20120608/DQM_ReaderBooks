//
//  DQMReaderContentViewController.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//实际用于显示文字的控制器 带有百分比和页数进度
#import "DQMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DQMReaderContentViewController : DQMBaseViewController


@property (nonatomic,assign ) NSInteger                      currentIndex;//当前第几页
@property (nonatomic,assign ) NSInteger                      currentChapter;//当前第几章章

@property (nonatomic,copy) NSMutableAttributedString *content;//内容
@property (nonatomic,copy) NSString *text;

-(void)updateUI;//更新ui

//设置当前进度和页数
-(void)setIndex:(NSInteger)index totalPages:(NSInteger)totalPages;

@end

NS_ASSUME_NONNULL_END
