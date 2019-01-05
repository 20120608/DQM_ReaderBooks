//
//  StaticSectionItem.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StaticListItem;//组里模型面包含cell模型
@interface StaticSectionItem : NSObject
/** headerSection */
@property (nonatomic, copy) NSString *headerTitle;

/** footerSection */
@property (nonatomic, copy) NSString *footerTitle;

/** 组包含的cell的模型数组 */
@property (nonatomic, strong) NSMutableArray<StaticListItem *> *items;

+ (instancetype)sectionWithItems:(NSArray<StaticListItem *> *)items andHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;


@end

