//
//  SortModel.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

#define kActivity @"activity"
#define kRecommend @"recommend"
#define kBrand @"brand"

@interface SortModel : BaseModel

@property (nonatomic, copy) NSString * code;    //楼层标志
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) NSInteger sortNo; //排序号
@property (nonatomic, copy) NSString * updateTime;

+ (void)getAppFloorListWithBlock:(void (^)(id response, NSArray * sortList, NSError *error))block;

@end
