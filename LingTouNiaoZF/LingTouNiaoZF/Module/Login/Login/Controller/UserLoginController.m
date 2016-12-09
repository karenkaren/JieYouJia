//
//  UserLoginController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserLoginController.h"
#import "UserLoginView.h"
#import "UserRegisterController.h"
#import "LoginModel.h"
#import "UserRetrieveController.h"
#import "BaseNavigationController.h"

#define kMaxFailureCount 5

@interface UserLoginController ()

@property (nonatomic, strong) UserLoginView * userLoginView;

@end

@implementation UserLoginController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.baseNavigationController hideBorder:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.baseNavigationController hideBorder:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showCloseButton:YES];
    
    // 添加视图
    UserLoginView * userLoginView = [[UserLoginView alloc] init];
    [self.view addSubview:userLoginView];
    [userLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userLoginView = userLoginView;
    
    // 添加方法
    userLoginView.loginClickBlock = ^(UIButton *button) {
        [self loginSubmit:button];
    };
    userLoginView.forgetClickBlock = ^(UIButton *button) {
        [self forgetSubmit];
    };
    userLoginView.registerClickBlock = ^(UIButton *button) {
        [self registerSubmit];
    };
    userLoginView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit:button];
    };
}

- (void)loginSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userLoginView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"请输入正确的手机号"];
        return;
    }
    
    if (![NSString isPassword:self.userLoginView.passwordTextField.text]) {
        [NSObject showHudTipStr:@"密码应该为6-18位字母与数字组合"];
        return;
    }
    
    if (!self.userLoginView.captchaTextField.hidden) {
        if (![NSString isPureInterger:self.userLoginView.captchaTextField.text]) {
            [NSObject showHudTipStr:@"验证码输入错误，请重新输入"];
            return;
        }
    }

    NSMutableDictionary * params = @{@"mobileNo" : self.userLoginView.telephoneTextField.text,
                                     @"userPwd" : self.userLoginView.passwordTextField.text}.mutableCopy;
    if (!self.userLoginView.captchaTextField.hidden) {
        [params setValue:self.userLoginView.captchaTextField.text forKey:@"picCode"];
        [params setValue:@"1" forKey:@"machineNo"];
    }
    
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel doLogin:params block:^(id response, BOOL showCaptcha, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        self.userLoginView.showCaptchDialog = showCaptcha;
        if (error) {
            if (showCaptcha) {
                self.userLoginView.captchaTextField.text = @"";
                [self getCaptchaSubmit:nil];
            }
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)forgetSubmit
{
    DLog(@"forget");
    UserRetrieveController * retrieveController = [[UserRetrieveController alloc] init];
    [self.navigationController pushViewController:retrieveController animated:YES];
}

- (void)registerSubmit
{
    DLog(@"register");
    UserRegisterController * registerController = [[UserRegisterController alloc] init];
    [self.navigationController pushViewController:registerController animated:YES];
}

- (void)getCaptchaSubmit:(UIButton *)button
{
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel getPictureCode:nil block:^(UIImage *image) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (image) {
            [self.userLoginView.captchaButton setImage:image forState:UIControlStateNormal];
        }
    }];
}

@end
