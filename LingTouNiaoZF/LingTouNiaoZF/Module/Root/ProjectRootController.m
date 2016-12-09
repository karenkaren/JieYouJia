//
//  ProjectRootController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ProjectRootController.h"

#import "BaseNavigationController.h"

#import "HomeRootController.h"
#import "ServiceRootController.h"
#import "MeRootController.h"

@interface ProjectRootController ()<UITabBarControllerDelegate>

@end

@implementation ProjectRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatControllers];
    // 默认选中
//    self.selectedIndex = 1;
}

-(void)creatControllers
{
    // 1.首页
    HomeRootController * home = [[HomeRootController alloc] init];
    BaseNavigationController * homeNav = [[BaseNavigationController alloc] initWithRootViewController:home];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                        image:[UIImage imageNamed:@"shouye2"]
                                                selectedImage:[UIImage imageNamed:@"shouye"]];
    home.tabBarItem = item1;

    //2.服务
    ServiceRootController * service = [[ServiceRootController alloc]initWithURL:@"https://www.baidu.com"];
    BaseNavigationController * serviceNav = [[BaseNavigationController alloc]initWithRootViewController:service];
    UITabBarItem * item2 = [[UITabBarItem alloc]initWithTitle:@"生活"
                                                        image:[UIImage imageNamed:@"shenghuo2"]
                                                selectedImage:[UIImage imageNamed:@"shenghuo"]];
    serviceNav.tabBarItem = item2;
    
    // 3.我的
    MeRootController * me = [[MeRootController alloc] initWithURL:@"https://www.lingtouniao.com/native/home/home.html"];
    BaseNavigationController * meNav = [[BaseNavigationController alloc] initWithRootViewController:me];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"我的"
                                                        image:[UIImage imageNamed:@"wode2"]
                                                selectedImage:[UIImage imageNamed:@"wode"]];
    meNav.tabBarItem = item3;
    
    NSArray *controllers = [NSArray arrayWithObjects:homeNav, serviceNav, meNav,nil];
    self.viewControllers = controllers;
}

@end
