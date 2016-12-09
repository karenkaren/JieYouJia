//
//  MessageCodeController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MessageCodeController.h"
#import "CaptchaView.h"
#import "LoginFooterView.h"
#import "TableViewDevider.h"
#import "BoundSuccessController.h"
#import "BoundFailureController.h"
#import "BoundModel.h"

@interface MessageCodeController ()

@property (nonatomic, strong) CaptchaView * captchaView;

@end

@implementation MessageCodeController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.captchaView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写短信验证码";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimeCount:) name:@"TimerCountDown" object:nil];
    [self buildUI];
}

- (void)buildUI
{
    UIView * headerView = [TableViewDevider getViewWithHeight:40 margin:kCommonMargin showTopLine:NO showBottomLine:YES title:[NSString stringWithFormat:@"请输入手机号%@收到的短信验证码", esString(self.params[@"mobile"])]];
    [self.view addSubview:headerView];
    
    CaptchaView * captchaView = [[CaptchaView alloc] initWithMessageCode:YES limitedCount:4];
//    captchaView.frame = CGRectMake(kCommonMargin, headerView.bottom, self.view.width - 2 * kCommonMargin, kAdaptiveBaseIphone6(45));
    [self.view addSubview:captchaView];
    
    [captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kCommonMargin));
        make.width.equalTo(self.view).offset(-2 * kCommonMargin);
        make.top.equalTo(headerView.mas_bottom);
        make.height.equalTo(@(kAdaptiveBaseIphone6(45)));
    }];
    
    self.captchaView = captchaView;
    
    captchaView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit];
    };
    
    UIButton * submitButton = [CustomButton createMiddleBGButtonWithTitle:@"下一步" actionBolck:^(UIButton *button) {
        [self submitClick:button];
    }];
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(captchaView.mas_bottom).offset(kAdaptiveBaseIphone6(25));
        make.left.equalTo(@(kCommonMargin));
    }];
}

- (void)updateTimeCount:(NSNotification *)notification
{
    self.captchaView.captchaButton.enabled = NO;
    NSString * captchaString = nil;
    NSInteger timeCount = [notification.object integerValue];
    if (timeCount < 0) {
        self.captchaView.captchaButton.enabled = YES;
        captchaString = @"获取短信验证码";
        [self.captchaView.captchaButton setTitle:captchaString forState:UIControlStateNormal];
    } else {
        self.captchaView.captchaButton.enabled = NO;
        captchaString = [NSString stringWithFormat:@"%@秒后重新获取", notification.object];
        [self.captchaView.captchaButton setTitle:captchaString forState:UIControlStateDisabled];
    }
}

- (void)getCaptchaSubmit
{
    [self.captchaView startTimer];
    [BoundModel bindCard:self.params block:nil];
}

- (void)submitClick:(UIButton *)button
{
    NSString * verifyCode = self.captchaView.captchaTextField.text;
    if (![NSString isPureInterger:verifyCode]) {
        [NSObject showHudTipStr:@"数据格式错误"];
        return;
    }
    NSDictionary * params = @{@"verifyCode" : verifyCode};
    [BoundModel confirmBindCard:params block:^(id response, NSError *error) {
        if (!error) {
            BoundSuccessController * successController = [[BoundSuccessController alloc] init];
            [self.navigationController pushViewController:successController animated:YES];
        }
    }];
}

@end
