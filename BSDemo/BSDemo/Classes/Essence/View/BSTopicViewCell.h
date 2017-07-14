//
//  BSTopicViewCell.h
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopicModel;

@interface BSTopicViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *posTime;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

// 顶
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
// 踩
@property (weak, nonatomic) IBOutlet UIButton *hateBtn;
// 分享
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
// 评论
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;


@property (nonatomic , strong) BSTopicModel *model;


@end
