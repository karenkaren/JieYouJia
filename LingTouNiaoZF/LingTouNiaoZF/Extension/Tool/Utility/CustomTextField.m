//
//  CustomTextField.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/11/21.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField ()

@end

@implementation CustomTextField

#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle placeHolder:(NSString *)placeHolder
{
    CustomTextField * textField = [[CustomTextField alloc] initWithFrame:frame];
    textField.placeholder = esString(placeHolder);
    UILabel * leftTitleLabel = [[UILabel alloc] init];
    leftTitleLabel.text = esString(leftTitle);
    textField.leftView = leftTitleLabel;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftLabel = leftTitleLabel;
    return textField;
}

- (instancetype)initWithFrame:(CGRect)frame leftIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder
{
    CustomTextField * textField = [[CustomTextField alloc] initWithFrame:frame];
    textField.placeholder = esString(placeHolder);
    UIImageView * leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:esString(iconName)]];
    leftImageView.contentMode = UIViewContentModeCenter;
    textField.leftView = leftImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}

- (instancetype)initWithLeftTitle:(NSString *)leftTitle placeHolder:(NSString *)placeHolder
{
    return [[CustomTextField alloc] initWithFrame:CGRectZero leftTitle:leftTitle placeHolder:placeHolder];
}

- (instancetype)initWithLeftIconName:(NSString *)iconName placeHolder:(NSString *)placeHolder
{
    return [[CustomTextField alloc] initWithFrame:CGRectZero leftIconName:iconName placeHolder:placeHolder];
}

#pragma mark - override
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineWidth = kLineThick;
        self.lineColor = kLineColorD8D8D8;
        self.textColor = kDarkColor333333;
        self.font = kFont14;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect frame = [super leftViewRectForBounds:bounds];
    if ([self.leftView isKindOfClass:[UILabel class]]) {
        frame.origin.x += kCommonMargin;
        frame.size.width = 88;
    } else if ([self.leftView isKindOfClass:[UIImageView class]]){
        frame.size.width = 32;
    }
    frame.size.height = bounds.size.height;
    return frame;
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect frame = [super textRectForBounds:bounds];
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        frame.origin.x += 5;
    }
    return frame;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect frame = [super editingRectForBounds:bounds];
    if ([self.leftView isKindOfClass:[UIImageView class]]) {
        frame.origin.x += 5;
    }
    return frame;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
    if (self.drawBottomLine) {
        CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - self.lineWidth, CGRectGetWidth(self.frame), self.lineWidth));
    }
    if (self.drawTopLine) {
        CGContextFillRect(context, CGRectMake(0, self.lineWidth * 0.5, CGRectGetWidth(self.frame), self.lineWidth));
    }
    if (self.drawLeftLine) {
        CGContextFillRect(context, CGRectMake(0, 0, self.lineWidth, CGRectGetHeight(self.frame)));
    }
    if (self.drawRightLine) {
        CGContextFillRect(context, CGRectMake(0, CGRectGetWidth(self.frame) - self.lineWidth, self.lineWidth, CGRectGetHeight(self.frame)));
    }
}

#pragma mark - setter methods
- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName : kDarkColorADADAD, NSFontAttributeName : kFont14}];
}

- (void)setLimitedCount:(NSUInteger)limitedCount
{
    _limitedCount = limitedCount;
    if (limitedCount) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setDrawTopLine:(BOOL)drawTopLine
{
    _drawTopLine = drawTopLine;
    [self setNeedsDisplay];
}

- (void)setDrawLeftLine:(BOOL)drawLeftLine
{
    _drawLeftLine = drawLeftLine;
    [self setNeedsDisplay];
}

- (void)setDrawBottomLine:(BOOL)drawBottomLine
{
    _drawBottomLine = drawBottomLine;
    [self setNeedsDisplay];
}

- (void)setDrawRightLine:(BOOL)drawRightLine
{
    _drawRightLine = drawRightLine;
    [self setNeedsDisplay];
}

#pragma mark - notification methods
- (void)textFieldTextDidChange:(UITextField *)textField
{
    if (self.text.length > self.limitedCount) {
        NSString * text = [self.text substringWithRange:NSMakeRange(0, self.limitedCount)];
        self.text = text;
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
