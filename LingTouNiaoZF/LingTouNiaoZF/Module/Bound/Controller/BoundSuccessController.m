//
//  BoundSuccessController.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/6.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BoundSuccessController.h"
#import "ResultHeader.h"

@interface BoundSuccessController ()

@end

@implementation BoundSuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名绑卡成功";
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
    ResultHeader * successView = [ResultHeader createResultHeaderWithTitle:@"恭喜您，添加成功！" success:YES];
    [self.view addSubview:successView];
    
    [successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(@32);
    }];
}

@end
