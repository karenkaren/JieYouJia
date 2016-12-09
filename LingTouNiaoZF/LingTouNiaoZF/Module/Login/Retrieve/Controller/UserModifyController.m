//
//  UserModifyController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserModifyController.h"
#import "UserModifyView.h"
#import "LoginModel.h"

@interface UserModifyController ()

@property (nonatomic, strong) UserModifyView * userModifyView;

@end

@implementation UserModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重设密码";
    // 添加视图
    UserModifyView * userModifyView = [[UserModifyView alloc] init];
    [self.view addSubview:userModifyView];
    [userModifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.userModifyView = userModifyView;
    
    // 添加方法
    userModifyView.modifyClickBlock = ^(UIButton *button) {
        [self modifySubmit:button];
    };
}

- (void)modifySubmit:(UIButton *)button
{
    NSString * password = self.userModifyView.passwordTextField.text;
    NSString * passwordAgain = self.userModifyView.passwordAgainTextField.text;
    if (![password isEqualToString:passwordAgain]) {
        [NSObject showHudTipStr:@"两次密码不一致，请重新输入"];
        return;
    }
    
    if (![NSString isPassword:password]) {
        [NSObject showHudTipStr:@"密码应该为6-18位字母和数字组合"];
        return;
    }

    [self.params setValue:password forKey:@"userPwd"];
    
    [self showWaitingIcon];
    button.enabled = NO;
    [LoginModel doGetBackPassword:self.params block:^(id response, NSError *error) {
        [self dismissWaitingIcon];
        button.enabled = YES;
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
