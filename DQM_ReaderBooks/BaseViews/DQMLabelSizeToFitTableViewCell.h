//
//  DQMLabelSizeToFitTableViewCell.h
//  DQM_ReactiveCocoaDemo
//
//  Created by 漂读网 on 2019/1/2.
//  Copyright © 2019 漂读网. All rights reserved.
//

//自适应行高的cell
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DQMLabelSizeToFitTableViewCell : UITableViewCell

/** 显示的文字 */
@property(nonatomic,copy) NSMutableAttributedString          *contentText;

+(DQMLabelSizeToFitTableViewCell *)cellWithTableView:(UITableView *)tableView;


@end

NS_ASSUME_NONNULL_END
