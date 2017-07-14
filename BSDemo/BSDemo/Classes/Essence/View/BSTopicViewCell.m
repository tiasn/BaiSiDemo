//
//  BSTopicViewCell.m
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSTopicViewCell.h"

#import "BSTopicModel.h"
#import "UIImageView+WebCache.h"

#import "BSViedoCellView.h"
#import "BSVoiceCellView.h"
#import "BSPictureCellView.h"

@interface BSTopicViewCell ()

//视频view
@property (nonatomic , strong) BSViedoCellView *videoCellView;
//声音view
@property (nonatomic , strong) BSVoiceCellView *voiceCellView;
//图片view
@property (nonatomic , strong) BSPictureCellView *pictureCellView;




@end

@implementation BSTopicViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


// 懒加载
- (BSViedoCellView *)videoCellView
{
    if (!_videoCellView) {
        _videoCellView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSViedoCellView class]) owner:nil options:nil].firstObject;
        [self.contentView addSubview:_videoCellView];
    }
    
    return _videoCellView;
}

- (BSVoiceCellView *)voiceCellView
{
    if (!_voiceCellView) {
        _voiceCellView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSVoiceCellView class]) owner:nil options:nil].firstObject;
        [self.contentView addSubview:_voiceCellView];
        
    }
    return _voiceCellView;
    
}


- (BSPictureCellView *)pictureCellView
{
    if (!_pictureCellView) {
        _pictureCellView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSPictureCellView class]) owner:nil options:nil].firstObject;
        [self.contentView addSubview:_pictureCellView];
    }
    return _pictureCellView;
}



- (void)setModel:(BSTopicModel *)model {

    _model = model;
    
    self.nameLabel.text = model.name;
    self.posTime.text = model.passtime;
    
    [self.dingBtn setTitle:[NSString stringWithFormat:@"%zd", model.ding] forState:UIControlStateNormal];
    [self.hateBtn setTitle:[NSString stringWithFormat:@"%zd", model.cai] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%zd", model.repost] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%zd", model.comment] forState:UIControlStateNormal];
    

    
    UIImage *placeholder = [UIImage tx_circleImageNamed:@"defaultUserIcon"];
    [self.headerImgView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:placeholder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
          if (!image) return;
        
          self.headerImgView.image = [image tx_circleImage];
        
    }];
    
    
    
    
    
    
    
    self.contentLabel.text = model.text;
    
    
    // 类型
    if (model.type == BSTopicTypeVideo) {
        
        self.videoCellView.hidden = NO;
        self.voiceCellView.hidden = YES;
        self.pictureCellView.hidden = YES;
//        CGRect frame = CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame), kSCREEN_WIDTH, 100);
//        self.videoCellView.frame = frame;


    }else if (model.type == BSTopicTypeVoice){
        
        self.voiceCellView.hidden = NO;
        self.videoCellView.hidden = YES;
        self.pictureCellView.hidden = YES;
        

    
    }else if (model.type == BSTopicTypePicture){
    
        self.pictureCellView.hidden = NO;
        self.videoCellView.hidden = YES;
        self.voiceCellView.hidden = YES;

        
    }else {
        
        self.videoCellView.hidden = YES;
        self.voiceCellView.hidden = YES;
        self.pictureCellView.hidden = YES;


    }
    
}

// 重新布局 设置中部控件的Frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.model.type == BSTopicTypeVideo) {
        self.videoCellView.frame = self.model.middleFrame;
    }else if (self.model.type == BSTopicTypeVoice){
        self.voiceCellView.frame = self.model.middleFrame;
        
    }else if (self.model.type == BSTopicTypePicture){
        self.pictureCellView.frame = self.model.middleFrame;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
