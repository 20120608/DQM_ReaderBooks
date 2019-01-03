//
//  StaticListItem.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

/** 通用的列表的cellItem 传入needCustom自定义 传入fixedCellHeight可以写个固定高度 */
#import <Foundation/Foundation.h>

@interface StaticListItem : NSObject

/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 副标题的字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 主标题的颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** subTitle */
@property (nonatomic, copy) NSString *subTitle;
/** 副标题的字体 */
@property (nonatomic, strong) UIFont *subTitleFont;
/** 副标题的颜色 */
@property (nonatomic, strong) UIColor *subTitleColor;
/** 副标题行数限制 */
@property (nonatomic, assign)  NSInteger subTitleNumberOfLines;

/** 左边的图片 UIImage 或者 NSURL 或者 URLString 或者 ImageName */
@property (nonatomic, strong) id image;

/** 这是要调转的目标控制器 */
@property (assign, nonatomic) Class destVc;

/**  default is UITableViewCellAccessoryNone. use to set standard type */
@property (nonatomic) UITableViewCellAccessoryType    accessoryType;

/** 没有固定高度就自适应 */
@property (assign, nonatomic) CGFloat fixedCellHeight;

/** 是否自定义这个cell , 如果自定义, 则在tableview返回默认的cell, 自己需要自定义cell返回*/
@property (assign, nonatomic, getter = isNeedCustom) BOOL needCustom;

/** 点击操作 */
@property (nonatomic, copy) void(^itemOperation)(NSIndexPath *indexPath);

/** 不带点击事件 返回一个cell */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

/** 带点击事件 返回一个cell */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;

/** 带点击事件 返回一个cell 还能带上是否展示箭头等辅助视图 */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle accessoryType:(UITableViewCellAccessoryType)accessoryType itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;

/** 带点击事件 返回一个cell 可以输入一个固定的高度 */
+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle fixedCellHeight:(CGFloat)fixedCellHeight itemOperation:(void(^)(NSIndexPath *indexPath))itemOperation;

@end

