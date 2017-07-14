//
//  UIImage+TX.h
//  BigApp
//
//  Created by LTX on 2017/7/14.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TX)


+ (instancetype)imageOriginalWithName:(NSString *)imageName;

- (instancetype)tx_circleImage;

+ (instancetype)tx_circleImageNamed:(NSString *)name;

@end
