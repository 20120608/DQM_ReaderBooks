//
//  StaticListTableViewCell.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StaticListItem;
@interface StaticListTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView andCellStyle:(UITableViewCellStyle)style;

/** 静态单元格模型 */
@property (nonatomic, strong)  StaticListItem *item;

@end
