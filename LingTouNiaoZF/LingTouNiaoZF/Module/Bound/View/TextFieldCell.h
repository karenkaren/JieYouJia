//
//  TextFieldCell.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/5.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTextField.h"

#define kRealName @"realName"
#define kIDCardNo @"idCardNo"
#define kBankName @"bankCode"
#define kBankCardNo @"bankCardNo"
#define kBankPhoneNo @"mobile"

#define kTextFieldCellHeight 45

@interface TextFieldCell : UITableViewCell

@property (nonatomic,strong) NSDictionary * cellDic;
@property (nonatomic,strong) CustomTextField * textField;
@property (nonatomic,copy) void(^textFieldTextChangeBlock)(NSString *text);

@end
