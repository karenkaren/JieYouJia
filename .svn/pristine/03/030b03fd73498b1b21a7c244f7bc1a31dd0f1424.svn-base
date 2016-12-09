//
//  ApartmentModel.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApartmentModel : UITableViewCell

@property (nonatomic, copy) NSString * address; // 地址
@property (nonatomic, copy) NSString * des; // 描述
@property (nonatomic, copy) NSString * environment; // 周边环境
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, assign) double latitude;   //纬度
@property (nonatomic, assign) double longitude; // 经度
@property (nonatomic, copy) NSString * minPrice;    // 最低价格,原类型为number
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * picUrl;  //图片地址
@property (nonatomic, copy) NSString * traffic; //交通状况

+ (void)getApartmentListWithBlock:(void (^)(id response, NSArray * apartmentList, NSError *error))block;

@end
