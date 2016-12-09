//
//  UserRegisterController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/10.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserRegisterController.h"
#import "UserRegisterView.h"
#import "LoginModel.h"

@interface UserRegisterController ()

@property (nonatomic, strong) UserRegisterView * userRegisterView;

@end

@implementation UserRegisterController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.userRegisterView stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    // 添加视图
    UserRegisterView * userRegisterView = [[UserRegisterView alloc] init];
    [self.view addSubview:userRegisterView];
    [userRegisterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userRegisterView = userRegisterView;
    
    // 添加方法
    userRegisterView.loginClickBlock = ^(UIButton *button) {
        [self loginSubmit];
    };
    userRegisterView.registerClickBlock = ^(UIButton *button) {
        [self registerSubmit:button];
    };
    userRegisterView.getCaptchaClickBlock = ^(UIButton *button) {
        [self getCaptchaSubmit];
    };
}

- (void)registerSubmit:(UIButton *)button
{
    if (![NSString isPhoneNumber:self.userRegisterView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机号输入不规范，请重新输入！"];
        return;
    }
    
    if (![NSString isPassword:self.userRegisterView.passwordTextField.text]) {
        [NSObject showHudTipStr:@"密码必须为6-18位数字和字母组合"];
        return;
    }
    
    if (![NSString isPureInterger:self.userRegisterView.captchaTextField.text]) {
        [NSObject showHudTipStr:@"验证码输入错误，请重新输入！"];
        return;
    }
    
    NSDictionary * params = @{@"mobileNo" : self.userRegisterView.telephoneTextField.text,
                              @"userPwd" : self.userRegisterView.passwordTextField.text,
                              @"mobileCode" : self.userRegisterView.captchaTextField.text
                              };
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel doRegister:params block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)loginSubmit
{
    [self back];
    
//    NSArray * controllers = [self.navigationController childViewControllers];
//    NSInteger controllersCount = controllers.count;
//    if (controllersCount >= 2) {
//        UIViewController * lastController = controllers[controllersCount - 2];
//        if (lastController isKindOfClass:[]) {
//            <#statements#>
//        }
//    }
}

- (void)getCaptchaSubmit
{
    if (![NSString isPhoneNumber:self.userRegisterView.telephoneTextField.text]) {
        [NSObject showHudTipStr:@"手机格式错误"];
        return;
    }
    [self.userRegisterView startTimer];
    NSDictionary * params = @{@"mobileNo" : self.userRegisterView.telephoneTextField.text};
    [LoginModel registerOfSendMobileCode:params block:nil];
}

@end
