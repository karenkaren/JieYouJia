//
//  HomeRecommendBannerView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/2.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "HomeRecommendBannerView.h"
#import "RecommendBanner.h"

@implementation HomeRecommendBannerView

- (UIView *)bannerViewWithBanner:(Banner *)banner
{
    if (![banner isKindOfClass:[RecommendBanner class]]) {
        return nil;
    }
    RecommendBanner * recommendBanner = (RecommendBanner *)banner;
    UIView * bannerView = [[UIView alloc] init];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    // TODO:
    imageView.image = [UIImage imageNamed:banner.bannerUrl];
    [bannerView addSubview:imageView];
    
    UILabel * apartmentName = [[UILabel alloc] init];
    apartmentName.font = kFont16;
    apartmentName.textColor = kDarkColor333333;
    apartmentName.text = recommendBanner.title;
    [apartmentName sizeToFit];
    [bannerView addSubview:apartmentName];
    
    UILabel * apartmentArea = [[UILabel alloc] init];
    apartmentArea.font = kFont12;
    apartmentArea.textColor = kDarkColor878787;
    apartmentArea.text = @"面积：28m起";
    [apartmentArea sizeToFit];
    [bannerView addSubview:apartmentArea];
    
    UILabel * apartmentPrice = [[UILabel alloc] init];
    apartmentPrice.font = kFont12;
    apartmentPrice.textColor = kBrightColorFF6600;
    apartmentPrice.text = [NSString stringWithFormat:@"¥%@起", recommendBanner.minPrice];
    [apartmentPrice sizeToFit];
    [bannerView addSubview:apartmentPrice];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bannerView);
        make.width.equalTo(imageView.mas_height).multipliedBy(680.0 / 420.0);
        make.width.top.equalTo(bannerView);
    }];
    
    [apartmentName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView).offset(kAdaptiveBaseIphone6(15));
        make.bottom.equalTo(bannerView);
        make.height.equalTo(@16);
//        make.top.equalTo(imageView.mas_bottom).offset(10);
    }];
    
    [apartmentArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(apartmentName.mas_right).offset(15);
        make.centerY.equalTo(apartmentName);
    }];
    
    [apartmentPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageView).offset(-kAdaptiveBaseIphone6(15));
        make.centerY.equalTo(apartmentName);
    }];
    
    return bannerView;
}

- (void)tap:(UIGestureRecognizer *)recognizer
{
    if (!self.bannersList.count) return;
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerView:banner:)]) {
        UIView * bannerView = recognizer.view;
        RecommendBanner * banner = self.bannersList[bannerView.tag];
        [self.delegate bannerView:self banner:banner];
    }
}

@end