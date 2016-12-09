//
//  CaptchaView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CaptchaView.h"

#define kTimeCount 20
static NSInteger timeCount = kTimeCount;

@interface CaptchaView ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, assign) NSInteger limitedCount;
@property (nonatomic, assign, getter=isMessageCode) BOOL isMessageCode;

@end

@implementation CaptchaView

- (instancetype)initWithMessageCode:(BOOL)messageCode limitedCount:(NSInteger)limitedCount
{
    self = [super init];
    if (self) {
        self.isMessageCode = messageCode;
        self.limitedCount = limitedCount;
        [self buildUI];
    }
    return self;
}

- (void)buildUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.captchaTextField];
    self.captchaTextField.limitedCount = self.limitedCount;
    
    if (!self.isMessageCode) {
        self.captchaButton = [UIButton createButtonWithFrame:CGRectZero iconName:@"shuaxinzhanwei" block:^(UIButton *button) {
            if (self.getCaptchaClickBlock) {
                self.getCaptchaClickBlock(button);
            }
        }];
    } else {
        self.captchaButton = [UIButton createButtonWithTitle:@"获取短信验证码" color:kHexColor(0x288bff) font:kFont12 block:^(UIButton * button) {
            if (self.getCaptchaClickBlock) {
                self.getCaptchaClickBlock(button);
            }
        }];
        [self.captchaButton setTitleColor:kDarkColorADADAD forState:UIControlStateDisabled];
    }
    [self addSubview:self.captchaButton];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kLineColorD8D8D8;
    [self addSubview:bottomLine];
    
    UIView * verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = kLineColorD8D8D8;
    [self addSubview:verticalLine];
    
    CGFloat captchaButtonWidth;
    if (!self.isMessageCode) {
        captchaButtonWidth = 50;
    } else {
        captchaButtonWidth = 100;
    }
    [self.captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-captchaButtonWidth);
        make.top.left.height.equalTo(self);
    }];
    [self.captchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.captchaTextField);
        make.width.equalTo(@(captchaButtonWidth));
        make.top.right.equalTo(self);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(self.captchaButton);
        make.height.equalTo(@(kLineThick));
    }];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.captchaButton);
        make.width.equalTo(@(kLineThick));
        make.height.equalTo(self).offset(-20);
    }];
}

- (CustomTextField *)captchaTextField
{
    if (!_captchaTextField) {
        _captchaTextField = [[CustomTextField alloc] initWithLeftIconName:@"yanzhengma" placeHolder:@"请输入短信验证码"];
        _captchaTextField.drawBottomLine = YES;
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _captchaTextField;
}

- (void)upateTimer
{
    NSString * timeString = [NSString stringWithFormat:@"%ld秒后重新获取", (long)timeCount--];
    [self.captchaButton setTitle:timeString forState:UIControlStateDisabled];
    if (timeCount < 0) {
        [self stopTimer];
    }
}

- (void)startTimer
{
    self.captchaButton.enabled = NO;
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(upateTimer) userInfo:nil repeats:YES];
    }
    [self.timer fire];
}

- (void)stopTimer
{
    if(self.timer) {
        [self.timer invalidate];
        self.timer = nil;
        timeCount = kTimeCount;
    }
    if(self.captchaButton){
        self.captchaButton.enabled = YES;
        [self.captchaButton setTitle:@"获取短信验证码" forState:UIControlStateNormal];
    }
}

@end