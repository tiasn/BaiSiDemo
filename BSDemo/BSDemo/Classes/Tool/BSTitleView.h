//
//  BSTitleView.h
//  BaiSiDemo
//
//  Created by LTX on 2017/7/12.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理协议
@protocol BSTitleViewDelegate <NSObject>

- (void)titleClickSelectedIndex:(NSInteger)index;

@end



@interface BSTitleView : UIView

//代理
@property(nonatomic, assign) id<BSTitleViewDelegate> delegate;


// 自定义构造方法
- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles;


- (void)setLabelWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

// 设置Lable
- (void)setLableWithProgress:(CGFloat)progress fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex offset:(CGFloat)offset;



@end
