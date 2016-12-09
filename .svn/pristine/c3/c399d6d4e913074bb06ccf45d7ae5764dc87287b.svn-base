//
//  BankModel.h
//  LingTouNiaoZF
//
//  Created by LiuFeifei on 16/12/8.
//  Copyright © 2016年 LiuJie. All rights reserved.
//

#import "BaseModel.h"

@interface BankModel : BaseModel

//@property (nonatomic, copy) NSString * bankName;    // 银行名称
//@property (nonatomic, copy) NSString * cardId;  // 银行卡后4位
//@property (nonatomic, copy) NSString * dateLimit;   // 单日限额, 原类型为number
//@property (nonatomic, copy) NSString * gateId;   // 银行代码
//@property (nonatomic, assign) NSInteger ID; // 用户绑定的银行卡ID
//@property (nonatomic, copy) NSString * logoUrl; // 银行icon	string	@mock=http://120.55.184.234:8080/img/bank/gsyh.png
//@property (nonatomic, copy) NSString * timeLimit;   // 单次限额, 原类型为number

@property (nonatomic, copy) NSString * bankCode;    // 银行代码('BOC','ABC','SPDB','CIB','COMM','ICBC','CCB','CMBC','CITIC','CEB','CMB','SPAB')
@property (nonatomic, copy) NSString * bankName;    // 银行名称('中国银行','中国农业银行','浦发银行','兴业银行','交通银行','中国工商银行','中国建设银行','中国民生银行','中信银行','光大银行','招商银行','平安银行')
@property (nonatomic, copy) NSString * timeLimit;   // 单次限额, 原类型为number
@property (nonatomic, copy) NSString * dateLimit;   // 单日限额, 原类型为number
+ (void)geBankListWithShowError:(BOOL)show block:(APIResultDataBlock)block;

@end
