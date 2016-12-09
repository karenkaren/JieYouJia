//
//  UserRetrieveView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRetrieveView.h"
#import "BaseLoginView.h"

#define kTextFieldHeight kGeneralSize
#define kTimeCount 20
static NSInteger timeCount = kTimeCount;

@interface UserRetrieveView ()

@property (nonatomic, strong) BaseLoginView * baseLoginView;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation UserRetrieveView

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
    self.baseLoginView = [[BaseLoginView alloc] initWithLoginType:kLoginTypeOfRetrieve];
    [self addSubview:self.baseLoginView];
    
    self.telephoneTextField = self.baseLoginView.firstTextField;
    self.captchaTextField = self.baseLoginView.secondTextField;
    self.identityTextField = self.baseLoginView.thirdTextField;
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
    BOOL enabled = self.telephoneTextField.text.length && self.captchaTextField.text.length;
    if (!self.identityTextField.hidden) {
        enabled = enabled && self.identityTextField.text.length;
    }
    self.baseLoginView.loginFooterView.topButton.enabled = enabled;
}

- (void)upateTimer
{
    NSString * timeString = [NSString stringWithFormat:@"%ld秒后重新获取", timeCount--];
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

#pragma mark - setter methods
- (void)setRetrieveClickBlock:(void (^)(UIButton *))retrieveClickBlock
{
    _retrieveClickBlock = retrieveClickBlock;
    if (retrieveClickBlock) {
        self.baseLoginView.loginFooterView.topClickBlock = retrieveClickBlock;
    }
}

- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.baseLoginView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
}

- (void)setShowIdentityDialog:(BOOL)showIdentityDialog
{
    if (_showIdentityDialog == showIdentityDialog) {
        return;
    }
    _showIdentityDialog = showIdentityDialog;
    self.baseLoginView.showThirdDialog = showIdentityDialog;
}

@end
