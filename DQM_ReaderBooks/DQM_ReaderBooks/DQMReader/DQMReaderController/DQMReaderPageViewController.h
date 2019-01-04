//
//  DQMReaderPageViewController.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//


//用于控制界面的翻页效果和整体的控制
#import "DQMBaseViewController.h"
#import "DQMReadHistory.h"

NS_ASSUME_NONNULL_BEGIN

@interface DQMReaderPageViewController : DQMBaseViewController


@property (nonatomic,strong) DQMReadHistory *readHistoryModel;


@end

NS_ASSUME_NONNULL_END
