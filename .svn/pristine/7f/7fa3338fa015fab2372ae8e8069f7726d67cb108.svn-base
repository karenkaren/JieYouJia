//
//  UserRegisterView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/22.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRegisterView.h"
#import "BaseLoginView.h"

#define kTimeCount 60
static NSInteger timeCount = kTimeCount;

@interface UserRegisterView ()

@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) BaseLoginView * baseLoginView;

@end

@implementation UserRegisterView

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        [self addNotifications];
    }
    return self;
}

#pragma mark - private methods
- (void)buildUI
{
    self.baseLoginView = [[BaseLoginView alloc] initWithLoginType:kLoginTypeOfRegister];
    [self addSubview:self.baseLoginView];
    
    self.telephoneTextField = self.baseLoginView.firstTextField;
    self.passwordTextField = self.baseLoginView.secondTextField;
    self.captchaTextField = self.baseLoginView.thirdTextField;
    self.captchaButton = self.baseLoginView.captchaButton;
    
    [self.baseLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.telephoneTextField.text.length && self.passwordTextField.text.length && self.captchaTextField.text.length;
    self.baseLoginView.loginFooterView.topButton.enabled = enabled;
}

#pragma mark - setter methods
- (void)setLoginClickBlock:(void (^)(UIButton *))loginClickBlock
{
    _loginClickBlock = loginClickBlock;
    if (loginClickBlock) {
        self.baseLoginView.rightClickBlock = loginClickBlock;
    }
}

- (void)setRegisterClickBlock:(void (^)(UIButton *))registerClickBlock
{
    _registerClickBlock = registerClickBlock;
    if (registerClickBlock) {
        self.baseLoginView.topClickBlock = registerClickBlock;
    }
}

- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.baseLoginView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
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
