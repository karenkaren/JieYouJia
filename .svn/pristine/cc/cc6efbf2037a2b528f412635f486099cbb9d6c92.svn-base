//
//  RecommendBanner.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "Banner.h"

@interface RecommendBanner : Banner

@property (nonatomic, copy) NSString * minPrice;    // 最低价格,原类型为number
@property (nonatomic, copy) NSString * picUrl;       // 图片地址
@property (nonatomic, assign) NSInteger prodType;   //产品类型 1：整租；2：合租
@property (nonatomic, copy) NSString * title;   // 标题

+ (void)getRecommendListWithBlock:(void (^)(id response, NSArray * recommendList, NSError *error))block;

@end
