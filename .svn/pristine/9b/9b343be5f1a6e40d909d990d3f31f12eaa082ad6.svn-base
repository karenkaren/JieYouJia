//
//  LoginFooterView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/22.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "LoginFooterView.h"

@implementation LoginFooterView

- (instancetype)initWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    self = [super init];
    if (self) {
        [self buildUIWithTitle:title leftTitle:leftTitle rightTitle:rightTitle];
    }
    return self;
}

- (void)buildUIWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle
{
    // 上部按钮
    UIButton * topButton = nil;
    if (![esString(title) isEqualToString:@""]) {
        topButton = [UIButton createButtonWithTitle:title color:[UIColor whiteColor] font:kFont18 block:^(UIButton * button) {
            if (self.topClickBlock) {
                self.topClickBlock(button);
            }
        }];
        topButton.layer.cornerRadius = 2.5;
        topButton.layer.masksToBounds = YES;
        [topButton setDisenableBackgroundColor:kHexColor(0xffdcc4) enableBackgroundColor:kBrightColorFF6600];
        [self addSubview:topButton];
        
        [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.width.equalTo(self);
            make.height.equalTo(@(kGeneralSize));
        }];
        self.maxHeight += kGeneralSize;
        self.topButton = topButton;
    }
    
    // 右下部按钮
    UIButton * rightButton = nil;
    if (![esString(rightTitle) isEqualToString:@""]) {
        rightButton = [UIButton createButtonWithTitle:rightTitle color:kDarkColorADADAD font:kFont14 block:^(UIButton * button) {
            if (self.rightClickBlock) {
                self.rightClickBlock(button);
            }
        }];
        [self addSubview:rightButton];
    }

    // 左下部按钮
    UIButton * leftButton = nil;
    if (![esString(leftTitle) isEqualToString:@""]) {
        leftButton = [UIButton createButtonWithTitle:leftTitle color:kDarkColorADADAD font:kFont14 block:^(UIButton * button) {
            if (self.leftClickBlock) {
                self.leftClickBlock(button);
            }
        }];
        [self addSubview:leftButton];
    }
    
    CGFloat spaceWithTopAndBottom = 23;
    if (leftButton && rightButton) {
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-13);
            make.top.equalTo(topButton.mas_bottom).offset(spaceWithTopAndBottom);
        }];
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(13);
            make.top.equalTo(topButton.mas_bottom).offset(spaceWithTopAndBottom);
        }];
        UIView * separateLine = [[UIView alloc] init];
        separateLine.backgroundColor = kDarkColorADADAD;
        [self addSubview:separateLine];
        [separateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@14);
            make.width.equalTo(@(kLineThick));
            make.centerY.equalTo(leftButton);
            make.centerX.equalTo(self);
        }];
    } else {
        [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(topButton);
            make.top.equalTo(topButton.mas_bottom).offset(spaceWithTopAndBottom);
        }];
        [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(topButton);
            make.top.equalTo(topButton.mas_bottom).offset(spaceWithTopAndBottom);
        }];
    }
    self.maxHeight += spaceWithTopAndBottom + MAX(rightButton.height, leftButton.height);
}

@end
