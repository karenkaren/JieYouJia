//
//  HomeModel.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

#define kSortNo @"sortNo"
#define kData @"data"

@interface HomeModel : BaseModel

@property (nonatomic, strong) NSDictionary * activityDic;
@property (nonatomic, strong) NSDictionary * recommendDic;
@property (nonatomic, strong) NSDictionary * apartmentDic;

@end
