//
//  DQMBatteryView.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//


//最小宽度为55   给界面加上电池电量
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMBatteryView : UIView

@property (nonatomic,strong) UIColor *contentColor;//填充颜色 默认与lineColor颜色相同
@property (nonatomic,strong) UIColor *warningColor;//电量低于10%的填充颜色，默认与填充颜色相同
@property (nonatomic,strong) UIColor *lineColor;
-(instancetype)initWithLineColor:(UIColor *)lineColor;
- (void)runProgress:(NSInteger)progressValue;


@end

NS_ASSUME_NONNULL_END
