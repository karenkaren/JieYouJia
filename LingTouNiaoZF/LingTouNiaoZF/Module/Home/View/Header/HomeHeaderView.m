//
//  HomeHeaderView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HomeHeaderView.h"
#import "BannerView.h"

@interface HomeHeaderView ()

@property (nonatomic, strong) BannerView * bannerView;

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptiveBaseIphone6(395))];
    if (self) {
        self.bannerView = [[BannerView alloc] initWithFrame:self.frame];
        [self addSubview:self.bannerView];
    }
    return self;
}

// 刷新头部
- (void)refreshWithBannerList:(NSArray *)bannerList
{
    self.bannerView.bannersList = bannerList;
}

@end
