//
//  ControllersManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/27.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

/**
    控制各controller的跳转
 */
#import <Foundation/Foundation.h>

@interface ControllersManager : NSObject

singleton_interface(ControllersManager)

- (void)setupProjectRootViewController;

#pragma mark - about login
+ (void)actionWhenLogin:(VoidBlock)block;

@end
