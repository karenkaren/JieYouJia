//
//  ApartmentModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ApartmentModel.h"

@implementation ApartmentModel
+ (void)getApartmentListWithBlock:(void (^)(id response, NSArray * apartmentList, NSError *error))block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:homepage_homepageinfo_apartmentList params:nil methodType:Get block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        NSArray * apartmentList = [ApartmentModel mj_objectArrayWithKeyValuesArray:dto.data];
        if (block) {
            block(response, apartmentList, error);
        }
    }];
}

@end
