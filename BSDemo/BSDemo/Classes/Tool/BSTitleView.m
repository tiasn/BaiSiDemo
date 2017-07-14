//
//  BSTitleView.m
//  BaiSiDemo
//
//  Created by LTX on 2017/7/12.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSTitleView.h"
#import "UIColor+ZXLazy.h"


#define kScrollLineH 2
#define kScrollLineW 65
#define kLineheight 0.5

@interface BSTitleView ()

@property (nonatomic , strong) NSMutableArray  *titleLable;
//标题数组
@property (nonatomic , strong) NSArray  *titles;
@property (nonatomic , strong) UIScrollView  *scrollView;
@property (nonatomic , strong) UIView *scrollLine;

@property (nonatomic , assign) NSInteger currentIndex;


@end

@implementation BSTitleView


- (id)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.titles = titles;

        //设置UI界面
        [self initUI];
        
        //设置标题
        [self setupTitleLables];
        
        //设置下划线
        [self setupBottomScrollLine];
    }
    
    
    return self;
    
}


- (void)initUI
{
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.titleLable = [NSMutableArray array];
    self.currentIndex = 0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.contentSize = self.size;
    //    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.bounces = NO;
    
    self.scrollView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    
    [self addSubview:self.scrollView];
    
    UIView *Lineview = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kLineheight, self.width, kLineheight)];
    Lineview.backgroundColor = [UIColor grayColor];
    [self addSubview:Lineview];
}

#pragma mark --设置标题
- (void)setupTitleLables
{
    
    //labe的值
    CGFloat lableW  = self.frame.size.width / (self.titles.count);
    CGFloat lableH  = self.frame.size.height - kScrollLineH;
    CGFloat lableY  = 0;
    
    for (int i = 0; i< self.titles.count; i++) {
        
        NSString *title = [self.titles objectAtIndex:i];
        // 创建lable
        UILabel *lable = [[UILabel alloc] init];
        
        //设置lable属性
        lable.text = title;
        lable.tag = i;
        lable.font = [UIFont systemFontOfSize:15];
        lable.textColor = [UIColor blackColor];
        lable.textAlignment = NSTextAlignmentCenter;
        
        //设置labe的Frame
        CGFloat labelX   = lableW * i;
        lable.frame = CGRectMake(labelX, lableY, lableW, lableH);
        
        // 添加点击事件
        lable.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lableClick:)];
        [lable addGestureRecognizer:tapGes];
        
        if (i > 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(labelX - 0.5, 10, 0.5, 30)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.scrollView addSubview:lineView];
        }
        
        
        //添加lable到ScrollView
        [self.scrollView addSubview:lable];
        
        //添加到数组
        [self.titleLable addObject:lable];
        
    }
    
}

//下划线
- (void)setupBottomScrollLine
{
    
    UILabel *firstLable = self.titleLable.firstObject;
    firstLable.textColor = [UIColor redColor];
    
    self.scrollLine = [[UIView alloc] initWithFrame:CGRectMake(firstLable.x, self.height - kScrollLineH, kScrollLineW, kScrollLineH)];
    self.scrollLine.centerX = firstLable.centerX;
    self.scrollLine.backgroundColor = [UIColor redColor];
    [self addSubview:self.scrollLine];
    
    
}


#pragma mark --- 监听点击
- (void)lableClick:(UITapGestureRecognizer *)gesture
{
    // 点击的lable
    UILabel *currentLable = (UILabel *)gesture.view;
    
    if (self.currentIndex == currentLable.tag) {
        return;
    }
    
    //旧的lable
    UILabel *oldLable = [self.titleLable objectAtIndex:self.currentIndex];
    
    //修改颜色
    oldLable.textColor = [UIColor blackColor];
    currentLable.textColor = [UIColor redColor];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.scrollLine.centerX = currentLable.centerX;
        
    }];
    
    
    //保存最新的lable下标
    self.currentIndex = currentLable.tag;
    
    //通知代理
    if (self.delegate) {
        [self.delegate titleClickSelectedIndex:self.currentIndex];
    }
    
    
}


/**
 外面调用
 @param fromIndex 原来的位置
 @param toIndex 新的位置
 */
- (void)setLabelWithFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    //取出lable
    UILabel *sourceLable = [self.titleLable objectAtIndex:fromIndex];
    UILabel *targetLable =  [self.titleLable objectAtIndex:toIndex];
    
    sourceLable.textColor = [UIColor blackColor];
    targetLable.textColor = [UIColor redColor];
    
    self.scrollLine.centerX = targetLable.centerX;

}




@end
