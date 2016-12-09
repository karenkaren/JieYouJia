//
//  BankModel.m
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/8.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel

+ (void)geBankListWithShowError:(BOOL)show block:(APIResultDataBlock)block
{
    [[NetAPIManager sharedNetAPIManager] requestWithPath:pay_bankList params:nil methodType:Get autoShowError:show block:^(id response, NSError *error) {
        BaseDto * dto = [BaseDto mj_objectWithKeyValues:response];
        NSArray * bankList = [BankModel mj_objectArrayWithKeyValuesArray:dto.data];
        if (block) {
            block(response, bankList, error);
        }
    }];
}

@end
