//
//  BaseBannerCell.m
//  lingtouniao
//
//  Created by LiuFeifei on 16/5/23.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "BaseBannerCell.h"

@interface BaseBannerCell ()

@end

@implementation BaseBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bannerView = [[BannerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAdaptiveBaseIphone6(180)) marginBetweenTwoPages:kAdaptiveBaseIphone6(15) ratioOfOnePage:0.94 initialContentOffset:0.94 * kScreenWidth - kAdaptiveBaseIphone6(15) * 0.5 autoScroll:NO];
        self.bannerView.delegate = self;
        [self addSubview:self.bannerView];
    }
    return self;
}

- (void)setData:(id)data
{
    _data = data;
    if (data && isArray(data)) {
        self.bannerView.bannersList = (NSArray *)data;
    }
}

- (void)bannerView:(BannerView *)bannerView banner:(Banner *)banner
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBannerView:banner:)]) {
        [self.delegate clickBannerView:bannerView banner:banner];
    }
}

@end
