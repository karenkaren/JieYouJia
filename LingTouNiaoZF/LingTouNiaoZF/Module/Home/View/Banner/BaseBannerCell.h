//
//  BaseBannerCell.h
//  lingtouniao
//
//  Created by LiuFeifei on 16/5/23.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerView.h"

@protocol BaseBannerCellDelegate <NSObject>

- (void)clickBannerView:(BannerView *)bannerView banner:(Banner *)banner;

@end

@interface BaseBannerCell : UITableViewCell<BannerViewDelegate>

@property (nonatomic, weak) id<BaseBannerCellDelegate> delegate;
@property (nonatomic, strong) id data;
@property (nonatomic, strong) BannerView * bannerView;

@end
