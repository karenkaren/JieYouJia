//
//  Banner.h
//  lingtouniao
//
//  Created by LiuFeifei on 15/12/14.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : BaseModel

@property (nonatomic, assign) NSInteger bannerLocation; // banner位置
@property (nonatomic, copy) NSString * bannerName;  // 名称
@property (nonatomic, assign) NSInteger bannerStatus;   //状态
@property (nonatomic, copy) NSString * bannerUrl;       //图片地址
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString * linkUrl;     //跳转地址
@property (nonatomic, copy) NSString * updateTime;

+ (void)getBannerListWithBlock:(void (^)(id response, NSArray * bannerList, NSError *error))block;
+ (void)getActivityListWithBlock:(void (^)(id response, NSArray * activityList, NSError *error))block;

//// banner id
//@property (nonatomic, copy) NSString * bannerId;
//// banner名字
//@property (nonatomic, copy) NSString * bannerName;
//// Banner状态
//@property (nonatomic, assign) BOOL bannerState;
//// banner跳转地址
//@property (nonatomic, copy) NSString * bannerUrl;
//// banner内容
//@property (nonatomic, copy) NSString * bannerContent;
//// banner图片地址
//@property (nonatomic, copy) NSString * bannerPicture;
//// banner标题
//@property (nonatomic, copy) NSString * bannerTitle;
//// banner类型
//@property (nonatomic ,copy) NSString * forModel;
//
//
//// 是否分享 1表示分享，0表示不分享
//@property (nonatomic, assign) BOOL isShare;
//// 分享名字
//@property (nonatomic, copy) NSString * shareTitle;
//// 分享内容
//@property (nonatomic, copy) NSString * shareContent;
//// 分享图片
//@property (nonatomic, copy) NSString * sharePic;
//// 分享链接
//@property (nonatomic, copy) NSString * shareUrl;


@end

//@interface BannerList : BaseModel
//
//@property (nonatomic) NSArray * bannerList;
//
//@end
