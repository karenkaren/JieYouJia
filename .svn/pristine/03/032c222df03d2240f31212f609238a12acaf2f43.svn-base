//
//  HomeSectionHeaderView.h
//  lingtouniao
//
//  Created by LiuFeifei on 16/5/20.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GoldenEggButton.h"

#define kSectionHeight 69

@class HomeSectionHeaderView;
@protocol HomeSectionHeaderViewDelegate <NSObject>

- (void)showMore:(HomeSectionHeaderView *)sectionHeaderView;

@end

@interface HomeSectionHeaderView : UIView

+ (HomeSectionHeaderView *)getHomeSectionHeaderViewWithTitle:(NSString *)title titleDetail:(NSString *)titleDetail;

@property (nonatomic, weak) id<HomeSectionHeaderViewDelegate> delegate;
@property (nonatomic, copy) NSString * classString;

@end
