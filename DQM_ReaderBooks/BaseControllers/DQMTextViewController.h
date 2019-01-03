//
//  DQMTextViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 戴泉明文本类型基础视图 */
#import "DQMNavUIBaseViewController.h"

@class DQMTextViewController;
@protocol DQMTextViewControllerDataSource <NSObject>

@optional
- (UIReturnKeyType)textViewControllerLastReturnKeyType:(DQMTextViewController *)textViewController;

- (BOOL)textViewControllerEnableAutoToolbar:(DQMTextViewController *)textViewController;

//  控制是否可以点击点击的按钮
- (NSArray <UIButton *> *)textViewControllerRelationButtons:(DQMTextViewController *)textViewController;

@end


@protocol DQMTextViewControllerDelegate <UITextViewDelegate, UITextFieldDelegate>

@optional
#pragma mark - 最后一个输入框点击键盘上的完成按钮时调用
- (void)textViewController:(DQMTextViewController *)textViewController inputViewDone:(id)inputView;
@end

@interface DQMTextViewController : DQMNavUIBaseViewController<DQMTextViewControllerDataSource, DQMTextViewControllerDelegate>

- (BOOL)textFieldShouldClear:(UITextField *)textField NS_REQUIRES_SUPER;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string NS_REQUIRES_SUPER;
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_REQUIRES_SUPER;
- (BOOL)textFieldShouldReturn:(UITextField *)textField NS_REQUIRES_SUPER;


@end




#pragma mark - design UITextField
IB_DESIGNABLE
@interface UITextField (DQMTextViewController)

@property (assign, nonatomic) IBInspectable BOOL isEmptyAutoEnable;

@end


@interface DQMTextViewControllerTextField : UITextField

@end


