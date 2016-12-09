//
//  BoundModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/7.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BoundModel.h"

@implementation BoundModel

+ (void)checkIdentify:(NSDictionary *)params block:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:usr_checkIdCard params:params methodType:Post block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        if (block) {
            block(response, dto.data, error);
        }
    }];
}

+ (void)bindCard:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:usr_bindCard params:params methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

+ (void)confirmBindCard:(NSDictionary *)params block:(APIResultBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:usr_confirmBindCard params:params methodType:Post block:^(id response, NSError *error) {
        if (block) {
            block(response, error);
        }
    }];
}

@end
