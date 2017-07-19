//
//  BSPictureCellView.h
//  BSDemo
//
//  Created by LTX on 2017/7/14.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopicModel;


@interface BSPictureCellView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;

@property (nonatomic , strong) BSTopicModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigImageBtn;

@end
