//
//  RecommendBanner.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "RecommendBanner.h"

@implementation RecommendBanner

+ (void)getRecommendListWithBlock:(void (^)(id response, NSArray * recommendList, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:homepage_homepageinfo_prodStyleList params:nil methodType:Get block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        NSArray * recommendList = [RecommendBanner mj_objectArrayWithKeyValuesArray:dto.data];
        for (RecommendBanner * banner in recommendList) {
            banner.bannerUrl = banner.picUrl;
        }
        if (block) {
            block(response, recommendList, error);
        }
    }];
}

@end
