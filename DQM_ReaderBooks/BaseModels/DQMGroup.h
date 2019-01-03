//
//  DQMGroup.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DQMTeam;
@interface DQMGroup : NSObject

/** 是否展开了 */
@property (assign, nonatomic) BOOL isOpened;

/** 名称 */
@property (nonatomic, copy) NSString *name;

/** headerSection */
@property (nonatomic, copy) NSString *headerTitle;

/** footerSection */
@property (nonatomic, copy) NSString *footerTitle;

/** 数组 */
@property (nonatomic, strong) NSMutableArray<DQMTeam *> *teams;

+ (instancetype)sectionWithItems:(NSArray<DQMTeam *> *)teams andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle name:(NSString *)name;

@end
