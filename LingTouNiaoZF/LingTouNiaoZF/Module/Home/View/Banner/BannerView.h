//
//  BannerVie.h
//  横幅
//
//  Created by LiuFeifei on 15/11/16.
//  Copyright © 2015年 lingtouniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Banner.h"

@class BannerView;
@protocol BannerViewDelegate <NSObject>

@optional

- (void)bannerView:(BannerView *)bannerView banner:(Banner *)banner;

@end

@interface BannerView : UIView

@property (nonatomic, weak) id<BannerViewDelegate> delegate;
@property (nonatomic, strong) NSArray * bannersList;
@property (nonatomic, assign) BOOL hiddenPageControl;

- (UIView *)bannerViewWithBanner:(Banner *)banner;
- (instancetype)initWithFrame:(CGRect)frame marginBetweenTwoPages:(CGFloat)marginBetweenTwoPages ratioOfOnePage:(CGFloat)ratioOfOnePage initialContentOffset:(CGFloat)initialContentOffset autoScroll:(BOOL)autoScroll;


@end
