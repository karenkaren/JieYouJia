//
//  ControllersManager.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ControllersManager.h"
#import "ProjectRootController.h"
#import "BaseNavigationController.h"

@implementation ControllersManager

singleton_implementation(ControllersManager)

- (void)setupProjectRootViewController
{
    ProjectRootController * root = [[ProjectRootController alloc] init];
    [[GlobalManager mainWindow] setRootViewController:root];
}

#pragma mark - about login
+ (void)actionWhenLogin:(VoidBlock)block
{
    //    if ([[CurrentUser mine] hasLogged]) {
    //        // 如果用户已经登录，跳转到理财金券页面
    //        if (block) {
    //            block();
    //        }
    //    } else {
    //        // 如果用户未登录，跳转到登录页面
    //        [[LTNCore globleCore] loginController:^(void){
    //            if (block) {
    //                block();
    //            }
    //        }];
    //    }
}

-(void)loginController:(VoidBlock)finishBlock{

//    LTNLoginController * loginController = [LTNLoginController loginControllerWithFinishBlock:nil];
//    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:loginController];
//    navController.finishBlock=finishBlock;
//    [self.tabbarController presentViewController:navController animated:YES completion:nil];
    
    /*
     [UIView transitionFromView:[LTNCore keyWindow].rootViewController.view
     toView:navController.view
     duration:0.50
     options:UIViewAnimationOptionTransitionFlipFromLeft
     completion:^(BOOL finished)
     {
     [[LTNCore keyWindow] setRootViewController:navController];
     }];
     */
}

@end
