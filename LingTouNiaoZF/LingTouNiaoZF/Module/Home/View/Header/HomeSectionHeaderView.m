//
//  HomeSectionHeaderView.m
//  lingtouniao
//
//  Created by LiuFeifei on 16/5/20.
//  Copyright © 2016年 lingtouniao. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@interface HomeSectionHeaderView ()

@end

@implementation HomeSectionHeaderView

+ (HomeSectionHeaderView *)getHomeSectionHeaderViewWithTitle:(NSString *)title titleDetail:(NSString *)titleDetail
{
    HomeSectionHeaderView * homeSectionHeaderView = [[HomeSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSectionHeight) title:title titleDetail:titleDetail];
    homeSectionHeaderView.backgroundColor = [UIColor whiteColor];
    return homeSectionHeaderView;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title  titleDetail:(NSString *)titleDetail
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = kDarkColor333333;
        titleLabel.font = kFont18;
        titleLabel.text = title;
        [titleLabel sizeToFit];
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kCommonMargin);
            make.top.equalTo(@33);
            make.height.equalTo(@18);
        }];

//        if (esString(titleDetail) && ![titleDetail isEqualToString:@""]) {
//            kWeakSelf
//            UIButton * detailButton = [UIButton createButtonWithFrame:frame iconName:@"xiangqing" block:^(UIButton * button) {
//                kStrongSelf
//                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(showMore:)]) {
//                    [strongSelf.delegate showMore:self];
//                }
//            }];
//            detailButton.titleLabel.font = kFont18;
//            [detailButton setTitleColor:kDarkColor333333 forState:UIControlStateNormal];
//            [detailButton setTitle:titleDetail forState:UIControlStateNormal];
//            [detailButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -detailButton.imageView.size.width - 5, 0, detailButton.imageView.size.width + 5)];
//            [detailButton setImageEdgeInsets:UIEdgeInsetsMake(0, detailButton.titleLabel.bounds.size.width, 0, -detailButton.titleLabel.bounds.size.width)];
//            [self addSubview:detailButton];
        
        if (esString(titleDetail) && ![titleDetail isEqualToString:@""]) {
            kWeakSelf
            UIButton * detailButton = [UIButton createButtonWithTitle:[NSString stringWithFormat:@"%@>>", titleDetail] color:kDarkColor999999 font:kFont12 block:^(UIButton *button) {
                kStrongSelf
                if (strongSelf.delegate && [strongSelf.delegate respondsToSelector:@selector(showMore:)]) {
                    [strongSelf.delegate showMore:self];
                }
            }];
            [self addSubview:detailButton];
            [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-kCommonMargin);
                make.centerY.equalTo(titleLabel);
            }];
        }
    }
    return self;
}

@end
