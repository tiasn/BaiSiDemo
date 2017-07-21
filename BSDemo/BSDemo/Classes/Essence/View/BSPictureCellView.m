//
//  BSPictureCellView.m
//  BSDemo
//
//  Created by LTX on 2017/7/14.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSPictureCellView.h"
#import "BSTopicModel.h"
#import <UIImage+GIF.h>

#import "BSBigImageViewController.h"


@implementation BSPictureCellView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    self.bigImageView.userInteractionEnabled = YES;
    
    //添加手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigImage)];
    
    [self.bigImageView addGestureRecognizer:tapGes];
    
    [self.seeBigImageBtn addTarget:self action:@selector(seeBigImage) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)seeBigImage {
    
    BSBigImageViewController *bigImg = [[BSBigImageViewController alloc] init];
    bigImg.topicModel = self.model;

    [self.window.rootViewController presentViewController:bigImg animated:YES completion:^{
    }];
    
    
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigImg animated:YES completion:^{
//    
//    }];
}





- (void)setModel:(BSTopicModel *)model {
    
    _model = model;
    

    
//    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    
    
    [self.bigImageView tx_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return;
        
//        self.placeholderView.hidden = YES;
        
        // 处理超长图片的大小
        if (model.isBigPicture) {
            CGFloat imageW = model.middleFrame.size.width;
            CGFloat imageH = imageW * model.height / model.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.bigImageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.bigImageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
            
        }
    }];
    
    self.gifView.hidden = !model.is_gif;
    
    // 点击查看大图
    if (model.isBigPicture) { // 超长图
        self.seeBigImageBtn.hidden = NO;
        self.bigImageView.contentMode = UIViewContentModeTop;
        self.bigImageView.clipsToBounds = YES;
        

    } else {
        self.seeBigImageBtn.hidden = YES;
        self.bigImageView.contentMode = UIViewContentModeScaleToFill;
        self.bigImageView.clipsToBounds = NO;
        
    }
    
    


    
    
    
    
}


@end
