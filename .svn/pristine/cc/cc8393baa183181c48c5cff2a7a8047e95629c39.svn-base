//
//  CaptchaView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

@interface CaptchaView : UIView

@property (nonatomic, strong) CustomTextField * captchaTextField;
@property (nonatomic, strong) UIButton * captchaButton;
@property (nonatomic, copy) void(^getCaptchaClickBlock)(UIButton *button);

- (instancetype)initWithMessageCode:(BOOL)messageCode limitedCount:(NSInteger)limitedCount;

- (void)startTimer;
- (void)stopTimer;

@end
