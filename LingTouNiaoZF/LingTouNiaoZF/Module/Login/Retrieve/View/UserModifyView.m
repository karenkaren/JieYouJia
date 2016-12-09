//
//  UserModifyView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/28.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "UserModifyView.h"
#import "BaseLoginView.h"

@interface UserModifyView ()<UITextFieldDelegate>

@property (nonatomic, strong) BaseLoginView * baseLoginView;

@end

@implementation UserModifyView

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
    self.baseLoginView = [[BaseLoginView alloc] initWithLoginType:kLoginTypeOfModify];
    [self addSubview:self.baseLoginView];
    
    self.passwordTextField = self.baseLoginView.firstTextField;
    self.passwordAgainTextField = self.baseLoginView.secondTextField;
    
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
    BOOL enabled = self.passwordTextField.text.length && self.passwordAgainTextField.text.length;
    self.baseLoginView.loginFooterView.topButton.enabled = enabled;
}

#pragma mark - setter methods
- (void)setModifyClickBlock:(void (^)(UIButton *))modifyClickBlock
{
    _modifyClickBlock = modifyClickBlock;
    if (modifyClickBlock) {
        self.baseLoginView.loginFooterView.topClickBlock = modifyClickBlock;
    }
}

@end
