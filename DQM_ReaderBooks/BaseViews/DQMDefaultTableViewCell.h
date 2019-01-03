//
//  DQMDefaultTableViewCell.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 最普通的cell */
#import <UIKit/UIKit.h>

@interface DQMDefaultTableViewCell : UITableViewCell

+(DQMDefaultTableViewCell *)cellWithTableView:(UITableView *)tableView Title:(NSString *)title TitleFont:(UIFont *)titleFont TableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle;



@end

