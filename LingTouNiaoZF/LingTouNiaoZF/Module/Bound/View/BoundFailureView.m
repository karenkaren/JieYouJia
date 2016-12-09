//
//  BoundFailureView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BoundFailureView.h"
#import "ResultHeader.h"

@interface BoundFailureView ()

@property (nonatomic, copy) NSString * failureReason;

@end

@implementation BoundFailureView

- (instancetype)initWithFailureReason:(NSString *)reason
{
    self = [super init];
    if (self) {
        self.failureReason = reason;
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    ResultHeader * successView = [ResultHeader createResultHeaderWithTitle:@"很遗憾，添加失败！" success:NO];
    [self addSubview:successView];
    
    UILabel * reasonLabel = [[UILabel alloc] init];
    reasonLabel.text = self.failureReason;
    reasonLabel.font = kFont12;
    reasonLabel.textColor = kDarkColor878787;
    [reasonLabel sizeToFit];
    [self addSubview:reasonLabel];
    
    UIButton * reboundButton = [CustomButton createMiddleBorderButtonWithTitle:@"重新添加" actionBolck:^(UIButton *button) {
        
    }];
    [self addSubview:reboundButton];
    
    UIButton * helpButton = [CustomButton createMiddleBGButtonWithTitle:@"查看帮助" actionBolck:^(UIButton *button) {
        
    }];
    [self addSubview:helpButton];
    
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@32);
        make.left.equalTo(self);
    }];
    
    [reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(successView.mas_bottom).offset(11);
        make.height.equalTo(@12);
        make.centerX.equalTo(successView);
    }];
    
    [reboundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reasonLabel.mas_bottom).offset(25);
        make.centerX.equalTo(reasonLabel);
    }];
    
    [helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reboundButton.mas_bottom).offset(15);
        make.centerX.equalTo(reboundButton);
    }];
}

@end
