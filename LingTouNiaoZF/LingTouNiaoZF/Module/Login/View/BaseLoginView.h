//
//  BaseLoginView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/29.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"
#import "LoginFooterView.h"

typedef NS_ENUM(NSUInteger, LoginType) {
    kLoginTypeOfLogin,
    kLoginTypeOfRegister,
    kLoginTypeOfRetrieve,
    kLoginTypeOfModify,
    kLoginTypeOfCaptcha
};

@interface BaseLoginView : UIView

@property (nonatomic, strong) CustomTextField * firstTextField;
@property (nonatomic, strong) CustomTextField * secondTextField;
@property (nonatomic, strong) CustomTextField * thirdTextField;
@property (nonatomic, strong) LoginFooterView * loginFooterView;
@property (nonatomic, strong) UIButton * captchaButton;

@property (nonatomic, copy) void(^topClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^leftClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^rightClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^getCaptchaClickBlock)(UIButton *button);

@property (nonatomic, assign, getter=isShowThirdDialog) BOOL showThirdDialog;

- (instancetype)initWithLoginType:(LoginType)loginType;

@end
