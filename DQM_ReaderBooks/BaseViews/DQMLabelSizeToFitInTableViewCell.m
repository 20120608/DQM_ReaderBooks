//
//  DQMLabelSizeToFitInTableViewCell.m
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2019/1/2.
//  Copyright © 2019 漂读网. All rights reserved.
//

#import "DQMLabelSizeToFitInTableViewCell.h"

@implementation DQMLabelSizeToFitInTableViewCell

+(DQMLabelSizeToFitInTableViewCell *)cellWithTableView:(UITableView *)tableView
{
  static NSString *identifier = @"DQMLabelSizeToFitInTableViewCell";
  DQMLabelSizeToFitInTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (cell == nil)
  {
    cell = [[DQMLabelSizeToFitInTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
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
