//
//  BSBigImageViewController.m
//  BSDemo
//
//  Created by LTX on 2017/7/20.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSBigImageViewController.h"
#import "BSTopicModel.h"



@interface BSBigImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation BSBigImageViewController


//- (UIScrollView *)scrollView
//{
//    if (!_scrollView) {
//        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.bounds = [UIScreen mainScreen].bounds;
//        _scrollView.backgroundColor = [UIColor lightGrayColor];
//        [_scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)] ];
//    }
//    
//    return _scrollView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];


    [self initUI];
    
    
    
    

}

- (void)initUI {

    //添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //    scrollView.frame = self.view.bounds;
    //    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor lightGrayColor];
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)]];
    [self.view insertSubview:scrollView atIndex:0];
    
    self.scrollView = scrollView;
    
    
    // 添加ImageView
    UIImageView *imgView = [[UIImageView alloc] init];
    [imgView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.image1] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) return ;
    
        
    }];
    
    
    imgView.width = scrollView.width;
    imgView.height = imgView.width  * self.topicModel.height / self.topicModel.width;
    
    imgView.x = 0;
    
    
    if (imgView.height > kSCREEN_HEIGHT) {
        imgView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imgView.height);
    }else{
        imgView.centerY = scrollView.centerY;
    }
    
    [scrollView addSubview:imgView];
    self.imgView = imgView;
    
    
    //缩放比例
    CGFloat maxScale = self.topicModel.width / scrollView.width;
    if (maxScale > 1) {

        scrollView.maximumZoomScale = maxScale;
        scrollView.delegate = self;

    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return self.imgView;
}



- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//保存图片
- (IBAction)saveImage:(UIButton *)sender {
    
//    UIImageWriteToSavedPhotosAlbum
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

// 保存图片
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }
}

////保存视频
//- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//
//    if (error) {
//        [SVProgressHUD showErrorWithStatus:@"保存失败！"];
//    }else {
//    
//        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
//    }
//
//}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
