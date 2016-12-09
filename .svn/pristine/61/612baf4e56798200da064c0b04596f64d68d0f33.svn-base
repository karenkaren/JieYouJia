//
//  ResultHeader.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "ResultHeader.h"

@implementation ResultHeader

+ (instancetype)createResultHeaderWithTitle:(NSString *)title success:(BOOL)success
{
    ResultHeader * resultHeader = [[ResultHeader alloc] init];
    [resultHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 78));
    }];
    
    NSString * resultIconName = success ? @"success" : @"failure";
    UIImageView * resultImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:resultIconName]];
    [resultHeader addSubview:resultImageView];
    
    UILabel * resultLabel = [[UILabel alloc] init];
    resultLabel.text = title;
    resultLabel.font = kFont18;
    resultLabel.textColor = kBrightColorFF6600;
    [resultLabel sizeToFit];
    [resultHeader addSubview:resultLabel];
    
    [resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(resultHeader);
    }];
    
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.bottom.centerX.equalTo(resultHeader);
    }];
    
    return resultHeader;
}

@end
