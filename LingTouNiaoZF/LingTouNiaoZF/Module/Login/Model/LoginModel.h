//
//  LoginModel.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

#pragma mark - 接口
// 找回密码验证
+ (void)doGetBackPasswordCheck:(NSDictionary *)params block:(APIResultBlock)block;
// 找回密码提交
+ (void)doGetBackPassword:(NSDictionary *)params block:(APIResultBlock)block;
// 登录
+ (void)doLogin:(NSDictionary *)params block:(void (^)(id response, BOOL showCaptcha, NSError *error))block;
// 注册
+ (void)doRegister:(NSDictionary *)params block:(APIResultBlock)block;
// 注册发送短信验证码
+ (void)registerOfSendMobileCode:(NSDictionary *)params block:(APIResultBlock)block;
// 找回密码发送短信验证码
+ (void)getBackPasswordOfSendMobileCode:(NSDictionary *)params block:(void (^)(id response, BOOL showIdentify, NSError *error))block;
// 获取图片验证码
+ (void)getPictureCode:(NSDictionary *)params block:(void(^)(UIImage * image))block;
// 退出登录


@end
