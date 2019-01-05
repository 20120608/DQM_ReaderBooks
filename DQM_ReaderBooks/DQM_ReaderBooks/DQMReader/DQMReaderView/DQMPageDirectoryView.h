//
//  DQMPageDirectoryView.h
//  DQM_ReaderBooks
//
//  Created by 漂读网 on 2019/1/3.
//  Copyright © 2019 漂读网. All rights reserved.
//

//目录菜单
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DQMPageDirectoryView;

@protocol DCBookListViewDelgate<NSObject>

-(void)bookListView:(DQMPageDirectoryView *)bookListView didSelectRowAtIndex:(NSInteger)index;
@end


@interface DQMPageDirectoryView : UIView

@property (nonatomic,strong) UITableView    *tableView;
@property (nonatomic,strong) UIView         *backView;

@property (nonatomic,strong) NSArray *list;
@property (nonatomic,weak) id<DCBookListViewDelgate> delegate;

@end

NS_ASSUME_NONNULL_END
