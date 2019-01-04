//
//  DQMPageTopView.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//顶部显示隐藏的带返回按钮的界面
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  DQMPageTopView;
@protocol DCPageTopViewDelegate<NSObject>

-(void)backInDCPageTopView:(DQMPageTopView *)topView;

@end


@interface DQMPageTopView : UIView


@property (nonatomic,weak) id<DCPageTopViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
