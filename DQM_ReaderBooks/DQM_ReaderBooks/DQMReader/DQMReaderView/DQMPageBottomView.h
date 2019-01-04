//
//  DQMPageBottomView.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//底部菜单
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum: NSUInteger{
  DCSetupFontTypeAdd,
  DCSetupFontTypeSubtract ,
}DCSetupFontType;

@protocol DCPageBottomViewDelegate<NSObject>

-(void)readModeClick:(UIButton *)btn;
-(void)listClick:(UIButton *)btn;
-(void)setUpFontClick:(DCSetupFontType)type;

@end


@interface DQMPageBottomView : UIView

@property (nonatomic,weak) id<DCPageBottomViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
