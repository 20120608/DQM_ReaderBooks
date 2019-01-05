//
//  UIImageView+SDwebImageFade.h
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//
/** 带有加载动画的SDWebImage加载图片 */
#import <UIKit/UIKit.h>

@interface UIImageView (SDwebImageFade)

- (void)qm_setWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder completion:(void (^)(UIImage *image))completion;

- (void)qm_setWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder;

- (void)qm_setWithImageURL:(NSURL *)imageURL;

@end


