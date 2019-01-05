//
//  DQMReaderContentViewController.m
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMReaderContentViewController.h"
#import <objc/runtime.h> //运行时
#import "DQMBatteryView.h"  //界面带上电池电量

@interface DQMReaderContentViewController ()

@property (nonatomic,strong) UIImageView    *backImageView;/** 背景 */
@property (nonatomic,strong) UITextView     *textView;
@property (nonatomic,strong) UILabel        *bottomRightL;
@property (nonatomic,strong) UILabel        *bottomLeftL;
@property (nonatomic,assign) NSInteger      index;//页数
@property (nonatomic,assign) NSInteger      totalPages;//总页数
@property (nonatomic,strong) DQMBatteryView *battery;
@property (nonatomic,strong) UIColor        *otherTextColor;

@end

@implementation DQMReaderContentViewController

#pragma mark  - life cycle
- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  [self Initialize];
  
  [self.view addSubview:self.backImageView];

  
  [self.view addSubview:self.textView];
  [self.view addSubview:self.bottomRightL];
  [self.view addSubview: self.bottomLeftL];
  [self.view addSubview:self.battery];
  
  [self.battery runProgress:[self getCurrentBatteryLevel]];

}

-(void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  self.textView.frame = CGRectMake(20, 40, 0, 0);
  self.textView.size = kContentSize;
  self.battery.frame = CGRectMake(kScreenWidth - 75, 10, 60, 20);
  self.bottomRightL.frame = CGRectMake(kScreenWidth*0.5,kScreenHeight - 30, kScreenWidth*0.5 - 15, 20);
  self.bottomLeftL.frame = CGRectMake(15, kScreenHeight - 30, kScreenWidth *0.5 - 15, 20);
  
}

#pragma mark  - event

#pragma mark  - delegate

#pragma mark  - notification

#pragma mark  - private
-(void)Initialize
{
  _otherTextColor = [UIColor grayColor];
}
-(void)updateUI
{
  NSString *readMode = [[NSUserDefaults standardUserDefaults] objectForKey:DCReadMode];
  NSString *readtheme = [[NSUserDefaults standardUserDefaults] objectForKey:DCReadTheme];
  

  if([readMode isEqualToString:DCReadDefaultMode])
  {
    [self.content addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, self.content.length)];
    self.textView.attributedText = self.content;
    self.bottomLeftL.textColor = [UIColor grayColor];
    self.bottomRightL.textColor = [UIColor grayColor];
    self.battery.lineColor = [UIColor grayColor];
    self.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"theme%@.jpg",readtheme]];

  }else
  {
    [self.content addAttribute:NSForegroundColorAttributeName value:[UIColor lightTextColor] range:NSMakeRange(0, self.content.length)];
    self.textView.attributedText = self.content;
    self.bottomLeftL.textColor = [UIColor lightTextColor];
    self.bottomRightL.textColor = [UIColor lightTextColor];
    self.battery.lineColor = [UIColor lightTextColor];
    self.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"theme1%@.jpg",readtheme]];

  }
}
- (CGFloat)getCurrentBatteryLevel
{
  UIApplication *app = [UIApplication sharedApplication];
  if (app.applicationState == UIApplicationStateActive||app.applicationState==UIApplicationStateInactive) {
    Ivar ivar=  class_getInstanceVariable([app class],"_statusBar");
    id status  = object_getIvar(app, ivar);
    for (id aview in [status subviews]) {
      int batteryLevel = 0;
      for (id bview in [aview subviews]) {
        if ([NSStringFromClass([bview class]) caseInsensitiveCompare:@"UIStatusBarBatteryItemView"] == NSOrderedSame&&[[[UIDevice currentDevice] systemVersion] floatValue] >=6.0) {
          Ivar ivar=  class_getInstanceVariable([bview class],"_capacity");
          if(ivar) {
            batteryLevel = ((int (*)(id, Ivar))object_getIvar)(bview, ivar);
            if (batteryLevel > 0 && batteryLevel <= 100) {
              return batteryLevel;
            } else {
              return 0;
            }
          }
        }
      }
    }
  }
  return 0;
}
#pragma mark  - public
-(void)setIndex:(NSInteger)index totalPages:(NSInteger)totalPages
{
  _index = index;
  _totalPages = totalPages;
  
  NSString *indexStr = [NSString stringWithFormat:@"%ld",index];
  NSString *totalPagesStr = [NSString stringWithFormat:@"%ld",totalPages];
  float progress = indexStr.floatValue / totalPagesStr.floatValue;
  self.bottomLeftL.text = [NSString stringWithFormat:@"本章进度%.1lf%%",progress*100];
  self.bottomRightL.text = [NSString stringWithFormat:@"%ld/%ld",index+1,totalPages];
}

#pragma mark  - setter or getter
-(void)setContent:(NSMutableAttributedString *)content
{
  _content = content;
  self.textView.attributedText = content;
  //更新UI
  [self updateUI];
}
-(void)setText:(NSString *)text
{
  _text = text;
  self.textView.text = text;
}

-(UITextView *)textView
{
  if(_textView == nil)
  {
    _textView = [[UITextView alloc]init];
    _textView.font = DCDefaultTextFont;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.editable = NO;
    _textView.scrollEnabled = NO;
    _textView.selectable = NO;
    //一定要设置为0，不然计算出的文字不能全部显示出来
    _textView.textContainerInset = UIEdgeInsetsZero;
    
  }
  return _textView;
}
-(DQMBatteryView *)battery
{
  if(_battery == nil)
  {
    _battery = [[DQMBatteryView alloc]initWithLineColor:[UIColor grayColor]];
  }
  return _battery;
}
-(UILabel *)bottomLeftL
{
  if(_bottomLeftL == nil)
  {
    _bottomLeftL = [[UILabel alloc]init];
    _bottomLeftL.textAlignment = NSTextAlignmentLeft;
    _bottomLeftL.textColor = [UIColor grayColor];
    _bottomLeftL.font = [UIFont systemFontOfSize:12];
  }
  return _bottomLeftL;
}
-(UILabel *)bottomRightL
{
  if(_bottomRightL == nil)
  {
    _bottomRightL = [[UILabel alloc]init];
    _bottomRightL.textAlignment = NSTextAlignmentRight;
    _bottomRightL.textColor = [UIColor grayColor];
    _bottomRightL.font = [UIFont systemFontOfSize:12];
  }
  return _bottomRightL;
}

-(UIImageView *)backImageView
{
  if (!_backImageView) {
    _backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
  }
  return _backImageView;
}


@end

