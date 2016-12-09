//
//  BaseLoginView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseLoginView.h"

#define kTextFieldHeight kAdaptiveBaseIphone6(46)
#define kMargin kAdaptiveBaseIphone6(37)

@interface BaseLoginView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView * passwordView;
@property (nonatomic, strong) UIView * passwordAgainView;
@property (nonatomic, strong) UIView * captchaView;

@property (nonatomic, strong) CustomTextField * telephoneTextField;
@property (nonatomic, strong) CustomTextField * passwordTextField;
@property (nonatomic, strong) CustomTextField * passwordAgainTextField;
@property (nonatomic, strong) CustomTextField * captchaTextField;
@property (nonatomic, strong) CustomTextField * identityTextField;

@property (nonatomic, copy) NSString * telephonePlaceHolder;
@property (nonatomic, copy) NSString * passwordPlaceHolder;
@property (nonatomic, copy) NSString * passwordAgainPlaceHolder;
@property (nonatomic, copy) NSString * captchaPlaceHolder;
@property (nonatomic, copy) NSString * identityPlaceHolder;
@property (nonatomic, copy) NSString * topTitle;
@property (nonatomic, copy) NSString * leftTitle;
@property (nonatomic, copy) NSString * rightTitle;

@property (nonatomic, assign) LoginType loginType;

@end

@implementation BaseLoginView

#pragma mark - override
- (instancetype)initWithLoginType:(LoginType)loginType
{
    self = [super init];
    if (self) {
        self.loginType = loginType;
        [self initData];
        [self buildUI];
    }
    return self;
}

- (void)initData
{
    switch (self.loginType) {
        case kLoginTypeOfLogin:
            self.telephonePlaceHolder = @"请输入手机号／领投鸟账号";
            self.passwordPlaceHolder = @"请输入密码";
            self.captchaPlaceHolder = @"请输入验证码";
            self.topTitle = @"登录";
            self.leftTitle = @"忘记登录密码";
            self.rightTitle = @"还没账号注册";
            break;
        case kLoginTypeOfRegister:
            self.telephonePlaceHolder = @"推荐使用银行预留手机号";
            self.passwordPlaceHolder = @"请设置密码(6-18数字/字母组合)";
            self.captchaPlaceHolder = @"请输入短信验证码";
            self.topTitle = @"完成注册";
            self.rightTitle = @"已有账号，去登录";
            break;
        case kLoginTypeOfRetrieve:
            self.telephonePlaceHolder = @"请输入手机号";
            self.captchaPlaceHolder = @"请输入短信验证码";
            self.identityPlaceHolder = @"请输入身份证号";
            self.topTitle = @"下一步";
            break;
        case kLoginTypeOfModify:
            self.passwordPlaceHolder = @"请设置新密码(6-18位数字与字母组合)";
            self.passwordAgainPlaceHolder = @"请重复新密码";
            self.topTitle = @"确定";
            break;
        case kLoginTypeOfCaptcha:
            self.captchaPlaceHolder = @"请输入短信验证码";
            self.topTitle = @"下一步";
            break;
            
        default:
            break;
    }
}

#pragma mark - private methods
- (void)buildUI
{
    switch (self.loginType) {
        case kLoginTypeOfLogin:
            [self addAllSubviewsOfLogin];
            break;
        case kLoginTypeOfRegister:
            [self addAllSubviewsOfRegister];
            break;
        case kLoginTypeOfRetrieve:
            [self addAllSubviewsOfRetrieve];
            break;
        case kLoginTypeOfModify:
            [self addAllSubviewsOfModify];
            break;
        case kLoginTypeOfCaptcha:
//            [self addAllSubviewsOfCaptcha];
            break;
        default:
            break;
    }
    
    // 登录按钮
    [self addSubview:self.loginFooterView];
    UITextField * textField = self.thirdTextField ?: self.secondTextField;
    UIView * referView = [textField.superview isKindOfClass:[BaseLoginView class]] ? textField : textField.superview;
    [self.loginFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(referView.mas_bottom).offset(19);
        make.left.width.equalTo(referView);
        make.height.equalTo(@(self.loginFooterView.maxHeight));
    }];
}

//- (void)addAllSubviewsOfCaptcha
//{
//    [self addSubview:self.captchaView];
//    self.firstTextField = self.captchaTextField;
//    
//    // 验证码
//    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.width.height.left.equalTo(self.telephoneTextField);
////        make.top.equalTo(self.telephoneTextField.mas_bottom);
//        make.width.equalTo(self).offset(-2 * kCommonMargin);
//        make.top.equalTo(self);
//        make.height.equalTo(@(kTextFieldHeight));
//        make.left.equalTo(@(kMargin));
//    }];
//}

- (void)addAllSubviewsOfModify
{
    [self addSubview:self.passwordTextField];
    [self addSubview:self.passwordAgainTextField];
    self.firstTextField = self.passwordTextField;
    self.secondTextField = self.passwordAgainTextField;
    
    // 新密码
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-2 * kMargin);
        make.top.equalTo(self).offset(25);
        make.height.equalTo(@(kTextFieldHeight));
        make.left.equalTo(@(kMargin));
    }];
    
    // 再次新密码
    [self.passwordAgainTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(self.passwordTextField);
        make.top.equalTo(self.passwordTextField.mas_bottom);
    }];
}

- (void)addAllSubviewsOfRetrieve
{
    [self addSubview:self.telephoneTextField];
    [self addSubview:self.captchaView];
    [self insertSubview:self.identityTextField belowSubview:self.captchaView];
    self.firstTextField = self.telephoneTextField;
    self.secondTextField = self.captchaTextField;
    self.thirdTextField = self.identityTextField;
    
    // 手机号
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-2 * kMargin);
        make.height.equalTo(@(kTextFieldHeight));
        make.top.equalTo(@25);
        make.left.equalTo(@(kMargin));
    }];
    
    // 验证码
    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(self.telephoneTextField);
        make.top.equalTo(self.telephoneTextField.mas_bottom);
    }];
    
    // 身份证
    self.identityTextField.hidden = YES;
    [self.identityTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.captchaView);
    }];
}

- (void)addAllSubviewsOfLogin
{
    [self addSubview:self.telephoneTextField];
    [self addSubview:self.passwordView];
    [self insertSubview:self.captchaView belowSubview:self.passwordView];
    self.firstTextField = self.telephoneTextField;
    self.secondTextField = self.passwordTextField;
    self.thirdTextField = self.captchaTextField;
    
    // 手机号
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-2 * kMargin);
        make.height.equalTo(@(kTextFieldHeight));
        make.top.equalTo(self);
        make.left.equalTo(@(kMargin));
    }];
    
    // 密码
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(self.telephoneTextField);
        make.top.equalTo(self.telephoneTextField.mas_bottom);
    }];
    
    // 验证码
    self.captchaView.hidden = YES;
    self.captchaTextField.hidden = YES;
    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.passwordView);
    }];
}

- (void)addAllSubviewsOfRegister
{
    [self addSubview:self.telephoneTextField];
    [self addSubview:self.passwordView];
    [self addSubview:self.captchaView];
    self.firstTextField = self.telephoneTextField;
    self.secondTextField = self.passwordTextField;
    self.thirdTextField = self.captchaTextField;
    
    // 手机号
    [self.telephoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).offset(-2 * kMargin);
        make.height.equalTo(@(kTextFieldHeight));
        make.top.equalTo(@25);
        make.left.equalTo(@(kMargin));
    }];
    
    // 密码
    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(self.telephoneTextField);
        make.top.equalTo(self.telephoneTextField.mas_bottom);
    }];
    
    // 验证码
    [self.captchaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(self.passwordView);
        make.top.equalTo(self.passwordView.mas_bottom);
    }];
}

#pragma mark - getter methods
- (CustomTextField *)telephoneTextField
{
    if (!_telephoneTextField) {
        _telephoneTextField = [[CustomTextField alloc] initWithLeftIconName:@"shoujihao" placeHolder:self.telephonePlaceHolder];
        _telephoneTextField.drawBottomLine = YES;
        _telephoneTextField.limitedCount = 11;
        _telephoneTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _telephoneTextField.delegate = self;
    }
    return _telephoneTextField;
}

- (CustomTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[CustomTextField alloc] initWithLeftIconName:@"mima" placeHolder:self.passwordPlaceHolder];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.drawBottomLine = YES;
        _passwordTextField.limitedCount = 18;
//        _passwordTextField.delegate = self;
    }
    return _passwordTextField;
}

- (CustomTextField *)passwordAgainTextField
{
    if (!_passwordAgainTextField) {
        _passwordAgainTextField = [[CustomTextField alloc] initWithLeftIconName:@"yanzhengma" placeHolder:self.passwordAgainPlaceHolder];
        _passwordAgainTextField.secureTextEntry = YES;
        _passwordAgainTextField.drawBottomLine = YES;
        _passwordAgainTextField.limitedCount = 18;
//        _passwordAgainTextField.delegate = self;
    }
    return _passwordAgainTextField;
}

- (CustomTextField *)captchaTextField
{
    if (!_captchaTextField) {
        _captchaTextField = [[CustomTextField alloc] initWithLeftIconName:@"yanzhengma" placeHolder:self.captchaPlaceHolder];
        _captchaTextField.drawBottomLine = YES;
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
//        _captchaTextField.delegate = self;
    }
    return _captchaTextField;
}

- (CustomTextField *)identityTextField
{
    if (!_identityTextField) {
        _identityTextField = [[CustomTextField alloc] initWithLeftIconName:@"shenfenzheng" placeHolder:self.identityPlaceHolder];
        _identityTextField.drawBottomLine = YES;
        _identityTextField.limitedCount = 18;
//        _identityTextField.delegate = self;
    }
    return _identityTextField;
}

- (UIView *)passwordView
{
    if (!_passwordView) {
        _passwordView = [[UIView alloc] init];
        [self passwordView:_passwordView constraintOfTextField:self.passwordTextField];

    }
    return _passwordView;
}

- (UIView *)passwordAgainView
{
    if (!_passwordAgainView) {
        _passwordAgainView = [[UIView alloc] init];
        [self passwordView:_passwordAgainView constraintOfTextField:self.passwordAgainTextField];
    }
    return _passwordAgainView;
}

- (void)passwordView:(UIView *)passwordView constraintOfTextField:(CustomTextField *)passwordTextField
{
    passwordView.backgroundColor = [UIColor whiteColor];
    [passwordView addSubview:passwordTextField];
    UIButton * hidenButton = [UIButton createButtonWithNomalIconName:@"yanjing" selectedIconName:@"yanjing2" block:^(UIButton * button) {
        passwordTextField.secureTextEntry = button.selected;
        button.selected = !button.selected;
    }];
    [passwordView addSubview:hidenButton];
    
    UIView * bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = kLineColorD8D8D8;
    [passwordView addSubview:bottomLine];
    
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(passwordView).offset(-22);
        make.top.left.height.equalTo(passwordView);
    }];
    [hidenButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(passwordTextField.mas_height);
        make.width.equalTo(@22);
        make.top.right.equalTo(passwordView);
    }];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.bottom.equalTo(hidenButton);
        make.height.equalTo(@(kLineThick));
    }];
}

- (UIView *)captchaView
{
    if (!_captchaView) {
        _captchaView = [[UIView alloc] init];
        _captchaView.backgroundColor = [UIColor whiteColor];
        [_captchaView addSubview:self.captchaTextField];
        
        if (self.loginType == kLoginTypeOfLogin) {
            self.captchaTextField.limitedCount = 4;
            self.captchaButton = [UIButton createButtonWithFrame:CGRectZero iconName:@"shuaxinzhanwei" block:^(UIButton *button) {
                if (self.getCaptchaClickBlock) {
                    self.getCaptchaClickBlock(button);
                }
            }];
        } else {
            self.captchaTextField.limitedCount = 6;
            self.captchaButton = [UIButton createButtonWithTitle:@"获取短信验证码" color:kHexColor(0x288bff) font:kFont12 block:^(UIButton * button) {
                if (self.getCaptchaClickBlock) {
                    self.getCaptchaClickBlock(button);
                }
            }];
            [self.captchaButton setTitleColor:kDarkColorADADAD forState:UIControlStateDisabled];
        }
        [_captchaView addSubview:self.captchaButton];
        
        UIView * bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = kLineColorD8D8D8;
        [_captchaView addSubview:bottomLine];
        
        UIView * verticalLine = [[UIView alloc] init];
        verticalLine.backgroundColor = kLineColorD8D8D8;
        [_captchaView addSubview:verticalLine];
        
        CGFloat captchaButtonWidth;
        if (self.loginType == kLoginTypeOfLogin) {
            captchaButtonWidth = 50;
        } else {
            captchaButtonWidth = 100;
        }
        [self.captchaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(_captchaView).offset(-captchaButtonWidth);
            make.top.left.height.equalTo(_captchaView);
        }];
        [self.captchaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.captchaTextField);
            make.width.equalTo(@(captchaButtonWidth));
            make.top.right.equalTo(_captchaView);
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.left.bottom.equalTo(self.captchaButton);
            make.height.equalTo(@(kLineThick));
        }];
        [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.equalTo(self.captchaButton);
            make.width.equalTo(@(kLineThick));
            make.height.equalTo(_captchaView).offset(-20);
        }];
    }
    return _captchaView;
}

- (LoginFooterView *)loginFooterView
{
    if (!_loginFooterView) {
        _loginFooterView = [[LoginFooterView alloc] initWithTitle:self.topTitle leftTitle:self.leftTitle rightTitle:self.rightTitle];
        _loginFooterView.topButton.enabled = NO;
    }
    return _loginFooterView;
}

#pragma mark - setter methods
- (void)setTopClickBlock:(void (^)(UIButton *))topClickBlock
{
    _topClickBlock = topClickBlock;
    if (topClickBlock) {
        _loginFooterView.topClickBlock = topClickBlock;
    }
}

- (void)setLeftClickBlock:(void (^)(UIButton *))leftClickBlock
{
    _leftClickBlock = leftClickBlock;
    if (leftClickBlock) {
        _loginFooterView.leftClickBlock = leftClickBlock;
    }
}

- (void)setRightClickBlock:(void (^)(UIButton *))rightClickBlock
{
    _rightClickBlock = rightClickBlock;
    if (rightClickBlock) {
        _loginFooterView.rightClickBlock = rightClickBlock;
    }
}

- (void)setShowThirdDialog:(BOOL)showThirdDialog
{
    if (_showThirdDialog == showThirdDialog) {
        return;
    }
    _showThirdDialog = showThirdDialog;
    if (showThirdDialog) {
        UIView * referView = [self.thirdTextField.superview isKindOfClass:[BaseLoginView class]] ? self.thirdTextField : self.thirdTextField.superview;
        UIView * secondView = [self.secondTextField.superview isKindOfClass:[BaseLoginView class]] ? self.secondTextField : self.secondTextField.superview;
        referView.hidden = NO;
        self.captchaTextField.hidden = NO;
        self.loginFooterView.topButton.enabled = NO;
        [UIView animateWithDuration:0.25f animations:^{
            referView.top = secondView.bottom;
            self.loginFooterView.top = referView.bottom + 10;
        }];
    }
}

@end
