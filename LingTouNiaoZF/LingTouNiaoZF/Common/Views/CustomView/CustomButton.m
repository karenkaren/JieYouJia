//
//  CustomButton.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/7.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

#pragma mark - 带背景色的button
+ (instancetype)createBigBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createMiddleBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(341)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createSmallBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBGButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(200)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createBGButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [[CustomButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:kFont18];
    [button sizeToFit];
    button.tappedBlock = actionBolck;
    [button setDisenableBackgroundColor:kHexColor(0xffdcc4) enableBackgroundColor:kBrightColorFF6600];
    [button setImage:[UIImage imageWithColor:kHexColor(0xffdcc4)] forState:UIControlStateDisabled];
    [button setImage:[UIImage imageWithColor:kBrightColorFF6600] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithColor:kBrightColorFF6600] forState:UIControlStateSelected];
    return button;
}

#pragma mark - 描边button
+ (instancetype)createBigBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createMiddleBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(341)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createSmallBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [CustomButton createBorderButtonWithTitle:title actionBolck:actionBolck];
    button.layer.cornerRadius = 2.5;
    button.layer.masksToBounds = YES;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(kAdaptiveBaseIphone6(200)));
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    return button;
}

+ (instancetype)createBorderButtonWithTitle:(NSString *)title actionBolck:(ButtonBlockAction)actionBolck
{
    CustomButton * button = [[CustomButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:kBrightColorFF6600 forState:UIControlStateNormal];
    [button.titleLabel setFont:kFont18];
    [button sizeToFit];
    button.tappedBlock = actionBolck;

    button.layer.borderWidth = 1.0 / kScreenScale;
    [button setBackgroundImage:[UIImage imageWithColor:kBrightColorFF6600] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button setTitleColor:kHexColor(0xffdcc4) forState:UIControlStateDisabled];

    return button;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (self.layer.borderWidth) {
        self.layer.borderColor = enabled ? kBrightColorFF6600.CGColor : kHexColor(0xffdcc4).CGColor;
    }
}

@end
