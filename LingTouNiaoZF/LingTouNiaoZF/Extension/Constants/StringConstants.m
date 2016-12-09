//
//  StringConstants.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "StringConstants.h"

@implementation StringConstants

#pragma mark - Notification
// 用户登录状态
NSString * const kLoginSuccessNotification = @"LoginSuccessNotification";
NSString * const kLoginCancelNotification = @"LoginCancelNotification";
NSString * const kLogoutSuccessNotification = @"LogoutSuccessNotification";

#pragma mark - UserDefault
// 存储在 defaults中 的 网络接口地址
NSString * const kDefaults_NetAddress = @"kDefaults_NetAddress";
NSString * const kDefaults_POST_ADDR = @"kDefaults_POST_ADDR";
NSString * const kServerAPIErrorDomain = @"LTNErrorDomain";

NSString * const kSessionKey = @"sessionKey";
NSString * const kUserName = @"userName";
NSString * const kMobileNo = @"mobileNo";

#pragma mark - Common


@end
