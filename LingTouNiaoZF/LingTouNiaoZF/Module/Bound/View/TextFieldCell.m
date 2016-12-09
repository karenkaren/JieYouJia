//
//  TextFieldCell.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "TextFieldCell.h"

@interface TextFieldCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView * customAccessoryView;

@end

@implementation TextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = kFont12;
        [self.contentView addSubview:self.textField];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, kCommonMargin));
        }];
    }
    return self;
}

- (CustomTextField *)textField
{
    if (!_textField) {
        _textField = [[CustomTextField alloc] initWithLeftTitle:@"haha" placeHolder:nil];
        _textField.contentMode = UIViewContentModeLeft;
        _textField.leftLabel.font = kFont14;
        _textField.font = kFont14;
        _textField.textColor = kDarkColor333333;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
//        [_textField addTarget:self action:@selector(textFieldDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
//        [_textField addTarget:self action:@selector(textFieldDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return _textField;
}

- (void)setCellDic:(NSDictionary *)cellDic
{
    _cellDic=cellDic;
    
    if(esBool(cellDic[@"showAccess"])){
        self.accessoryView = self.customAccessoryView;
    }else{
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if(esBool(cellDic[@"canEdit"])){
        self.textField.userInteractionEnabled = YES;
    }else{
        self.textField.userInteractionEnabled = NO;
    }
    self.textField.leftLabel.text = cellDic[@"title"];
    self.textField.placeholder = cellDic[@"placeholder"];
    if([cellDic[@"key"] isEqualToString:kBankPhoneNo] || [cellDic[@"key"] isEqualToString:kBankCardNo]){
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
    }
}


- (void)textFieldDidChange:(UITextField *)textField
{
    NSString * textString = textField.text;
    if ([_cellDic[@"key"] isEqualToString:kBankCardNo]) {
        textString = [textString stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString * newString = @"";
        while (textString.length > 0) {
            NSString * subString = [textString substringToIndex:MIN(textString.length, 4)];
            newString = [newString stringByAppendingString:subString];
            textString = [textString substringFromIndex:MIN(textString.length, 4)];
            if (textString.length) {
                newString = [newString stringByAppendingString:@" "];
            }
        }
        textField.text = newString;
    }
    textString = textField.text;
    if(_textFieldTextChangeBlock)
        _textFieldTextChangeBlock(textString);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if([_cellDic[@"key"] isEqualToString:kBankName]){
        return NO;
    }
    NSString * shouldText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger maxLength = esInteger(_cellDic[@"maxLength"]);
    NSInteger strLength = shouldText.length;
    if (strLength > maxLength) {
        // 允许删除
        if (strLength < textField.text.length) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (UIView *)customAccessoryView
{
    if (!_customAccessoryView) {
        _customAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xiangqing"]];
    }
    return _customAccessoryView;
}

@end
