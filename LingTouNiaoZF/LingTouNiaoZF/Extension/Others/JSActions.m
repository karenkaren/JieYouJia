//
//  JSActions.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "JSActions.h"

@implementation JSActions

- (void)clientType:(NSDictionary *)dictionary
{
    NSString * callback = [self getCallbackWithDictionary:dictionary];
    [self excuteCallback:callback params:@{@"clientType" : @"I"} completionHandler:^(NSError *error) {
        [NSObject showError:error];
    }];
}

@end
