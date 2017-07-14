//
//  BSViedoCellView.m
//  BSDemo
//
//  Created by LTX on 2017/7/14.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSViedoCellView.h"

@implementation BSViedoCellView


- (void)awakeFromNib
{
    // 通过系统自动创建的Xib view autoresizingMask属性默认是宽高 随父控件自动变化
    //    手动改为不变化
    self.autoresizingMask = UIViewAutoresizingNone;
}



@end
