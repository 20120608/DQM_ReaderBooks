//
//  DQMDefaultTableViewCell.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "DQMDefaultTableViewCell.h"

@implementation DQMDefaultTableViewCell


+(DQMDefaultTableViewCell *)cellWithTableView:(UITableView *)tableView Title:(NSString *)title TitleFont:(UIFont *)titleFont TableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle {
  
  static NSString *identifier = @"DQMDefaultTableViewCell";
  DQMDefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[DQMDefaultTableViewCell alloc] initWithStyle:tableViewCellStyle reuseIdentifier:identifier];
  }
  [cell.textLabel setText:title];
  [cell.textLabel setFont:titleFont];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self)
  {
    
  }
  return self;
}

@end
