//
//  BSTopicModel.m
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSTopicModel.h"

@implementation BSTopicModel


//- (CGFloat)textHeight
//{
//    // 文字的高度
//    CGSize textMaxSize = CGSizeMake(kSCREEN_WIDTH, MAXFLOAT);
//    CGFloat textHeight = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
//    
//    return textHeight + 10;
//    
//}


//- (CGFloat)videoHeight
//{
//    return 150;
//}
//
//
//- (CGFloat)voiceHeight
//{
//    return 100;
//}
//
//
//- (CGFloat)pictureHeight
//{
//    return 50;
//}



- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    
    // 文字的Y值
    _cellHeight += kCellTextY;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(kSCREEN_WIDTH, MAXFLOAT);
    CGFloat textHeight = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
//
    
    
//    if (self.type == BSTopicTypeVideo) {
//        _cellHeight += self.videoHeight;
//        
//    }else if (self.type == BSTopicTypeVoice){
//        _cellHeight += self.voiceHeight;
//        
//    }else if (self.type == BSTopicTypePicture){
//        _cellHeight += self.pictureHeight;
//    }
//    
//    _cellHeight += textMaxSize.height;

    
    _cellHeight += textHeight;
        
    // 中间的内容
    if (self.type != BSTopicTypeWord) { // 中间有内容（图片、声音、视频）
        CGFloat middleW = textMaxSize.width;
        CGFloat middleH = middleW * self.height / self.width;
        

        if (middleH >= kSCREEN_HEIGHT) { // 显示的图片高度超过一个屏幕，就是超长图片
            middleH = 200;
            self.bigPicture = YES;
        }
        
        CGFloat middleY = _cellHeight;
        CGFloat middleX = 0;
        self.middleFrame = CGRectMake(middleX, middleY, middleW, middleH);
        _cellHeight += middleH ;
    }
    

    
    // 工具条 每行间距10
    _cellHeight += 40 + 10;
    
    return _cellHeight;
}





@end
