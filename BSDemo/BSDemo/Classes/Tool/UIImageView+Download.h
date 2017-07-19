//
//  UIImageView+Download.h
//  BuDeJie
//
//  Created by xiaomage on 16/3/26.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (Download)

- (void)tx_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock;

- (void)tx_setHeader:(NSString *)headerUrl;


@end
