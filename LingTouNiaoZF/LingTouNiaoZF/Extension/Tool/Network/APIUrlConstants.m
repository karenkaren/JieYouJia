//
//  APIUrlConstants.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "APIUrlConstants.h"

#pragma mark - url
#pragma mark -- 用户服务
NSString * const user_register_sendMobileCode = @"/user/register/sendMobileCode";
NSString * const user_register_submit = @"/user/register/submit";
NSString * const user_getBackPassword_sendMobileCode = @"/user/getBackPassword/sendMobileCode";
NSString * const user_getBackPassword_submit = @"/user/getBackPassword/submit";
NSString * const user_login = @"/user/login";
NSString * const user_picCode = @"/picCode";
NSString * const user_getBackPassword_check = @"/user/getBackPassword/checkMobileCodeAndIdCard";

#pragma mark -- 业务服务
// 首页
NSString * const homepage_homepageinfo_omsAppFloorList = @"/homepage/homepageinfo/omsAppFloorList";
NSString * const homepage_homepageinfo_bannerList = @"/homepage/homepageinfo/bannerList";
NSString * const homepage_homepageinfo_prodStyleList = @"/homepage/homepageinfo/prodStyleList";
NSString * const homepage_homepageinfo_activityList = @"/homepage/homepageinfo/activityList";
NSString * const homepage_homepageinfo_apartmentList = @"/homepage/homepageinfo/apartmentList";
// 绑卡
//NSString * const pay_choiceBankCard = @"/pay/choiceBankCard";
NSString * const pay_bankList = @"/pay/bankList";
NSString * const usr_checkIdCard = @"/usr/checkIdCard";
NSString * const usr_bindCard = @"/usr/bindCard";
NSString * const usr_confirmBindCard = @"/usr/confirmBindCard";

#pragma mark - h5

@implementation APIUrlConstants

+ (NSArray *)getCachePaths
{
    NSArray * cachePaths = @[@""];
    return cachePaths;
}

@end
