//
//  DQMFoldingTableViewController.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 在原dqmTableView基础上衍生出来的可折叠的foldingTableViewController 仿照staticTableView写的 */
#import "DQMTableViewController.h"
#import "DQMTeam.h"
#import "DQMGroup.h"

@interface DQMFoldingTableViewController : DQMTableViewController

// 自定义某一行cell的时候要先调用调用super, 返回为空
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/** 默认是否打开折叠 */
@property(nonatomic,assign,getter=isDefaultOpen) BOOL          defaultOpen;

// 需要把组模型添加到数据中
@property (nonatomic, strong) NSMutableArray<DQMGroup *> *groups;

// 实例方法 添加一个cell要展示的东西
-(DQMFoldingTableViewController *(^)(DQMTeam *item, NSString *name, int section))addItem;





@end


