//
//  NetAPIManager.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/10/26.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger, NetworkMethod) {
    Get = 0,
    Post
};

@interface NetAPIManager : AFHTTPSessionManager

singleton_interface(NetAPIManager)

- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
                  block:(void (^)(id response, NSError *error))block;
- (void)requestWithPath:(NSString *)path
                 params:(NSDictionary *)params
             methodType:(NetworkMethod)methodType
          autoShowError:(BOOL)autoShowError
                  block:(void (^)(id response, NSError *error))block;

@end
