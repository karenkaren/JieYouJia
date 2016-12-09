//
//  UserLoginView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/1.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserLoginView.h"
#import "BaseLoginView.h"

@interface UserLoginView ()

@property (nonatomic, strong) BaseLoginView * baseLoginView;
@property (nonatomic, strong) UIView * footerView;
@property (nonatomic, strong) UIView * headerView;

@end

@implementation UserLoginView

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

- (void)buildUI
{
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kAdaptiveBaseIphone6(160)));
        make.width.top.left.equalTo(self);
    }];
    
    self.baseLoginView = [[BaseLoginView alloc] initWithLoginType:kLoginTypeOfLogin];
    [self addSubview:self.baseLoginView];
    
    self.telephoneTextField = self.baseLoginView.firstTextField;
    self.passwordTextField = self.baseLoginView.secondTextField;
    self.captchaTextField = self.baseLoginView.thirdTextField;
    self.captchaButton = self.baseLoginView.captchaButton;
    
    [self.baseLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.width.left.equalTo(self);
        make.height.equalTo(@240);
    }];
    
    [self addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.width.equalTo(self);
        make.height.equalTo(@(kAdaptiveBaseIphone6(100)));
    }];
}

- (void)addNotifications
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)didChange:(NSNotification *)notification
{
    BOOL enabled = self.telephoneTextField.text.length && self.passwordTextField.text.length;
    if (!self.captchaTextField.hidden) {
        enabled = enabled && self.captchaTextField.text.length;
    }
    self.baseLoginView.loginFooterView.topButton.enabled = enabled;
}

#pragma mark - getter methods
- (UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        
        UIImageView * iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [_headerView addSubview:iconImageView];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_headerView);
            make.top.equalTo(@(kAdaptiveBaseIphone6(30)));
        }];
    }
    return _headerView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [[UIView alloc] init];
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"可使用领投鸟账户进行登录";
        titleLabel.font = kFont16;
        titleLabel.textColor = kHexColor(0xd8d8d8);
        [titleLabel sizeToFit];
        [_footerView addSubview:titleLabel];
        
        UIView * leftLine = [[UIView alloc] init];
        leftLine.backgroundColor = kHexColor(0xd8d8d8);
        [_footerView addSubview:leftLine];
        
        UIView * rightLine = [[UIView alloc] init];
        rightLine.backgroundColor = kHexColor(0xd8d8d8);
        [_footerView addSubview:rightLine];
        
        
        
        UIImageView * iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo2"]];
        [_footerView addSubview:iconImageView];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.equalTo(_footerView);
        }];
        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleLabel.mas_left).offset(-14);
            make.width.equalTo(@[rightLine, @41]);
            make.centerY.equalTo(@[rightLine, titleLabel]);
            make.height.equalTo(@[rightLine, @(kLineThick)]);
        }];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(14);
        }];
        
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom).offset(16);
            make.centerX.equalTo(titleLabel);
        }];
    }
    return _footerView;
}

#pragma mark - setter methods
- (void)setLoginClickBlock:(void (^)(UIButton *))loginClickBlock
{
    _loginClickBlock = loginClickBlock;
    if (loginClickBlock) {
        self.baseLoginView.topClickBlock = loginClickBlock;
    }
}

- (void)setRegisterClickBlock:(void (^)(UIButton *))registerClickBlock
{
    _registerClickBlock = registerClickBlock;
    if (registerClickBlock) {
        self.baseLoginView.rightClickBlock = registerClickBlock;
    }
}

- (void)setForgetClickBlock:(void (^)(UIButton *))forgetClickBlock
{
    _forgetClickBlock = forgetClickBlock;
    if (forgetClickBlock) {
        self.baseLoginView.leftClickBlock = forgetClickBlock;
    }
}

- (void)setGetCaptchaClickBlock:(void (^)(UIButton *))getCaptchaClickBlock
{
    _getCaptchaClickBlock = getCaptchaClickBlock;
    if (getCaptchaClickBlock) {
        self.baseLoginView.getCaptchaClickBlock = getCaptchaClickBlock;
    }
}

- (void)setShowCaptchDialog:(BOOL)showCaptchDialog
{
    if (_showCaptchDialog == showCaptchDialog) {
        return;
    }
    _showCaptchDialog = showCaptchDialog;
    self.baseLoginView.showThirdDialog = showCaptchDialog;
}

@end
