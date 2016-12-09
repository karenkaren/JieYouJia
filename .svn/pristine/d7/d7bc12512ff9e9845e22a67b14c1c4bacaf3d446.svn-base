//
//  RegionSelectView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "RegionSelectView.h"

@implementation RegionSelectView

+ (instancetype)createRegionSelectViewWithFrame:(CGRect)frame actionBlock:(ButtonBlockAction)actionBlock
{
    RegionSelectView * button = (RegionSelectView *)[UIButton createButtonWithFrame:frame iconName:@"xiangqing" block:actionBlock];
    button.titleLabel.font = kFont18;
    [button setTitleColor:kDarkColor333333 forState:UIControlStateNormal];
    [button setTitle:@"上海" forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.size.width - 5, 0, button.imageView.size.width + 5)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
    return button;
}

@end
