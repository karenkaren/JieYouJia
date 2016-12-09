//
//  RegionSelectView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionSelectView : UIButton

@property (nonatomic, copy) NSString * regionName;

+ (instancetype)createRegionSelectViewWithFrame:(CGRect)frame actionBlock:(ButtonBlockAction)actionBlock;

@end
