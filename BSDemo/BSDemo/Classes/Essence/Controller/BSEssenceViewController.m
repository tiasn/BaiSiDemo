//
//  BSEssenceViewController.m
//  BSDemo
//
//  Created by LTX on 2017/7/13.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSEssenceViewController.h"
#import "BSTitleView.h"
#import "BSBaseRequest.h"

#import "BSAllViewController.h"
#import "BSVideoViewController.h"
#import "BSVoiceViewController.h"
#import "BSPictureViewController.h"
#import "BSWordViewController.h"

#define kTitleViewH 50

@interface BSEssenceViewController ()<BSTitleViewDelegate, UIScrollViewDelegate>


@property (nonatomic , strong) BSTitleView *titleView;

@property (nonatomic , strong) BSBaseRequest *baseRequest;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation BSEssenceViewController


- (BSTitleView *)titleView {
    
    if (!_titleView) {
        
        CGRect titleFrame = CGRectMake(0, 64, kSCREEN_WIDTH, kTitleViewH);
        NSArray *titlesArray = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
        
        _titleView = [[BSTitleView alloc] initWithFrame:titleFrame titles:titlesArray];
        _titleView.delegate = self;
    }
    
    return _titleView;
    
}


- (BSBaseRequest *)baseRequest
{
    if (!_baseRequest) {
        _baseRequest = [BSBaseRequest requestWithURL:BSCommonURL];
    }
    
    return _baseRequest;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.titleView];
    
//    [self testAFN];
    
    self.currentIndex = 0;
    
    //初始化子控制器
    [self setupAllChildVcs];
    
    [self setupContentScrollView];
    
}





- (void)testAFN{

    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1";
    
    [self.baseRequest startWithMethod:BSHTTPTypePOST params:parameters completion:^(id responseObject, NSString *message, BOOL success) {
        
        if (success) {
            
            NSLog(@"%@", responseObject);
            
        }else{
            
            NSLog(@"%@", message);
            
        }
        
        
    }];
    



}



- (void)setupAllChildVcs
{
    [self addChildViewController:[[BSAllViewController alloc] init]];
    [self addChildViewController:[[BSVideoViewController alloc] init]];
    [self addChildViewController:[[BSVoiceViewController alloc] init]];
    [self addChildViewController:[[BSPictureViewController alloc] init]];
    [self addChildViewController:[[BSWordViewController alloc] init]];
}

#pragma mark - 设置内容
- (void)setupContentScrollView
{
    
    CGFloat contentY = CGRectGetMaxY(self.titleView.frame);
    CGRect rect = CGRectMake(0, contentY, kSCREEN_WIDTH, kSCREEN_HEIGHT - kTitleViewH);
    
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    self.contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * kSCREEN_WIDTH, 0);
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    
    
    //添加子控制器
    for (int i =0; i<self.childViewControllers.count; i++) {
        
        UIViewController *vc = [self.childViewControllers objectAtIndex:i];
        vc.view.frame = CGRectMake(kSCREEN_WIDTH *i, 0, kSCREEN_WIDTH, self.contentScrollView.height);
        
        [self.contentScrollView addSubview:vc.view];
        
    }
    
    
    [self.view addSubview:self.contentScrollView];
    
}

// titleView代理方法
- (void)titleClickSelectedIndex:(NSInteger)index
{

    self.currentIndex = index;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(index * kSCREEN_WIDTH, 0);
    }];

}






/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.width;
    
    
    [self.titleView setLabelWithFromIndex:self.currentIndex toIndex:index];

    
    // 点击对应的标题按钮
    [self titleClickSelectedIndex:index];
    
    
    
}



@end
