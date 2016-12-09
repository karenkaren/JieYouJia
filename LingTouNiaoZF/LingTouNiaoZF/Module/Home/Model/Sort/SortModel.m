//
//  SortModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "SortModel.h"

@implementation SortModel

+ (void)getAppFloorListWithBlock:(void (^)(id response, NSArray * sortList, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:homepage_homepageinfo_omsAppFloorList params:nil methodType:Get block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        NSArray * sortList = [SortModel mj_objectArrayWithKeyValuesArray:dto.data];
        if (block) {
            block(response, sortList, error);
        }
    }];
}

@end
