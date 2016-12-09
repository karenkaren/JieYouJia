//
//  Banner.m
//  lingtouniao
//
//  Created by LiuFeifei on 15/12/14.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import "Banner.h"

@implementation Banner

+ (void)getBannerListWithBlock:(void (^)(id response, NSArray * bannerList, NSError *error))block
{
    NSString * path = homepage_homepageinfo_bannerList;
    [self getListWithPath:path block:block];
}

+ (void)getActivityListWithBlock:(void (^)(id response, NSArray * activityList, NSError *error))block
{
    NSString * path = homepage_homepageinfo_bannerList;
    [self getListWithPath:path block:block];
}

+ (void)getListWithPath:(NSString *)path block:(void (^)(id response, NSArray * list, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:homepage_homepageinfo_bannerList params:nil methodType:Get block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        NSArray * list = [Banner mj_objectArrayWithKeyValuesArray:dto.data];
        if (block) {
            block(response, list, error);
        }
    }];
}

@end

//@implementation BannerList
//
//+ (NSDictionary *)mj_objectClassInArray
//{
//    return @{ @"bannerList" : [Banner class] };
//}
//
//@end
