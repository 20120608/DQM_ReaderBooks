//
//  DQMListExpendHeaderView.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DQMGroup;
@interface DQMListExpendHeaderView : UITableViewHeaderFooterView

/** 组 */
@property (nonatomic, strong) DQMGroup *group;

/** 选择的组block 有返回值 */
@property (nonatomic, copy) BOOL(^selectGroup)(void);

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
