//
//  MessageRemindView.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/24.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "MessageRemindView.h"

@interface MessageRemindView ()

@property (nonatomic, strong) UILabel * messageAmountLabel;
@property (nonatomic, assign) BOOL showCount;
@property (nonatomic, assign) CGFloat messageRedDiam;

@end

@implementation MessageRemindView

- (instancetype)initWithFrame:(CGRect)frame iconName:(NSString *)iconName target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.messageRedDiam = 8;
        self.showCount = NO;
        [self buildUIWithIconName:iconName target:target action:action];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame iconName:(NSString *)iconName countDiam:(CGFloat)countDiam target:(id)target action:(SEL)action
{
    self = [super initWithFrame:frame];
    if (self) {
        self.messageRedDiam = countDiam;
        self.showCount = YES;
        [self buildUIWithIconName:iconName target:target action:action];
    }
    return self;
}

- (void)buildUIWithIconName:(NSString *)iconName target:(nullable id)target action:(SEL)action
{
    // 消息中心按钮
    UIImage * messageImage = [[UIImage imageNamed:@"tixing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton * messageButton = [[UIButton alloc] init];
    [messageButton setImage:messageImage forState:UIControlStateNormal];
    [messageButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    messageButton.contentMode = UIViewContentModeCenter;
    [self addSubview:messageButton];
    
    CGFloat messageButtonSize = MIN(MAX(messageImage.size.width, messageImage.size.height), MIN(self.width, self.height));
    [messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(messageButtonSize, messageButtonSize));
    }];

    [messageButton addSubview:self.messageAmountLabel];
    self.messageAmountLabel.hidden = YES;
    [self.messageAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.messageRedDiam, self.messageRedDiam));
        make.centerY.equalTo(messageButton.mas_top).offset(5);
        make.centerX.equalTo(@(messageButtonSize - 15));
    }];
}

#pragma mark - getter methods
-(UILabel *)messageAmountLabel{
    if (!_messageAmountLabel) {
        _messageAmountLabel = [[UILabel alloc] init];
        _messageAmountLabel.textColor = [UIColor whiteColor];
        _messageAmountLabel.textAlignment = NSTextAlignmentCenter;
        _messageAmountLabel.backgroundColor = [UIColor redColor];
        _messageAmountLabel.layer.cornerRadius = self.messageRedDiam * 0.5;
        _messageAmountLabel.layer.masksToBounds = YES;
    }
    return _messageAmountLabel;
}

#pragma mark - setter methods
- (void)setMessageCount:(NSUInteger)messageCount
{
    _messageCount = messageCount;
    if (messageCount) {
        self.messageAmountLabel.hidden = NO;
        if (self.showCount) {
            self.messageAmountLabel.text = [NSString stringWithFormat:@"%ld", messageCount];
        }
    } else {
        self.messageAmountLabel.hidden = YES;
    }
}

- (void)setShowMessageRemind:(BOOL)showMessageRemind
{
    _showMessageRemind = showMessageRemind;
    self.messageCount = showMessageRemind ? !0 : 0;
}

@end
