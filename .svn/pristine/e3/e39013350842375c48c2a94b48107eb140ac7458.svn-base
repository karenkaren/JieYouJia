//
//  BoundFailureController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BoundFailureController.h"
#import "BoundFailureView.h"

@interface BoundFailureController ()

@end

@implementation BoundFailureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名绑卡失败";
    [self initNavigationBar];
    [self buildUI];
}

- (void)initNavigationBar
{
    UIButton * completeButton = [UIButton createButtonWithTitle:@"完成" color:kHexColor(0x444444) font:kFont14 block:^(UIButton *button) {
        
    }];
    completeButton.width = 58;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:completeButton];
}

- (void)buildUI
{
    BoundFailureView * failureView = [[BoundFailureView alloc] initWithFailureReason:@"您的身份证已过期"];
    [self.view addSubview:failureView];
    
    [failureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
