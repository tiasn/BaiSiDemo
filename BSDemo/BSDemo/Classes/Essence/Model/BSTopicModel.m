//
//  BSTopicModel.m
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSTopicModel.h"

@implementation BSTopicModel


- (CGFloat)textHeight
{
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(kSCREEN_WIDTH, MAXFLOAT);
    CGFloat textHeight = [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    return textHeight;
    
}

- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    
    // 文字的Y值
    _cellHeight += kCellTextY;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(kSCREEN_WIDTH, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    // 工具条 每行间距10
    _cellHeight += 40 + 10;
    
    return _cellHeight;
}

@end
