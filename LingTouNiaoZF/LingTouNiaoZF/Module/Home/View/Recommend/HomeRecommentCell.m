//
//  HomeRecommentCell.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/1.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HomeRecommentCell.h"
#import "HomeRecommendBannerView.h"

@implementation HomeRecommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bannerView = [[HomeRecommendBannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kHomeRecommentCellHeight) marginBetweenTwoPages:kAdaptiveBaseIphone6(8) ratioOfOnePage:0.94 initialContentOffset:0.94 * kScreenWidth - kAdaptiveBaseIphone6(8) * 0.5 autoScroll:NO];
        self.bannerView.hiddenPageControl = YES;
        self.bannerView.delegate = self;
        [self addSubview:self.bannerView];
    }
    return self;
}

@end
