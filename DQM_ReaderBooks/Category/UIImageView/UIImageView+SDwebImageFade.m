//
//  UIImageView+SDwebImageFade.m
//  QM_HMQRCodeScanner
//
//  Created by 漂读网 on 2018/12/21.
//  Copyright © 2018 漂读网. All rights reserved.
//

#import "UIImageView+SDwebImageFade.h"

@implementation UIImageView (SDwebImageFade)

- (void)qm_setWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder completion:(void (^)(UIImage *image))completion
{
  [self sd_setImageWithURL:imageURL
          placeholderImage:placeholder
                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                   if (image && cacheType == SDImageCacheTypeNone) {
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionFade;
                     transition.duration = 0.5;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     [self.layer addAnimation:transition forKey:nil];
                   }
                   if (completion) {
                     completion(image);
                   }
                 }];
}


- (void)qm_setWithImageURL:(NSURL *)imageURL placeholderImage:(UIImage *)placeholder {
  [self sd_setImageWithURL:imageURL
          placeholderImage:placeholder
                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                   if (image && cacheType == SDImageCacheTypeNone) {
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionFade;
                     transition.duration = 0.5;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     [self.layer addAnimation:transition forKey:nil];
                   }
                 }];
}


- (void)qm_setWithImageURL:(NSURL *)imageURL {
  [self sd_setImageWithURL:imageURL
          placeholderImage:nil
                 completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                   if (image && cacheType == SDImageCacheTypeNone) {
                     CATransition *transition = [CATransition animation];
                     transition.type = kCATransitionFade;
                     transition.duration = 0.5;
                     transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                     [self.layer addAnimation:transition forKey:nil];
                   }
                 }];
}

@end
