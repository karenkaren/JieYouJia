//
//  UserRetrieveController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRetrieveController.h"
#import "UserRetrieveView.h"
#import "UserModifyController.h"
#import "LoginModel.h"

@interface UserRetrieveController ()

@property (nonatomic, strong) UserRetrieveView * userRetrieveView;

@end

@implementation UserRetrieveController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.userRetrieveView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找回密码";
    
    // 添加视图
    UserRetrieveView * userRetrieveView = [[UserRetrieveView alloc] init];
    [self.view addSubview:userRetrieveView];
    [userRetrieveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userRetrieveView = userRetrieveView;
    
    // 添加方法
    userRetrieveView.retrieveClickBlock = ^(UIButton *button) {
        [self nextSubmit:button];
    };
    userRetrieveView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit];
    };
}

- (void)nextSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userRetrieveView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机格式错误"];
        return;
    }
    
    if (![NSString isPureInterger:self.userRetrieveView.captchaTextField.text]) {
        [NSObject showHudTipStr:@"验证码格式错误"];
        return;
    }
    
    if (!self.userRetrieveView.identityTextField.hidden) {
        if (![NSString isValidIDCardNumber:self.userRetrieveView.captchaTextField.text]) {
            [NSObject showHudTipStr:@"身份证号错误"];
            return;
        }
    }
    
    NSMutableDictionary * params = @{@"mobileNo" : self.userRetrieveView.telephoneTextField.text,
                                     @"mobileCode" : self.userRetrieveView.captchaTextField.text
                                     }.mutableCopy;
    if (!self.userRetrieveView.identityTextField.hidden) {
        [params setValue:self.userRetrieveView.identityTextField.text forKey:@"idCard"];
    }
    
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel doGetBackPasswordCheck:params block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            UserModifyController * modifyController = [[UserModifyController alloc] init];
            modifyController.params = params;
            [self.navigationController pushViewController:modifyController animated:YES];
        }
    }];
}

- (void)getCaptchaSubmit
{
    if (![NSString isPhoneNumber:self.userRetrieveView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机格式错误"];
        return;
    }
    
    [self.userRetrieveView startTimer];
    NSDictionary * params = @{@"mobileNo" : self.userRetrieveView.telephoneTextField.text};
    
    [self showWaitingIcon];
    [LoginModel getBackPasswordOfSendMobileCode:params block:^(id response, BOOL showIdentify, NSError *error) {
        [self dismissWaitingIcon];
        self.userRetrieveView.showIdentityDialog = showIdentify;
    }];
}
@end
