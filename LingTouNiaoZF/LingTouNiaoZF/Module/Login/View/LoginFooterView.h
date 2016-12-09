//
//  LoginFooterView.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/22.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginFooterView : UIView

- (instancetype)initWithTitle:(NSString *)title leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle;

@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, strong) UIButton * topButton;

@property (nonatomic, copy) void(^topClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^leftClickBlock)(UIButton *button);
@property (nonatomic, copy) void(^rightClickBlock)(UIButton *button);

@end
