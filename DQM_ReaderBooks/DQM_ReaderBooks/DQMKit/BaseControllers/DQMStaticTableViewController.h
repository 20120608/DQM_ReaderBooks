//
//  DQMStaticTableViewController.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 子类继承后可以用.addItem对cell直接赋值和点击事件 不用再写代理 仿StaticTableViewController.h */
#import "DQMTableViewController.h"
#import "StaticSectionItem.h"
#import "StaticListItem.h"

@interface DQMStaticTableViewController : DQMTableViewController

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray<StaticSectionItem *> *sections;

// 自定义某一行cell的时候要先调用调用super, 返回为空
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

// 实例方法 添加一个cell要展示的东西
-(DQMStaticTableViewController *(^)(StaticListItem *item))addItem;


//定义2个内边距常量
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultSeparatorInset;   //左边距15
UIKIT_EXTERN const UIEdgeInsets tableViewDefaultLayoutMargins;    //上下左右各8


@end

