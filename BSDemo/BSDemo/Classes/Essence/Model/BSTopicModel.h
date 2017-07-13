//
//  BSTopicModel.h
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, BSTopicType) {
    /** 全部 */
    BSTopicTypeAll = 1,
    /** 图片 */
    BSTopicTypePicture = 10,
    /** 段子 */
    BSTopicTypeWord = 29,
    /** 声音 */
    BSTopicTypeVoice = 31,
    /** 视频 */
    BSTopicTypeVideo = 41
};


@interface BSTopicModel : NSObject



/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

/* 额外增加的属性（并非服务器返回的属性，仅仅是为了提高开发效率） */
/** 根据当前模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) CGFloat textHeight;


@end
