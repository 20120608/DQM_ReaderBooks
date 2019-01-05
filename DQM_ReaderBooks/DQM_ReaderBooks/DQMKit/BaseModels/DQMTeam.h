//
//  DQMTeam.h
//  QM_FoldingTableViewDemo
//
//  Created by 漂读网 on 2018/12/18.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DQMTeam : NSObject

/** 序号 */
@property (nonatomic, copy ) NSString     *sortNumber;

/** 名称 */
@property (nonatomic, copy ) NSString     *name;

/** 要跳转的界面 */
@property(nonatomic,assign) Class          destVc;

/** 扩展 */
@property (nonatomic,strong) NSDictionary *extensionDictionary;


+ (instancetype)initTeamWithName:(NSString *)name sortNumber:(NSString *)sortNumber destVc:(Class)destVc extensionDictionary:(NSDictionary *)extensionDictionary;

@end

