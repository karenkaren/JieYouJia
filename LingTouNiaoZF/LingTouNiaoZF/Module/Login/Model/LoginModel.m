//
//  LoginModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

+ (void)doGetBackPasswordCheck:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_getBackPassword_check params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)doGetBackPassword:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_getBackPassword_submit params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)doRegister:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_register_submit params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
        if (!error) {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            [[NSUserDefaults standardUserDefaults] setValue:dto.data[@"sessionKey"] forKey:kSessionKey];
            [[NSUserDefaults standardUserDefaults] setValue:params[@"mobileNo"] forKey:kMobileNo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            DLog(@"sessionKey:%@ mobileNo:%@", [[NSUserDefaults standardUserDefaults] valueForKey:kSessionKey], [[NSUserDefaults standardUserDefaults] valueForKey:kMobileNo]);
        }
    }];
}

+ (void)doLogin:(NSDictionary *)params block:(void (^)(id response, BOOL showCaptcha, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_login params:params methodType:Get block:^(id response, NSError *error) {
        BOOL showCaptcha = NO;
        if (error) {
            if (error.code == 3) {
                showCaptcha = YES;
            }
        } else {
            BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
            [[NSUserDefaults standardUserDefaults] setValue:dto.data[@"sessionKey"] forKey:kSessionKey];
            [[NSUserDefaults standardUserDefaults] setValue:params[@"mobileNo"] forKey:kMobileNo];
            [[NSUserDefaults standardUserDefaults] synchronize];
            DLog(@"sessionKey:%@ mobileNo:%@", [[NSUserDefaults standardUserDefaults] valueForKey:kSessionKey], [[NSUserDefaults standardUserDefaults] valueForKey:kMobileNo]);
        }
        if (block) {
            block(response, showCaptcha, error);
        }
    }];
}

+ (void)registerOfSendMobileCode:(NSDictionary *)params block:(void (^)(id response, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_register_sendMobileCode params:params methodType:Get block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)getBackPasswordOfSendMobileCode:(NSDictionary *)params block:(void (^)(id response, BOOL showIdentify, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:user_getBackPassword_sendMobileCode params:params methodType:Get block:^(id response, NSError *error) {
        BOOL showIdentify = [response[@"nameAuthStatus"] integerValue];
        if (block) {
            block(response, showIdentify, error);
        }
    }];
}

+ (void)getPictureCode:(NSDictionary *)params block:(void (^)(UIImage *))block
{
    // todo：该接口应该为从服务器请求唯一识别码
//    [[NetAPIManager sharedNetAPIManager] requestWithPath:[user_picCode stringByAppendingPathComponent:@"1"] params:params methodType:Get block:^(id response, NSError *error) {
//        if (!error) {
            NSString * path = [[API_BASE_URL stringByAppendingPathComponent:user_picCode] stringByAppendingPathComponent:@"1"];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                UIImage * image = [UIImage imageWithData:data];
                if (block) {
                    block(image);
                }
            }];
//        }
//    }];
}

@end
