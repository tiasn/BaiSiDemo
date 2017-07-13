//
//  BSMainTabbarController.m
//  BaiSiDemo
//
//  Created by LTX on 2017/7/12.
//  Copyright © 2017年 LTX. All rights reserved.
//

#import "BSMainTabbarController.h"

#import "BSNavigationViewController.h"
#import "BSEssenceViewController.h"
//#import "XMGTabBar.h"

@interface BSMainTabbarController ()

@end

@implementation BSMainTabbarController

+ (void)initialize
{
    UITabBarItem *appearance = [UITabBarItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [appearance setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}



- (void)viewDidLoad {
    [super viewDidLoad];

    // 替换tabbar
//    [self setValue:[[XMGTabBar alloc] init] forKeyPath:@"tabBar"];
    
    // 初始化所有的子控制器
    [self setupChildViewControllers];
}



/**
 * 初始化所有的子控制器
 */
- (void)setupChildViewControllers
{
    BSEssenceViewController *essence = [[BSEssenceViewController alloc] init];
    [self setupOneChildViewController:essence title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
//    XMGNewViewController *new = [[XMGNewViewController alloc] init];
//    [self setupOneChildViewController:new title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
//    
//    XMGFriendTrendsViewController *friends = [[XMGFriendTrendsViewController alloc] init];
//    [self setupOneChildViewController:friends title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
//    
//    XMGMeViewController *me = [[XMGMeViewController alloc] init];
//    [self setupOneChildViewController:me title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
}

- (void)setupOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[BSNavigationViewController alloc] initWithRootViewController:vc]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
